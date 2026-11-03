# Assistje (iOS + Android)

Native Flutter-app voor Assistje. Praat met de `/api/v1`-JSON-API van de
Laravel-app (`vogels3`). Noordster en beslissingen: `docs/slides/native-app/OVERVIEW.md`.

## Draaien

```sh
flutter pub get
dart run tool/l10n.dart   # verplicht na een verse clone: maakt lib/l10n/app_nl.arb + generated/
flutter run --dart-define-from-file=env/dev.json   # lokale vogels3
flutter run --dart-define-from-file=env/staging.json  # staging-API
flutter run --dart-define-from-file=env/prod.json  # productie-API
```

`env/staging.json` wijst naar `https://staging.assistje.nl/api/v1`. Dat is nog
een placeholder: de staging-site moet nog worden aangemaakt.

## Kwaliteit

```sh
flutter analyze   # moet 0 issues geven
flutter test
dart run build_runner build --delete-conflicting-outputs   # freezed/json codegen
```

## CI

`.github/workflows/ci.yml` draait bij elke push naar `main`, bij pull requests en
met de hand (*Run workflow*):

- **test** (ubuntu): `flutter pub get` → `dart run tool/l10n.dart` (de l10n is
  gitignored build-output; de freezed/json-codegen staat wél in git, dus geen
  `build_runner`) → `dart format --set-exit-if-changed` → `flutter analyze` →
  `flutter test`. Flutter staat vast op 3.41.x.
- **ios-build** (macOS, alleen push naar `main` en PR's):
  `flutter build ios --no-codesign --dart-define-from-file=env/prod.json`. De
  clubiconen (`tool/app_icons.dart`) worden in CI niet gemaakt.
- **android-build** (ubuntu, alleen push naar `main` en PR's): JDK 17 →
  dezelfde l10n-stappen als **test** → `flutter build appbundle --release
  --dart-define-from-file=env/prod.json`. Met de repo-secrets
  `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`,
  `ANDROID_KEY_PASSWORD` en `ANDROID_KEY_ALIAS` schrijft de job eerst
  `android/key.properties` + de keystore en uploadt hij de getekende `.aab`
  als artefact (`app-release-aab`); zonder secrets bouwt hij met de
  debugsleutel (alleen een bouwcheck). Zie *Release (Android)*.
- **api-contract**: checkt elke API-aanroep in `lib/` tegen de v1-routes van
  vogels3 (zie hieronder). Optioneel: zonder het repo-secret `VOGELS3_TOKEN`
  (een token met leestoegang op `zekerzichtbaar/vogels3`) slaat de job zichzelf
  over. De vogels3-ref komt uit de input `vogels3_ref` (handmatige run), anders
  de repo-variabele `VOGELS3_REF`, anders `feat/mobile-api`. Zet `VOGELS3_REF`
  op `prod-deploy` zodra de API daar staat.

### API-contractcheck

```sh
dart run tool/api_contract.dart --api-repo ../vogels3            # route:list, of parsen
dart run tool/api_contract.dart --api-repo ../vogels3 --parse    # altijd parsen (geen php nodig)
dart run tool/api_contract.dart --api-repo ../vogels3 --verbose  # elke aanroep tonen
```

Scant `lib/` statisch op `ApiClient`/`Dio`-aanroepen (methode + pad; padhelpers
als `_base(teamId)`, lokale `path`-variabelen en stringparameters als
`_clock(…, 'stop')` worden opgelost; `tool/api_contract_scan.dart`) en vergelijkt
ze met de routes van vogels3: `php artisan route:list --json --path=api/v1` als
die checkout `vendor/` heeft, anders geparst uit `routes/api.php` +
`routes/api/v1/**/*.php`. Exit-code 1 bij een aanroep zonder route. Een
volledig dynamisch pad (een absolute URL uit een API-antwoord) wordt
overgeslagen. Nieuwe aanroep? Houd hem statisch leesbaar (stringliteral of
padhelper), dan controleert de check hem mee.

## End-to-end tests

`integration_test/` draait de echte app op een iOS-simulator tegen een echte,
lokale vogels3 met een verse seed (`php artisan assistje:e2e`):

```sh
dart run tool/e2e.dart --api-repo ../vogels3              # alle flows
dart run tool/e2e.dart --api-repo ../vogels3 rsvp shoot   # filter op bestandsnaam
dart run tool/e2e.dart --api-repo ../vogels3 --device <udid> --port 8001
```

Wat de runner doet:

1. Start vogels3 op `127.0.0.1:8000` met de PHP-server van `artisan serve`
   (direct, want `artisan serve` filtert omgevingsvariabelen). De lokale `.env`
   van vogels3 speelt geen rol: verse `APP_KEY`, sqlite in een tijdelijke map,
   `MAIL_MAILER=log`, `QUEUE_CONNECTION=sync`, `APP_TIMEZONE=Europe/Amsterdam`.
   Draait er al iets op de poort, dan stopt hij (of gebruik `--reuse-server`:
   dan geen migratie en draait de seed met jouw eigen `.env`).
2. `php artisan migrate:fresh --force` + `php artisan assistje:e2e` → JSON
   (team, gebruikers, event-ids; `integration_test/support/fixture.dart`).
3. Per testbestand een verse inlogcode voor de rol uit de kopregel
   `// e2e-rol: trainer|player|spectator` (`assistje:e2e --code-for=<rol>`,
   zet ook de throttles terug), dan `flutter test <bestand> -d <udid>
   --dart-define-from-file=.dart_tool/e2e/<bestand>.json` met `API_BASE_URL`,
   `E2E_FIXTURE` en `E2E_LOGIN`.
4. Simulator: een opgestarte iPhone, anders wordt "iPhone 16" (of de eerste
   iPhone) opgestart.

Flows (één bestand per flow, gedeelde helpers in `integration_test/support/`):
inloggen (`login`), aan-/afmelden (`rsvp`), beker met verlenging +
strafschoppen (`cup_shootout`), meerdere mensen op één dienst (`duty_multi`),
afvinklijst-spaarpot (`savings_checklist`), teambericht zonder toeschouwers
(`team_message`), toeschouwer → Diensten (`spectator_duties`).

Afspraken: elke test start uitgelogd (`startApp` leegt Keychain en
SharedPreferences) en logt via het echte inlogscherm in. Geen `pumpAndSettle`
(de live-klok tikt door): `waitFor`/`waitUntil` pompen in echte tijd tot een
finder iets vindt. Ids altijd uit de fixture, nooit hard. Zoek op bestaande
`ValueKey`s; voeg alleen een key toe in `lib/` als er echt geen unieke tekst
of key is.

## Opbouw

- `lib/core/` — config (`Env`), theme (tokens, teamkleur, licht/donker), gedeelde widgets.
- `lib/features/<gebied>/{data,application,presentation}` — per functioneel gebied.
- `lib/l10n/arb/<gebied>_nl.arb` — alle copy (Nederlands), per gebied een fragment
  (zie *Copy* hieronder). `lib/l10n/app_nl.arb` en `lib/l10n/generated/` zijn gegenereerd.
- `assets/fonts/` — Figtree (SIL OFL 1.1, zie `OFL.txt`).

Teamkleur-logica (`lib/core/theme/team_color.dart`) is een 1-op-1 port van
`vogels3/resources/js/Components/ThemeApplier.tsx`; de tests in
`test/core/theme/team_color_test.dart` zijn tegen het origineel doorgerekend.

## Platformconventies (iOS HIG / Material)

- **Navigatie:** tabbalk met max. 5 tabs; de laatste is *Meer* (profiel,
  teamwissel, alle overige schermen). Geen hamburger-/schuifmenu.
- **Bevestigen:** `showConfirmDialog` (Cupertino op iOS, Material op Android;
  `destructive: true` voor onomkeerbare acties). Nooit losse `AlertDialog`s.
- **Datum/tijd:** `showAppDatePicker` / `showAppTimePicker` (wieltjes op iOS,
  kalender op Android, altijd 24-uurs). Nooit direct `showDatePicker`.
- **Schakelaars/vinkjes:** `Switch.adaptive`, `Checkbox.adaptive`,
  `CheckboxListTile.adaptive`.
- **Tikvlakken ≥ 44 pt:** geen `VisualDensity.compact` op knoppen.
- **Tekst ≥ 11 pt** (uitzondering: vaste markers op het veld). Tekst schaalt
  mee met de systeemtekstgrootte via `AppTextScaler` (koppen groeien minder,
  als iOS; begrensd op ≈ AX2); vaste chrome (tabbalk, badges) schaalt niet.
- **Schermtitel met acties:** `ScreenHeader` (acties zakken onder de titel
  bij grote tekst).
- **Contrast ≥ 4.5:1:** wit op een statuskleur alleen op -700-tinten.
- **Audit:** `flutter test test/a11y/` controleert elk hoofdscherm
  (`hig_audit_test.dart`) en elke sheet/dialoog (`hig_sheets_{a,b}_test.dart`)
  op iPhone SE en Pro Max, standaard en AX5: geen overloop, tikvlakken
  ≥ 44 pt, VoiceOver-labels, contrast. Een nieuw scherm of nieuwe sheet krijgt
  daar een regel. Bewezen meetfouten van de contrastcontrole gaan via
  `contrastFalsePositives`, altijd met reden. Met
  `HIG_SHOTS_DIR=<map>` ervoor krijg je schermafbeeldingen met de echte fonts.
- **Haptics:** via `Haptics` (`success`/`error` = systeem-notificatiehaptiek).

## App-iconen (standaard + clubwapens)

- Standaardicoon: het Assistje-mascotje (bron: vogels3 `public/img/assistje-logo.svg`).
- Clubwapens: iOS kan alleen wisselen naar iconen die in de build zitten. Draai
  daarom **vóór elke iOS-release**:

  ```sh
  dart run tool/app_icons.dart          # haalt GET /api/v1/app-icons op (env/prod.json)
  ```

  Dat schrijft per club `ios/Runner/Assets.xcassets/ClubIcon-<clubId>.appiconset`
  (gitignored; alleen beginschermformaten als palet-PNG, ± 3 KB per stuk).
  Ongewijzigde logo's worden overgeslagen; een onleesbaar logo is een
  waarschuwing, geen fout. `--clean` haalt ze weer weg, `--api <url>` kiest
  een andere bron.
- In de app: Profiel → kaart *App-icoon*, alleen als de club van je team een
  logo heeft. Eén kanaal `nl.assistje.app/app_icon`
  (`lib/core/app_icon/`), twee manieren (`mode` in het `status`-antwoord):
  - **iOS = alternatief icoon** (`alternate`): een schakelaar wisselt het
    app-icoon naar het wapen, alleen als dat in de build zit. Native kant:
    `AppIconChannel` in `ios/Runner/AppDelegate.swift`.
  - **Android = vastgezette snelkoppeling** (`shortcut`): een
    `activity-alias` per club is voor ~4100 clubs onwerkbaar (manifest,
    herstart, weggevallen snelkoppelingen). De knop *Zet op beginscherm*
    downloadt het logo (`logo_url` uit `GET /api/v1/app-icons`, alleen
    PNG/JPEG/WebP; een SVG-logo → geen kaart) en zet een snelkoppeling
    `club-<clubId>` met dat logo op wit (adaptief icoon) op het beginscherm;
    het gewone icoon blijft. Staat hij er al, dan werkt de knop het logo bij.
    Er zit niets in de build, dus geen `tool/app_icons.dart` nodig voor
    Android. Native kant: `android/app/src/main/kotlin/nl/assistje/app/AppIconChannel.kt`.

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

## Release (Android)

Google Play-eisen, Data safety, store-teksten en graphics:
`docs/store/google-play.md` (graphics in `docs/store/android/`).

**Uploadsleutel (eenmalig).** Play App Signing beheert de echte
app-sleutel; jij tekent met een *uploadsleutel*. Maak die buiten de repo en
bewaar hem (en de wachtwoorden) in de wachtwoordkluis:

```sh
keytool -genkey -v -keystore ~/keys/assistje-upload.jks -storetype JKS \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Dan `android/key.properties` (gitignored, net als `*.jks`/`*.keystore`):

```properties
storePassword=…
keyPassword=…
keyAlias=upload
storeFile=/Users/<jij>/keys/assistje-upload.jks
```

`storeFile` mag absoluut zijn of relatief aan `android/`. Zonder
`key.properties` tekent `android/app/build.gradle.kts` de release-build met
de debugsleutel en meldt Gradle `w: android/key.properties ontbreekt …`: zo'n
build kan niet naar Play.

**Bouwen:**

```sh
flutter build appbundle --release --dart-define-from-file=env/prod.json
# → build/app/outputs/bundle/release/app-release.aab
```

Versie = `version:` uit `pubspec.yaml` (`1.0.0+1` → versionName `1.0.0`,
versionCode `1`); elke upload naar Play heeft een hoger buildnummer nodig
(`--build-number=<n>` kan ook).

De release-build: `targetSdk`/`compileSdk` 36 (Play-eis sinds 31 aug 2026),
`minSdk` 24, R8 (`isMinifyEnabled` + `isShrinkResources`,
`android/app/proguard-rules.pro`), alleen Nederlandse resources, geen
back-up van app-gegevens (het versleutelde inlogtoken is na een restore
onleesbaar), voorspellend terug aan, 16 KB-pagina's (controle:
`zipalign -c -P 16 -v 4 <apk>`).

**Eerste upload in de Play Console:** app aanmaken (`nl.assistje.app`) →
*Play App Signing* aanzetten (standaard) en de `.aab` uploaden naar *Interne
test* → daarna de SHA-256 van de **app-ondertekeningssleutel** (*App-integriteit*)
plus die van de uploadsleutel in vogels3 `ANDROID_SHA256_FINGERPRINTS`
zetten, anders werken de App Links (`assetlinks.json`) niet.

**CI-secrets** (voor een getekende `.aab` als artefact van **android-build**):

```sh
base64 -i ~/keys/assistje-upload.jks | pbcopy   # → ANDROID_KEYSTORE_BASE64
```

plus `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_PASSWORD` en
`ANDROID_KEY_ALIAS` (`upload`).

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
