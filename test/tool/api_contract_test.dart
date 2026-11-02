import 'package:flutter_test/flutter_test.dart';

import '../../tool/api_contract_scan.dart';

void main() {
  group('scanDartSource', () {
    test('lost padhelpers, variabelen en stringparameters op', () {
      const source = r'''
class Repo {
  static String _event(int teamId, int eventId) =>
      '/teams/$teamId/events/$eventId';
  String _base(int teamId) => '/teams/$teamId/savings'; // commentaar

  Future<void> a() => _api.get('/me');
  Future<void> b() => _api.post('${_base(teamId)}/$potId/remind');
  Future<void> c() async {
    final path = staff
        ? '${_event(teamId, eventId)}/attendance/staff/${row.userId}'
        : '${_event(teamId, eventId)}/attendance/${row.playerId}';
    await _api.patch(path, data: {});
  }
  Future<void> stop() => _clock(teamId, eventId, 'stop', null);
  Future<void> _clock(int t, int e, String action, Map<String, Object?>? b) =>
      _api.post('${_event(t, e)}/live/$action');
  Future<void> dyn(String url) => _dio.get<List<int>>(url);
}
''';
      final calls = scanDartSource(source).map((c) => '${c.method} ${c.path}');
      expect(calls, [
        'GET me',
        'POST teams/{}/savings/{}/remind',
        'PATCH teams/{}/events/{}/attendance/staff/{}',
        'PATCH teams/{}/events/{}/attendance/{}',
        'POST teams/{}/events/{}/live/stop',
      ]);
    });
  });

  group('routeMatches', () {
    const route = ApiRoute({'POST'}, 'teams/{team}/events/{event}/live/stop');

    test('parameter matcht {}, vast segment moet gelijk zijn', () {
      expect(
        routeMatches(
          route,
          const ApiCall('POST', 'teams/{}/events/{}/live/stop', ''),
        ),
        isTrue,
      );
      expect(
        routeMatches(
          route,
          const ApiCall('POST', 'teams/{}/events/{}/live/{}', ''),
        ),
        isFalse,
      );
      expect(
        routeMatches(
          route,
          const ApiCall('GET', 'teams/{}/events/{}/live/stop', ''),
        ),
        isFalse,
      );
    });
  });

  group('routesFromPhp', () {
    test('volgt prefix-groepen en negeert accolades in strings', () {
      const php = r"""<?php
Route::get('/a/{x}', [A::class, 'show']);
// Route::get('/weg', …);
Route::middleware('trainer')->prefix('settings')->group(function () {
    Route::patch('/team', [B::class, 'update'])->whereNumber(['x']);
});
Route::post('/b', fn () => null);
""";
      final routes = routesFromPhp(php, prefix: 'teams/{team}');
      expect(routes.map((r) => r.toString()), [
        'GET|HEAD /teams/{team}/a/{x}',
        'PATCH /teams/{team}/settings/team',
        'POST /teams/{team}/b',
      ]);
    });
  });
}
