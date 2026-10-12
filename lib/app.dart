import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/deep_links/deep_link_handler.dart';
import 'core/push/push_controller.dart';
import 'core/router/app_router.dart';
import 'core/session/session_providers.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_providers.dart';
import 'l10n/generated/app_localizations.dart';

class AssistjeApp extends ConsumerWidget {
  const AssistjeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Houdt de teamkleur gelijk aan het actieve team.
    ref.watch(teamColorSyncProvider);
    // Universal/App Links en push-tikken → het juiste scherm.
    ref.watch(deepLinkHandlerProvider);
    // Push: aanmelden na inloggen, voorgrondmeldingen, tikken (inert zonder
    // Firebase-defines).
    ref.watch(pushControllerProvider);
    final teamColor = ref.watch(teamColorProvider);
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(teamColor),
      darkTheme: AppTheme.dark(teamColor),
      themeMode: themeMode,
      scrollBehavior: const AppScrollBehavior(),
      locale: const Locale('nl'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
