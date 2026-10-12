import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/door_scaffold.dart';
import '../../../join/presentation/widgets/join_door.dart';
import '../../application/signup_controller.dart';
import '../../data/models/signup_models.dart';
import '../../data/signup_logo_picker.dart';
import 'signup_widgets.dart';

/// De club kiezen: zoeken in de lijst van deze sport (`GET /signup/clubs`,
/// 250 ms na de laatste aanslag), of intikken als hij er niet tussen staat.
/// Een tik op een treffer is de keuze en gaat meteen verder; wie terugkomt
/// ziet "Je club" met "Andere club kiezen".
class SignupClubStep extends ConsumerStatefulWidget {
  const SignupClubStep({
    required this.sport,
    required this.club,
    required this.manual,
    required this.clubName,
    required this.minChars,
    required this.onPick,
    required this.onManual,
    required this.onNext,
    required this.logo,
    required this.onPickLogo,
    required this.onRemoveLogo,
    this.error,
    this.logoError,
    super.key,
  });

  final String sport;

  /// De gekozen club uit de lijst, of `null`.
  final SignupClub? club;

  /// Club zelf intikken in plaats van zoeken.
  final bool manual;

  /// Het naamveld bij [manual].
  final TextEditingController clubName;
  final int minChars;
  final ValueChanged<SignupClub?> onPick;

  /// Naar (true, met de zoekterm) of uit (false) het intikken.
  final void Function(bool manual, String term) onManual;
  final VoidCallback onNext;
  final PickedSignupLogo? logo;
  final VoidCallback onPickLogo;
  final VoidCallback onRemoveLogo;
  final String? error;
  final String? logoError;

  @override
  ConsumerState<SignupClubStep> createState() => _SignupClubStepState();
}

class _SignupClubStepState extends ConsumerState<SignupClubStep> {
  static const Duration debounce = Duration(milliseconds: 250);

  final _term = TextEditingController();
  Timer? _timer;
  int _seq = 0;
  List<SignupClub> _results = const [];
  int _more = 0;
  bool _searching = false;

  /// Is er voor déze term al een antwoord? Anders flitst "niets gevonden"
  /// al tijdens het typen op.
  bool _searched = false;

  @override
  void dispose() {
    _timer?.cancel();
    _term.dispose();
    super.dispose();
  }

  void _onTerm(String value) {
    _timer?.cancel();
    final seq = ++_seq;
    setState(() => _searched = false);
    if (value.trim().length < widget.minChars) {
      setState(() {
        _results = const [];
        _more = 0;
        _searching = false;
      });
      return;
    }
    _timer = Timer(debounce, () => _search(value, seq));
  }

  Future<void> _search(String term, int seq) async {
    setState(() => _searching = true);
    SignupClubResults found;
    try {
      found = await ref
          .read(signupFlowProvider)
          .searchClubs(term, widget.sport);
    } on Object {
      // Een fout leest als "niets gevonden"; daaronder staat de weg naar
      // zelf intikken.
      found = const SignupClubResults();
    }
    // Een nieuwere aanslag heeft het overgenomen.
    if (!mounted || seq != _seq) return;
    setState(() {
      _results = found.clubs;
      _more = found.more;
      _searching = false;
      _searched = true;
    });
  }

  void _choose(SignupClub club) {
    widget.onPick(club);
    widget.onNext();
  }

  void _restart() {
    _timer?.cancel();
    _seq++;
    _term.clear();
    setState(() {
      _results = const [];
      _more = 0;
      _searching = false;
      _searched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (widget.manual) return _manual(l10n);
    final club = widget.club;
    if (club != null) return _chosen(l10n, club);
    return _searchView(l10n);
  }

  Widget _manual(AppLocalizations l10n) {
    final ready = widget.clubName.text.trim().length > 1;
    return Column(
      key: const ValueKey('signup-club-manual'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: l10n.signupClubManualTitle,
          subtitle: l10n.signupClubManualSubtitle,
        ),
        SignupField(
          key: const Key('signup-club-name'),
          controller: widget.clubName,
          label: l10n.signupClubNameHint,
          autofocus: true,
          autocorrect: false,
          maxLength: 120,
          textCapitalization: TextCapitalization.words,
          error: widget.error,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) {
            if (ready) widget.onNext();
          },
        ),
        const SizedBox(height: 12),
        _logoTile(l10n),
        if (widget.logoError != null) ...[
          const SizedBox(height: 8),
          DoorError(widget.logoError!),
        ],
        const SizedBox(height: 20),
        DoorButton(
          key: const Key('signup-next'),
          label: l10n.signupNext,
          onPressed: ready ? widget.onNext : null,
        ),
        const SizedBox(height: 8),
        DoorLinkButton(
          key: const Key('signup-club-search-list'),
          label: l10n.signupClubSearchList,
          onPressed: () {
            _restart();
            widget.onManual(false, '');
          },
        ),
      ],
    );
  }

  Widget _logoTile(AppLocalizations l10n) {
    final logo = widget.logo;
    return DoorPanel(
      key: const Key('signup-logo'),
      onTap: widget.onPickLogo,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0x0D000000),
              borderRadius: BorderRadius.circular(12),
            ),
            child: logo == null
                ? const Icon(Icons.add_rounded, color: Color(0x800C120D))
                : Image.memory(
                    logo.bytes,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_outlined,
                      color: Color(0x800C120D),
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(logo == null ? l10n.signupLogoAdd : l10n.signupLogoChosen),
                Text(
                  logo == null ? l10n.signupLogoLater : l10n.signupLogoChange,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0x990C120D),
                  ),
                ),
              ],
            ),
          ),
          if (logo != null)
            IconButton(
              key: const Key('signup-logo-remove'),
              tooltip: l10n.signupLogoRemove,
              color: DoorColors.ink,
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: widget.onRemoveLogo,
            )
          else
            const Icon(Icons.chevron_right_rounded, color: Color(0x660C120D)),
        ],
      ),
    );
  }

  Widget _chosen(AppLocalizations l10n, SignupClub club) {
    return Column(
      key: const ValueKey('signup-club-chosen'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(title: l10n.signupClubChosenTitle),
        DoorPanel(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SignupClubMark(name: club.name, logoUrl: club.logoUrl, size: 96),
              const SizedBox(height: 12),
              Text(
                club.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        if (widget.error != null) ...[
          const SizedBox(height: 12),
          DoorError(widget.error!),
        ],
        const SizedBox(height: 20),
        DoorButton(
          key: const Key('signup-next'),
          label: l10n.signupNext,
          onPressed: widget.onNext,
        ),
        const SizedBox(height: 8),
        DoorLinkButton(
          key: const Key('signup-club-other'),
          label: l10n.signupClubOther,
          onPressed: () {
            _restart();
            widget.onPick(null);
          },
        ),
      ],
    );
  }

  Widget _searchView(AppLocalizations l10n) {
    final term = _term.text.trim();
    return Column(
      key: const ValueKey('signup-club-search'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: l10n.signupClubTitle,
          subtitle: l10n.signupClubSubtitle,
        ),
        SignupField(
          key: const Key('signup-club-search'),
          controller: _term,
          label: l10n.signupClubSearchHint,
          autofocus: true,
          autocorrect: false,
          error: widget.error,
          onChanged: _onTerm,
          onSubmitted: (_) {
            if (_results.length == 1) _choose(_results.single);
          },
          suffix: _searching
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Color(0x800C120D),
                    ),
                  ),
                )
              : null,
        ),
        if (!_searching && _searched && _results.isEmpty) ...[
          const SizedBox(height: 12),
          DoorPanel(
            key: const Key('signup-club-none'),
            child: Text(
              l10n.signupClubNone(term),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
        if (_results.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final club in _results) ...[
            SignupChoice(
              key: ValueKey('signup-club-${club.id}'),
              onTap: () => _choose(club),
              child: Row(
                children: [
                  SignupClubMark(name: club.name, logoUrl: club.logoUrl),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(club.name, overflow: TextOverflow.ellipsis),
                        if (club.place != null && club.place!.isNotEmpty)
                          Text(
                            club.place!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0x990C120D),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (_more > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: DoorFootnote(l10n.signupClubMore(_more)),
            ),
        ],
        const SizedBox(height: 12),
        DoorLinkButton(
          key: const Key('signup-club-not-listed'),
          label: l10n.signupClubNotListed,
          onPressed: () {
            _timer?.cancel();
            _seq++;
            widget.onManual(true, _term.text.trim());
          },
        ),
      ],
    );
  }
}
