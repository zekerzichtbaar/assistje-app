import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/presentation/widgets/door_scaffold.dart';
import '../../join/presentation/widgets/join_door.dart';

/// Ingelogd, maar geen lid van een team: uitloggen, of zelf een team
/// aanmelden ([AppRoutes.signup]).
class NoTeamScreen extends ConsumerWidget {
  const NoTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return DoorScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DoorHeadline(l10n.noTeamTitle),
          const SizedBox(height: 12),
          Text(
            l10n.noTeamBody,
            style: const TextStyle(fontSize: 16, color: DoorColors.ink),
          ),
          const SizedBox(height: 24),
          DoorButton(
            label: l10n.logout,
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
          const SizedBox(height: 8),
          DoorLinkButton(
            key: const Key('no-team-signup'),
            label: l10n.signupEntryNoTeam,
            onPressed: () => context.go(AppRoutes.signup),
          ),
        ],
      ),
    );
  }
}
