import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_icon/app_icon_service.dart';
import 'core/deep_links/deep_link_handler.dart';
import 'core/push/push_controller.dart';
import 'core/router/app_router.dart';
import 'core/session/session_providers.dart';
import 'core/theme/app_text_scaler.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_providers.dart';
import 'core/widgets/skeleton.dart';
import 'l10n/generated/app_localizations.dart';

class AssistjeApp extends ConsumerWidget {
  const AssistjeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Houdt de teamkleur gelijk aan het actieve team.
    ref.watch(teamColorSyncProvider);
    // App-icoon = clubwapen van het actieve team (standaardicoon na uitloggen).
    ref.watch(appIconSyncProvider);
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
      // Dynamic Type zoals iOS: koppen groeien minder dan broodtekst.
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemBarsStyle(Theme.of(context).brightness),
          child: MediaQuery(
            data: mq.copyWith(textScaler: AppTextScaler.from(mq.textScaler)),
            // Eén gedeelde glansgolf voor alle skeletons.
            child: ShimmerScope(child: child!),
          ),
        );
      },
    );
  }
}

/// Status- en navigatiebalk bij het thema van de app (niet van het toestel:
/// de gebruiker kan licht/donker zelf kiezen). Android 15+ tekent de app
/// altijd edge-to-edge: de balken zijn doorzichtig en alleen de iconen
/// wisselen van kleur. Schermen met een `AppBar` zetten hun eigen stijl.
SystemUiOverlayStyle systemBarsStyle(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // Android: icoonkleur; iOS: `statusBarBrightness` is de achtergrond.
    statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    statusBarBrightness: brightness,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: dark
        ? Brightness.light
        : Brightness.dark,
    // Knoppennavigatie: het systeem legt zelf een doorschijnende laag onder
    // de knoppen, zodat ze leesbaar blijven boven de inhoud.
    systemNavigationBarContrastEnforced: true,
  );
}
