import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// "+ Nieuw" naast de agendatitel (trainer): opent het event-formulier.
class AgendaAddEventButton extends StatelessWidget {
  const AgendaAddEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      label: l10n.scheduleAddEventLabel,
      child: Material(
        color: t.primary,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const ValueKey('agenda-new-event'),
          onTap: () {
            unawaited(Haptics.light());
            unawaited(context.push(AppRoutes.schedule));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: ExcludeSemantics(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PhosphorIcon(
                    PhosphorIconsBold.plus,
                    size: 16,
                    color: t.primaryContrast,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.scheduleAddEvent,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: t.primaryContrast,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
