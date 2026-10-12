# Acceptatie — native-app

De code is af en geverifieerd:
- Flutter: `flutter analyze` schoon, 1365 tests groen, `flutter build ios --no-codesign` slaagt.
- vogels3: 2724 tests groen, op 3 omgevingsfouten na; 211 `/api/v1`-routes, allemaal gedocumenteerd.

Wat hieronder staat kan alleen jij controleren.

## 1. Committen en mergen `[user-gated]`
- [ ] **vogels3** (branch `feat/mobile-api`): alles staat nog ongecommit.
  1. Bekijk de wijzigingen met `git status` / `git diff`.
  2. Verwijder het lege, gitignorede `vogels3/.env`. Een agent heeft het per ongeluk aangemaakt.
  3. Commit, maak een PR naar `prod-deploy` en merge **pas na je OK**.
- [ ] **assistje-app**: `lib/`, `test/`, `ios/`, `android/`, `env/`, `pubspec.*` en `tool/` zijn nog untracked.
  - Check eerst dat `env/*.json` geen geheimen bevat die je niet in git wilt, en commit dan.
- [ ] Draai eventueel nog `/code-review` en `/security-review`. Deze taak raakt auth (code- en magic-link-login, join- en invite-tokens, signup) en bestandsuploads (avatar, CSV, schema, scout-PDF, feedbackafbeelding).
- [ ] Wil je de volledige vogels3-suite helemaal groen zien? Zet dan `APP_DOMAIN` en `VAPID_SUBJECT/PUBLIC_KEY/PRIVATE_KEY` in de testomgeving. Daarnaast nodig: `APP_KEY` en `APP_TIMEZONE=Europe/Amsterdam`.

## 2. Android-build `[user-gated]`
- [ ] Installeer Android Studio en de Android SDK, en accepteer de licenties met `flutter doctor --android-licenses`.
- [ ] Draai `flutter build apk --dart-define-from-file=env/prod.json` in `assistje-app`.
  - Verwacht resultaat: `build/app/outputs/flutter-apk/app-release.apk`.

## 3. Rondje op de simulator tegen een lokale vogels3 `[user-gated]`
- [ ] Start vogels3 lokaal op `http://localhost:8000`.
- [ ] Start de app met `flutter run --dart-define-from-file=env/dev.json` op een iPhone-simulator.
  - Een eerdere sessie staat nog opgeslagen. Wis die eerst met `xcrun simctl uninstall booted nl.assistje.app`.
- [ ] **Inloggen:** log in met e-mail en code (de code staat in de mail-log).
- [ ] **Teams en agenda:**
  - Wissel van team; de teamkleur hoort mee te veranderen.
  - Zet een RSVP in de agenda.
  - Open een live-wedstrijd en volg die.
- [ ] **Vlekken die alleen in widgettests gedraaid hebben:**
  - Sheets met het toetsenbord open.
  - Dark mode.
  - De glass-tabbar en het push-menu.
  - Het opstellingsveld per sport.
  - Datum- en tijdkiezers.
  - De bestandskiezers: CSV-import, schema-import, scout-PDF, avatar en feedbackafbeelding.
  - Het deelmenu: live delen, statistieken-CSV en de teamlink-QR.
  - `webcal:` "Zet in agenda", die de agenda-app moet openen.
  - De `/aanmelden`-, `/meedoen`- en `/register/invite`-flows.
- [ ] De gele debug-onderstreping in de tabbalk is al gerepareerd en bevestigd met een screenshot. Let er wel op of hij ergens anders nog opduikt.

## 4. Push op een echt toestel `[user-gated]`
- [ ] Maak een Firebase-project aan met een iOS- en een Android-app.
  - Vul de `FIREBASE_*`-waarden in `env/dev.json` en `env/prod.json`; zie de README, sectie Push.
- [ ] Upload de APNs-sleutel (.p8) in Firebase Cloud Messaging.
- [ ] Zet `FCM_PROJECT_ID` en `FCM_CREDENTIALS` (service account) in de vogels3-env.
- [ ] Installeer de app op een echte iPhone. Geef toestemming voor meldingen en stuur dan een testmelding, bijvoorbeeld door een wedstrijd aan te maken.
  - Verwacht resultaat: de melding komt binnen, en een tik erop opent het juiste event.

## 5. Universal Links / App Links `[user-gated]`
- [ ] Zet in de vogels3-env:
  - `APPLE_TEAM_ID`, nu de placeholder `XXXXXXXXXX`;
  - `ANDROID_SHA256_FINGERPRINTS` (komma-gescheiden, van je signing key).
- [ ] Deploy, en controleer dat `https://<domein>/.well-known/apple-app-site-association` en `/.well-known/assetlinks.json` de echte waarden tonen.
- [ ] Tik op een echt toestel op een `/meedoen/...`-, `/register/invite/...`- en `/aanmelden`-link en op een magic-login-link.
  - Verwacht resultaat: de app opent, niet Safari of Chrome.

## 6. Store-builds `[user-gated]`
- [ ] Leg de bundle-id en appnaam definitief vast (nu `nl.assistje.app` / "Assistje").
- [ ] Upload een TestFlight-build: `flutter build ipa --dart-define-from-file=env/prod.json`, daarna Transporter of Xcode.
- [ ] Upload een Play internal-test-build: `flutter build appbundle --dart-define-from-file=env/prod.json`.
- [ ] Zet na publicatie `IOS_APP_STORE_ID` in de vogels3-env. Dan tonen de Smart App Banner en de knop "Download de app" in de PWA de echte store-links.

## Optionele vervolgpunten (geen onderdeel van de DoD)
- **Boetes-CSV-export:** de PWA heeft voor de penningmeester een downloadknop (`Trainer/Fines/Index.tsx:318`). De API houdt dit bewust web-only (`docs/api/v1/fines.md`). Het gat is van dezelfde soort als de statistieken-export, maar de DoD vraagt er niet om.
- **"+ Nieuw" in de agenda:** in de PWA is dit een "Toevoegen"-menu. De app heeft een aparte trofee-knop voor het wedstrijdprogramma; een exacte kopie vraagt ook een aanpassing van `route_reachability_test`.
- **Open vragen uit OVERVIEW:** force-update via `/api/v1/meta`.
