// Logica achter `tool/api_contract.dart`: een statische scan van de
// API-aanroepen in `lib/` en het matchen daarvan tegen de v1-routes van
// vogels3. Losgetrokken van de CLI zodat `test/tool/api_contract_test.dart`
// hem zonder bestandssysteem kan testen.
//
// De scan is bewust simpel (regex + een kleine haakjesteller), afgestemd op
// hoe de repositories hun paden opbouwen:
//   _api.get('/teams/$teamId/agenda')
//   String _base(int teamId) => '/teams/$teamId/savings';
//   _api.post('${_base(teamId)}/$potId/remind')
//   final path = cond ? '…/a/$x' : '…/b/$y';  _api.patch(path, …)
//   _clock(teamId, eventId, 'extra-time', null) → '${_live(…)}/$action'
// Wat hij niet kan oplossen wordt een `{}`-segment; dat matcht alleen een
// routeparameter, dus een onoplosbaar vast segment valt op als fout.

/// Eén API-aanroep uit de app.
class ApiCall {
  const ApiCall(this.method, this.path, this.source);

  /// `GET`, `POST`, `PATCH`, `PUT` of `DELETE`.
  final String method;

  /// Genormaliseerd pad zonder `/api/v1`, zonder voorloop-slash; elke
  /// interpolatie is `{}` (bv. `teams/{}/events/{}/live/clock`).
  final String path;

  /// `bestand:regel`.
  final String source;

  @override
  String toString() => '$method /$path  ($source)';
}

/// Eén route uit vogels3.
class ApiRoute {
  const ApiRoute(this.methods, this.uri);

  /// Methodes van de route (`HEAD` meegerekend bij `GET`).
  final Set<String> methods;

  /// Uri zonder `api/v1/`, bv. `teams/{team}/events/{event}/live`.
  final String uri;

  @override
  String toString() => '${methods.join('|')} /$uri';
}

const _receivers = r'(?:_api|api|_client|client|_dio|dio)';
final _callPattern = RegExp(
  '\\b$_receivers\\.(get|post|patch|put|delete)(?:<[^>()]*(?:<[^>()]*>)?>)?\\(',
);
final _helperPattern = RegExp(
  r'(?:static\s+)?String\s+(_\w+)\(([^()]*)\)\s*=>\s*',
);

/// Alle API-aanroepen in één Dart-bestand.
List<ApiCall> scanDartSource(String source, {String file = ''}) {
  final text = _stripComments(source);
  final helpers = <String, _Helper>{};
  for (final m in _helperPattern.allMatches(text)) {
    final literal = _readExpression(text, m.end);
    if (!_isStringLiteral(literal.trim())) continue;
    helpers[m.group(1)!] = _Helper(_paramNames(m.group(2)!), literal.trim());
  }

  final calls = <ApiCall>[];
  for (final m in _callPattern.allMatches(text)) {
    final arg = _readExpression(text, m.end).trim();
    final line = '\n'.allMatches(text.substring(0, m.start)).length + 1;
    final where = '$file:$line';
    final method = m.group(1)!.toUpperCase();
    for (final path in _resolve(arg, text, m.start, helpers)) {
      // Volledig dynamisch (de wrapper in ApiClient zelf, een absolute
      // URL uit een API-antwoord): niet statisch te controleren.
      if (path == '{}' || path.isEmpty) continue;
      calls.add(ApiCall(method, path, where));
    }
  }
  return calls;
}

/// Matcht [calls] tegen [routes]; geeft de aanroepen zonder route terug.
List<ApiCall> unmatchedCalls(List<ApiCall> calls, List<ApiRoute> routes) => [
  for (final call in calls)
    if (!routes.any((r) => routeMatches(r, call))) call,
];

/// Of [route] de aanroep [call] bedient (methode + pad).
bool routeMatches(ApiRoute route, ApiCall call) {
  if (!route.methods.contains(call.method)) return false;
  final a = call.path.split('/');
  final b = route.uri.split('/');
  // Optionele laatste parameter (`{x?}`) mag ontbreken.
  if (b.length == a.length + 1 && b.last.endsWith('?}')) b.removeLast();
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    final isParam = b[i].startsWith('{');
    if (a[i] == '{}' || a[i].contains('{}')) {
      if (!isParam) return false;
    } else if (!isParam && a[i] != b[i]) {
      return false;
    }
  }
  return true;
}

/// Routes uit `php artisan route:list --json --path=api/v1`.
List<ApiRoute> routesFromRouteListJson(List<Object?> json) => [
  for (final entry in json.whereType<Map<String, Object?>>())
    if ((entry['uri'] as String? ?? '').startsWith('api/v1/'))
      ApiRoute(
        (entry['method'] as String).split('|').toSet(),
        (entry['uri'] as String).substring('api/v1/'.length),
      ),
];

/// Routes uit één PHP-routebestand, onder [prefix] (bv. `teams/{team}`).
/// Volgt `->prefix('x')…->group(function () { … })`-nesting.
List<ApiRoute> routesFromPhp(String php, {String prefix = ''}) {
  final routes = <ApiRoute>[];
  final routeCall = RegExp(
    r"""Route::(get|post|patch|put|delete)\(\s*['"]([^'"]*)['"]""",
  );
  final groupOpen = RegExp(r'->group\(\s*(?:static\s+)?(?:function|fn)\b');
  final prefixCall = RegExp(r"""prefix\(\s*['"]([^'"]*)['"]\s*\)""");

  // Stapel van (accoladediepte waarop de groep opende, prefix).
  final stack = <(int, String)>[];
  var depth = 0;
  var statementStart = 0;
  var i = 0;
  String current() => _joinPath([prefix, for (final (_, p) in stack) p]);

  while (i < php.length) {
    final c = php[i];
    if (c == "'" || c == '"') {
      i = _skipPhpString(php, i);
      continue;
    }
    if (php.startsWith('//', i) || php.startsWith('#', i)) {
      final end = php.indexOf('\n', i);
      i = end < 0 ? php.length : end;
      continue;
    }
    if (php.startsWith('/*', i)) {
      final end = php.indexOf('*/', i + 2);
      i = end < 0 ? php.length : end + 2;
      continue;
    }
    if (c == ';') statementStart = i + 1;
    if (c == '{') {
      depth++;
      final head = php.substring(statementStart, i);
      if (groupOpen.hasMatch(head) &&
          !stack.any((e) => e.$1 == depth && e.$2 == '#')) {
        final p = prefixCall.allMatches(head).map((m) => m.group(1)!);
        stack.add((depth, p.isEmpty ? '' : p.last));
      }
      statementStart = i + 1;
    } else if (c == '}') {
      while (stack.isNotEmpty && stack.last.$1 >= depth) {
        stack.removeLast();
      }
      depth--;
      statementStart = i + 1;
    } else {
      final m = routeCall.matchAsPrefix(php, i);
      if (m != null) {
        final methods = {m.group(1)!.toUpperCase()};
        if (methods.contains('GET')) methods.add('HEAD');
        routes.add(ApiRoute(methods, _joinPath([current(), m.group(2)!])));
        i = m.end;
        continue;
      }
    }
    i++;
  }
  return routes;
}

// ── intern ────────────────────────────────────────────────────────────────

class _Helper {
  const _Helper(this.params, this.literal);
  final List<String> params;
  final String literal;
}

String _joinPath(Iterable<String> parts) =>
    parts.expand((p) => p.split('/')).where((s) => s.isNotEmpty).join('/');

int _skipPhpString(String s, int i) {
  final quote = s[i];
  var j = i + 1;
  while (j < s.length && s[j] != quote) {
    if (s[j] == r'\') j++;
    j++;
  }
  return j + 1;
}

/// Haalt `//`-commentaar weg (niet binnen strings), regelnummers blijven.
String _stripComments(String source) {
  final out = StringBuffer();
  for (final line in source.split('\n')) {
    out.writeln(_stripLineComment(line));
  }
  return out.toString();
}

String _stripLineComment(String line) {
  String? quote;
  for (var i = 0; i < line.length; i++) {
    final c = line[i];
    if (quote != null) {
      if (c == r'\') {
        i++;
      } else if (c == quote) {
        quote = null;
      }
    } else if (c == "'" || c == '"') {
      quote = c;
    } else if (c == '/' && i + 1 < line.length && line[i + 1] == '/') {
      return line.substring(0, i);
    }
  }
  return line;
}

/// Leest één expressie vanaf [start] tot de eerste `,`, `)` of `;` op het
/// hoogste niveau (strings en `${…}` meegeteld).
String _readExpression(String text, int start) {
  var depth = 0;
  var i = start;
  while (i < text.length) {
    final c = text[i];
    if (c == "'" || c == '"') {
      i = _skipDartString(text, i);
      continue;
    }
    if (c == '(' || c == '[' || c == '{') depth++;
    if (c == ')' || c == ']' || c == '}') {
      if (depth == 0) break;
      depth--;
    }
    if ((c == ',' || c == ';') && depth == 0) break;
    i++;
  }
  return text.substring(start, i);
}

/// Index net na de string die op [i] begint (met `${…}`-nesting).
int _skipDartString(String s, int i) {
  final quote = s[i];
  var j = i + 1;
  while (j < s.length && s[j] != quote) {
    if (s[j] == r'\') {
      j += 2;
      continue;
    }
    if (s.startsWith(r'${', j)) {
      var depth = 1;
      j += 2;
      while (j < s.length && depth > 0) {
        if (s[j] == "'" || s[j] == '"') {
          j = _skipDartString(s, j);
          continue;
        }
        if (s[j] == '{') depth++;
        if (s[j] == '}') depth--;
        j++;
      }
      continue;
    }
    j++;
  }
  return j + 1;
}

bool _isStringLiteral(String expr) =>
    expr.length >= 2 &&
    (expr[0] == "'" || expr[0] == '"') &&
    _skipDartString(expr, 0) == expr.length;

/// Alle stringliterals op het hoogste niveau van [expr] (bv. beide takken
/// van een `?:`).
List<String> _topLevelLiterals(String expr) {
  final out = <String>[];
  var i = 0;
  while (i < expr.length) {
    if (expr[i] == "'" || expr[i] == '"') {
      final end = _skipDartString(expr, i);
      out.add(expr.substring(i, end));
      i = end;
    } else {
      i++;
    }
  }
  return out;
}

List<String> _paramNames(String params) {
  // Generics eerst weg, anders splitst `Map<String, Object?>` op de komma.
  var flat = params.replaceAll(RegExp(r'[{}\[\]]'), '');
  final generic = RegExp(r'<[^<>]*>');
  while (generic.hasMatch(flat)) {
    flat = flat.replaceAll(generic, '');
  }
  return [
    for (final p in flat.split(','))
      if (p.trim().isNotEmpty)
        p.split('=').first.trim().split(RegExp(r'\s+')).last,
  ];
}

List<String> _splitArgs(String args) {
  final out = <String>[];
  var depth = 0;
  var start = 0;
  var i = 0;
  while (i < args.length) {
    final c = args[i];
    if (c == "'" || c == '"') {
      i = _skipDartString(args, i);
      continue;
    }
    if (c == '(' || c == '[' || c == '{') depth++;
    if (c == ')' || c == ']' || c == '}') depth--;
    if (c == ',' && depth == 0) {
      out.add(args.substring(start, i).trim());
      start = i + 1;
    }
    i++;
  }
  final last = args.substring(start).trim();
  if (last.isNotEmpty) out.add(last);
  return out;
}

/// Alle mogelijke paden voor het eerste argument [arg] van een aanroep.
List<String> _resolve(
  String arg,
  String text,
  int callPos,
  Map<String, _Helper> helpers,
) {
  final List<String> templates;
  if (_isStringLiteral(arg)) {
    templates = [arg];
  } else if (RegExp(r'^_\w+\(').hasMatch(arg)) {
    templates = ['"\${$arg}"'];
  } else if (RegExp(r'^\w+$').hasMatch(arg)) {
    // Lokale variabele: de laatste toewijzing ervóór.
    final assign = RegExp(
      '(?:final|var|String)\\s+$arg\\s*=',
    ).allMatches(text.substring(0, callPos));
    if (assign.isEmpty) return ['{}'];
    final rhsStart = assign.last.end;
    final rhsEnd = text.indexOf(';', rhsStart);
    final rhs = text.substring(rhsStart, rhsEnd < 0 ? callPos : rhsEnd);
    final literals = _topLevelLiterals(rhs);
    templates = literals.isEmpty ? ['"\${${rhs.trim()}}"'] : literals;
  } else {
    templates = ['{}'];
  }

  final paramValues = _enclosingParamValues(text, callPos);
  final out = <String>{};
  for (final t in templates) {
    out.addAll(_expand(t, helpers, const {}, paramValues));
  }
  return [
    for (final p in out) _joinPath([p.split('?').first]),
  ];
}

/// Voor `$param` uit de omsluitende privéfunctie: de stringliterals waarmee
/// die functie elders in het bestand wordt aangeroepen.
Map<String, List<String>> _enclosingParamValues(String text, int callPos) {
  final defs = RegExp(
    r'(_\w+)\(([^()]*)\)\s*(?:async\s*)?(?:=>|\{)',
  ).allMatches(text.substring(0, callPos));
  if (defs.isEmpty) return const {};
  final def = defs.last;
  final name = def.group(1)!;
  final params = _paramNames(def.group(2)!);
  final values = <String, List<String>>{};
  for (final call in RegExp('\\b$name\\(').allMatches(text)) {
    if (call.start == def.start) continue;
    final open = call.end;
    // Lees de argumentlijst tot de sluitende haak.
    var depth = 1;
    var i = open;
    while (i < text.length && depth > 0) {
      final c = text[i];
      if (c == "'" || c == '"') {
        i = _skipDartString(text, i);
        continue;
      }
      if (c == '(') depth++;
      if (c == ')') depth--;
      i++;
    }
    final args = _splitArgs(text.substring(open, i - 1));
    for (var k = 0; k < args.length && k < params.length; k++) {
      if (_isStringLiteral(args[k])) {
        values.putIfAbsent(params[k], () => []).add(args[k]);
      }
    }
  }
  return values;
}

/// Vult een stringliteral in: helpers worden uitgeklapt, bekende
/// stringparameters ingevuld, de rest wordt `{}`.
Set<String> _expand(
  String literal,
  Map<String, _Helper> helpers,
  Map<String, String> bound,
  Map<String, List<String>> paramValues, [
  int depth = 0,
]) {
  if (literal == '{}') return {'{}'};
  final body = literal.substring(1, literal.length - 1);
  var results = <String>{''};
  var i = 0;
  void append(Iterable<String> parts) {
    results = {
      for (final r in results)
        for (final p in parts) '$r$p',
    };
  }

  while (i < body.length) {
    if (body.startsWith(r'${', i)) {
      // Zoek de bijbehorende `}`.
      var d = 1;
      var j = i + 2;
      while (j < body.length && d > 0) {
        if (body[j] == '{') d++;
        if (body[j] == '}') d--;
        j++;
      }
      final expr = body.substring(i + 2, j - 1).trim();
      append(_expandExpr(expr, helpers, bound, paramValues, depth));
      i = j;
    } else if (body[i] == r'$') {
      final m = RegExp(r'\w+').matchAsPrefix(body, i + 1);
      final name = m?.group(0) ?? '';
      append(_expandExpr(name, helpers, bound, paramValues, depth));
      i = m?.end ?? i + 1;
    } else if (body[i] == r'\') {
      append([body[i + 1]]);
      i += 2;
    } else {
      append([body[i]]);
      i++;
    }
  }
  return results;
}

Iterable<String> _expandExpr(
  String expr,
  Map<String, _Helper> helpers,
  Map<String, String> bound,
  Map<String, List<String>> paramValues,
  int depth,
) {
  if (bound.containsKey(expr)) return [bound[expr]!];
  final values = paramValues[expr];
  if (values != null && values.isNotEmpty) {
    return {
      for (final v in values)
        ..._expand(v, helpers, bound, const {}, depth + 1),
    };
  }
  final call = RegExp(r'^(_\w+)\((.*)\)$', dotAll: true).firstMatch(expr);
  if (call != null && depth < 8) {
    final helper = helpers[call.group(1)!];
    if (helper != null) {
      // Argumenten die zelf stringliterals zijn worden doorgegeven; de
      // rest blijft een parameter (`{}`).
      final args = _splitArgs(call.group(2)!);
      final inner = <String, String>{};
      for (var k = 0; k < args.length && k < helper.params.length; k++) {
        if (_isStringLiteral(args[k])) {
          inner[helper.params[k]] = args[k].substring(1, args[k].length - 1);
        }
      }
      return _expand(helper.literal, helpers, inner, const {}, depth + 1);
    }
  }
  return ['{}'];
}
