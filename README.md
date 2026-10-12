# Assistje (iOS + Android)

Native Flutter-app voor Assistje. Praat met de `/api/v1`-JSON-API van de
Laravel-app (`vogels3`). Noordster en beslissingen: `docs/slides/native-app/OVERVIEW.md`.

## Draaien

```sh
flutter pub get
dart run tool/l10n.dart   # verplicht na een verse clone: maakt lib/l10n/app_nl.arb + generated/
flutter run --dart-define-from-file=env/dev.json   # lokale vogels3
flutter run --dart-define-from-file=env/prod.json  # productie-API
```

## Kwaliteit

```sh
flutter analyze   # moet 0 issues geven
flutter test
dart run build_runner build --delete-conflicting-outputs   # freezed/json codegen
```

## Opbouw

- `lib/core/` — config (`Env`), theme (tokens, teamkleur, licht/donker), gedeelde widgets.
- `lib/features/<gebied>/{data,application,presentation}` — per functioneel gebied.
- `lib/l10n/arb/<gebied>_nl.arb` — alle copy (Nederlands), per gebied een fragment
  (zie *Copy* hieronder). `lib/l10n/app_nl.arb` en `lib/l10n/generated/` zijn gegenereerd.
- `assets/fonts/` — Figtree (SIL OFL 1.1, zie `OFL.txt`).

Teamkleur-logica (`lib/core/theme/team_color.dart`) is een 1-op-1 port van
`vogels3/resources/js/Components/ThemeApplier.tsx`; de tests in
`test/core/theme/team_color_test.dart` zijn tegen het origineel doorgerekend.

## Copy (l10n)

`flutter gen-l10n` accepteert maar één template-ARB, maar één gedeeld bestand
laat parallelle feature-slices botsen. Daarom is de bron opgesplitst:

- Bron: `lib/l10n/arb/<gebied>_nl.arb` (`core`, `auth`, `home`, `shell`,
  `agenda`, …). Elke key (met zijn `@key`-metadata) staat in precies één fragment.
- `dart run tool/l10n.dart` voegt alle fragmenten samen (op bestandsnaam,
  `@@locale: nl` één keer) naar `lib/l10n/app_nl.arb` en draait daarna
  `flutter gen-l10n`. Een dubbele key over fragmenten heen → exit-code 1.
- `lib/l10n/app_nl.arb` is een build-output (gitignored); nooit met de hand
  bewerken.

Nieuwe copy → zet de key in het fragment van je feature (maak
`lib/l10n/arb/<feature>_nl.arb` aan als die nog niet bestaat) →
`dart run tool/l10n.dart`.

## Feature-slice checklist

Elk nog niet gebouwd scherm heeft al een eigen stub
`lib/features/<feature>/presentation/<naam>_screen.dart` (nu een
`PlaceholderScreen`) die de router aanroept, met padparameters al als `int`
(`eventId`, `playerId`). Een feature-slice:

- werkt alleen in `lib/features/<x>/**` en vervangt de body van zijn eigen
  `XxxScreen` — `lib/core/router/app_router.dart` blijft onaangeroerd;
- zet copy in `lib/l10n/arb/<x>_nl.arb` en draait `dart run tool/l10n.dart`;
- zet tests in `test/features/<x>/**`;
- houdt fixtures feature-lokaal (in de test of `test/features/<x>/`) en laat
  `test/helpers/api_fixtures.dart` niet groeien — zet extra API-antwoorden via
  de `setup:`-hook van `pumpSignedIn`;
- draait codegen alleen voor de eigen map:
  `dart run build_runner build --delete-conflicting-outputs --build-filter="lib/features/<x>/**"`.

## Push

Push loopt via Firebase Cloud Messaging (`lib/core/push/`), maar de app bouwt
en draait **zonder** Firebase-project: geen `GoogleService-Info.plist`, geen
`google-services.json`, geen `com.google.gms.google-services`-plugin. Firebase
wordt gestart met expliciete opties uit de dart-defines in `env/*.json`; zijn
die leeg, dan staat push uit (geen Firebase-aanroep, geen aanmelding).

Invullen in `env/dev.json` / `env/prod.json` (Firebase-console →
Projectinstellingen → je iOS- en Android-app):

| Define | Waar vandaan |
|---|---|
| `FIREBASE_PROJECT_ID` | Project ID |
| `FIREBASE_MESSAGING_SENDER_ID` | Project number / Sender ID |
| `FIREBASE_IOS_API_KEY`, `FIREBASE_IOS_APP_ID` | iOS-app (`API_KEY`, `GOOGLE_APP_ID` uit de plist) |
| `FIREBASE_ANDROID_API_KEY`, `FIREBASE_ANDROID_APP_ID` | Android-app (`current_key`, `mobilesdk_app_id` uit de json) |
| `FIREBASE_IOS_BUNDLE_ID` | optioneel, standaard `nl.assistje.app` |
| `APP_VERSION` | gaat als `app_version` mee bij aanmelden; gelijk houden aan `version:` in `pubspec.yaml` |

Gedrag: na inloggen (ook een herstelde sessie bij opstart) vraagt de app
toestemming en meldt het FCM-token aan via `POST /api/v1/devices` — opnieuw
bij elke start en token-refresh (upsert; fouten worden genegeerd en volgen de
volgende keer). Uitloggen ruimt het token server-side op. Een tik op een
melding (ook koude start, en de lokale melding die op de voorgrond getoond
wordt) gaat via `DeepLinkHandler.handlePushData`.

Nog door jou te doen (user-gated):

- Firebase-project + iOS/Android-app aanmaken, waarden hierboven invullen;
  dezelfde project-id + service account in vogels3 (`FCM_PROJECT_ID`,
  `FCM_CREDENTIALS`).
- APNs-authenticatiesleutel (.p8) uploaden in Firebase (Cloud Messaging).
- In Xcode: Push Notifications-capability + provisioning profile (de
  entitlement `aps-environment` staat al in `Runner.entitlements`, op
  `development`; App Store-builds zetten Xcode/het profiel op `production`).
- Testen op een echt toestel (push werkt niet in de iOS-simulator zonder
  APNs) en een Android-build (geen Android SDK op deze machine).
