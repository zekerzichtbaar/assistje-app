import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/session/session_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'widgets/door_scaffold.dart';

/// Opstartscherm: laden, of een fout bij `/me` met "Opnieuw proberen".
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final me = ref.watch(meProvider);

    if (me.hasError && !me.isLoading) {
      return DoorScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DoorHeadline(l10n.splashLoadError),
            const SizedBox(height: 12),
            Text(
              me.error is NetworkException
                  ? l10n.errorNetwork
                  : l10n.errorGeneric,
              style: const TextStyle(fontSize: 16, color: DoorColors.ink),
            ),
            const SizedBox(height: 24),
            DoorButton(
              label: l10n.retry,
              onPressed: () => ref.invalidate(meProvider),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).logout(),
              child: Text(
                l10n.logout,
                style: const TextStyle(
                  color: DoorColors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const DoorScaffold(
      child: Center(child: CircularProgressIndicator(color: DoorColors.ink)),
    );
  }
}
