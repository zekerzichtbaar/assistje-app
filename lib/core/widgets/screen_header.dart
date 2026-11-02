import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// De grote schermtitel met optionele acties rechts ervan.
///
/// Past het niet naast elkaar (grote tekst, smal toestel), dan zakken de
/// acties onder de titel in plaats van de titel letter voor letter af te
/// breken.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.titleKey,
    this.actions = const [],
  });

  final String title;
  final Key? titleKey;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        Semantics(
          header: true,
          child: Text(
            title,
            key: titleKey,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: t.ink,
            ),
          ),
        ),
        if (actions.isNotEmpty)
          Wrap(spacing: 8, runSpacing: 8, children: actions),
      ],
    );
  }
}
