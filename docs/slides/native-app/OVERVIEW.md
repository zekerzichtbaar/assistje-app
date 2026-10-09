# Assistje native app (Flutter) + API-laag in vogels3

## Goal
Assistje (repo `vogels3`) is nu een PWA, en de installatiedrempel ("hoe zet ik dit op
mijn telefoon?") kost gebruikers. We bouwen een native iOS- + Android-app in Flutter
met **volledige functionele pariteit** met de teamapp (alles behalve de
superadmin-console), in dezelfde look & feel. Beide frontends praten met dezelfde data
via een nieuwe, geversioneerde JSON-API in de bestaande Laravel-app; de PWA blijft
werken voor wie geen app wil.

Volledige inventaris en backend-feiten: `docs/slides/native-app/ANALYSIS.md`.

## Scope
- **API (in `/Users/michaelvansetten/Sites/vogels3`, branch `feat/mobile-api` vanaf `prod-deploy`)**
  - `/api/v1` met Sanctum-tokens, login via mail met **link (Universal/App Link) + 6-cijferige code**.
  - Bootstrap-endpoint `/api/v1/me` (blauwdruk: `HandleInertiaRequests::share()`).
  - Team-gescoopte endpoints onder `/api/v1/teams/{team}/…` voor élk gebied uit ANALYSIS §3
    behalve de superadmin-console.
  - Gedeelde Actions: logica met bijwerkingen (RSVP, events, opstelling publiceren,
    boetes, …) uit de controllers getrokken zodat web én API dezelfde code draaien.
  - Native push: `device_tokens` + FCM HTTP v1-kanaal naast WebPush, voorkeuren en
    teamfilter gerespecteerd, deep-link-paden in de payload.
  - `apple-app-site-association` + `assetlinks.json` op alle hosts.
  - PWA-installatieflow vervangen door "download de app" (store-badges / smart app banner);
    `AppAdoption` telt native devices mee.
- **Flutter-app (in `/Users/michaelvansetten/Sites/assistje-app`)**
  - Alle schermen uit ANALYSIS §3 (speler-, penningmeester-, trainer- en
    toeschouwerflows), inclusief live-wedstrijd, opstelling drag&drop, radje, aanmelden
    (nieuw team), join via teamlink, beheer/instellingen, account verwijderen.
  - Login (code + deep link), in-app teamwissel, teamkleur als thema, licht/donker/systeem.
  - Push (FCM/APNs) met tap → juiste scherm.
  - Look & feel 1-op-1 naar de PWA (glazen tabbar, sheets, haptics, confetti, sportvelden).

## Non-goals
- Superadmin-console (`admin.`) — blijft web-only.
- De PWA herschrijven naar de nieuwe API. De PWA blijft Inertia; gelijkheid komt uit
  gedeelde Actions/services, niet uit een gedeelde client.
- Offline schrijven / sync-queue. Alleen tonen van de laatst geladen data zonder netwerk.
- Websockets/realtime-infra. Live blijft polling (12 s), net als de PWA.
- Tablet-/desktop-specifieke layouts (alleen telefoon; tablet mag de telefoonlayout schalen).
- Nieuwe features of redesign. Pariteit eerst; verbeteringen zijn een volgende taak.
- Meertaligheid (alleen Nederlands, maar copy via één ARB-bestand zodat het later kan).
- Productie-deploy of -migratie zonder expliciete OK van de gebruiker.

## Key decisions & constraints
Per keuze: waarom, en wat het kost.

**API**
- **REST/JSON onder `/api/v1`, in de bestaande Laravel-app.** Hergebruikt modellen,
  services en ~2.100 tests. *Trade-off:* koppelt app-releases aan de monoliet; versie-prefix
  vangt brekende wijzigingen op. GraphQL afgewezen: extra laag zonder winst bij één client.
- **Sanctum personal access tokens** (één token per device, `abilities` niet gebruikt —
  autorisatie blijft rol/ability per team). Zit al in de lockfile → geen `composer require`.
  *Trade-off:* langlevende tokens; mitigatie = intrekken bij uitloggen/account verwijderen
  en een tokenoverzicht per user. OAuth/Passport afgewezen: overkill voor first-party.
- **Login = bestaande magic-link-mail + 6-cijferige code.** Link opent de app via
  Universal/App Links, code werkt altijd (andere device, in-app browser). Endpoints:
  `POST /api/v1/auth/request` → `POST /api/v1/auth/exchange` (token óf e-mail+code) → Sanctum-token.
  Exchange doet hetzelfde als `MagicLoginController::consume` (email-claim,
  `invite_accepted_at`). Code: 6 cijfers, gehasht, zelfde TTL, max 5 pogingen, throttle.
  *Trade-off:* kleine wijziging in de mail en de PWA-loginpagina krijgt óók een codeveld.
- **Team expliciet in het pad: `/api/v1/teams/{team}/…`** (id of slug), middleware
  doet membership-check + `CurrentTeam::set()` **vóór** route-model binding (in de
  middleware-priority), plus `scopeBindings()`. *Waarom pad i.p.v. header:* zichtbaar in
  logs, cachebaar, en bindings kunnen op het team scopen. *Trade-off:* langere URL's.
- **API Resources met whitelists.** Nooit `toArray()` van een model; `Team` lekt anders
  `provisional`, `ical_token`, `sportlink_*`. Alle URL's absoluut. Datums ISO-8601 met offset.
- **Gedeelde Actions (`app/Actions/…`) i.p.v. API-controllers die web-controllers
  aanroepen.** Web- en API-controller worden allebei dun. *Trade-off:* refactor van
  bestaande controllers raakt de PWA → bestaande Pest-tests moeten groen blijven, en die
  zijn de vangnet. Alleen extraheren wat de API nodig heeft, niet "alles netjes maken".
- **Validatie**: bestaande Form Requests hergebruiken waar ze niet aan routenamen hangen;
  `UpdateAttendanceRequest` routenaam-onafhankelijk maken.
- **Fouten**: Laravel-standaard JSON (`message` + `errors` bij 422), 401/403/404/409/429.
- **Paginatie**: cursor/`?page` met `meta`, alleen waar de PWA ook pagineert (agenda, meldingen).
- **Demo**: API respecteert `is_demo` (schrijven geblokkeerd behalve dezelfde allowlist,
  op API-routenamen). Demo-login in de app via een knop "Bekijk de demo".
- **Push: FCM HTTP v1 voor Android én iOS** (APNs via FCM). Eigen kanaal met
  `Http` + `openssl_sign` voor de service-account-JWT — geen nieuwe dependency.
  Notificaties krijgen één `toPushPayload()` die WebPush en FCM delen; deep link =
  bestaand `data.url`-pad, de app mapt dat pad op een route. *Trade-off:* afhankelijk van
  Firebase (gratis), maar één pijplijn voor beide platformen. Rechtstreeks APNs afgewezen:
  twee pijplijnen.
- **Contract = Pest feature-tests per endpoint + `docs/api/v1.md`** in vogels3. Geen
  OpenAPI-generator (dependency + onderhoud); wel een JSON-voorbeeld per endpoint.
- Volg `vogels3/CLAUDE.md`: Nederlandse comments/commits, AttendanceTally/FinePot/
  SavingsParticipants als enige tellers, EmailClaim voor mailadressen, `PublicUrl` voor
  bezoekers-URL's, sport nooit hardcoden, `activated_at` alleen bij zelf-RSVP.

**Flutter**
- **Flutter stable (3.41 lokaal), Dart 3, iOS 15+ / Android 7 (API 24)+.** Dekking ~98%
  van de toestellen. *Trade-off:* oudere toestellen vallen af.
- **State: Riverpod (`flutter_riverpod`, zonder codegen).** Testbaar, geen BuildContext-
  afhankelijkheid, de de-facto standaard. *Trade-off:* leercurve vs. `provider`; Bloc
  afgewezen: veel boilerplate voor CRUD-schermen.
- **Routing: `go_router`.** Officieel, deep links + redirects (auth/team) ingebouwd,
  `StatefulShellRoute` voor de tabbar. *Trade-off:* minder typesafe zonder codegen.
- **HTTP: `dio`** met interceptors (bearer-token, 401 → uitloggen, retry op netwerkfout).
- **Modellen: `freezed` + `json_serializable`.** Immutable, `copyWith`, sealed unions voor
  statussen. *Trade-off:* `build_runner`-codegen; afgewogen tegen handgeschreven `fromJson`
  voor ~40 modellen — codegen wint op foutkans.
- **Architectuur: feature-first** (`lib/features/<gebied>/{data,application,presentation}`),
  plus `lib/core/` (api, auth, theme, router, widgets). Repository per gebied; geen
  aparte "domain/usecase"-laag (onnodige indirectie voor een API-client).
- **Opslag:** `flutter_secure_storage` (token), `shared_preferences` (thema, laatste team).
  Leescache: laatste respons per scherm in geheugen + optioneel op schijf; geen lokale DB.
- **Push:** `firebase_messaging` + `flutter_local_notifications` (voorgrond).
- **Deep links:** `app_links` (Universal/App Links), gemapt op `go_router`.
- **UI:** Material 3 als basis met eigen `ThemeExtension` voor de Assistje-tokens; per
  platform native gedrag (Cupertino swipe-back en scroll-physics op iOS). `phosphor_flutter`
  (duotone), Figtree gebundeld als asset (geen runtime-download), `confetti`,
  opstelling met eigen `Draggable`/`DragTarget` + `CustomPainter` per sportveld,
  radje als `CustomPainter`. Haptics via `HapticFeedback`.
- **Teamkleur → `ColorScheme`** met dezelfde contrast- en `liftForDark`-logica als
  `ThemeApplier.tsx` (unit-getest tegen dezelfde voorbeelden).
- **Omgevingen:** `--dart-define-from-file` (`env/dev.json`, `env/prod.json`) voor API-basis-URL;
  geen native flavors (minder configuratie, één bundle-id).
- **Kwaliteit:** `flutter_lints` (strikt), `flutter analyze` schoon, unit- + widgettests
  per feature, `mocktail`. Geen Playwright, geen extra e2e-framework.
- **Copy:** Nederlands in `lib/l10n/app_nl.arb` via `flutter gen-l10n`.
- **Bundle-id voorlopig `nl.assistje.app`**, appnaam "Assistje".

## Preconditions & external dependencies
Alleen de gebruiker kan dit regelen. Codewerk kan zonder, maar de genoemde DoD-punten
blijven `[user-gated]` tot het er is.
- **Lokale toolchain:** Android SDK (Android Studio) en CocoaPods installeren
  (`flutter doctor` geeft nu ✗ voor beide). Zonder Android SDK kan alleen de iOS-build lokaal.
- **Apple Developer Program** (€99/jaar) met team-ID → nodig voor Associated Domains,
  push (APNs-key `.p8`) en TestFlight/App Store.
- **Google Play Console** (eenmalig $25) + upload-keystore.
- **Firebase-project** met iOS- + Android-app, APNs-key geüpload, service-account-JSON voor
  de server (`FCM_*` env in vogels3), `google-services.json` / `GoogleService-Info.plist`.
- **Bevestiging bundle-id/package-name en appnaam** (voorstel `nl.assistje.app` / "Assistje").
- **Store-materiaal:** privacybeleid-URL, support-URL, screenshots, omschrijving,
  leeftijdsclassificatie, een reviewaccount met demoteam voor Apple/Google.
- **Deploy van de API naar staging/productie** (Forge) + `php artisan migrate` — alleen met jouw OK.

## Building blocks
- vogels3: Sanctum-setup, auth-exchange (link + code), team-scope-middleware, API Resources,
  Actions-extractie, endpoints per gebied, device tokens + FCM-kanaal, AASA/assetlinks,
  PWA "download de app"-flow, API-docs.
- assistje-app: projectskelet + core (api-client, auth, router, theme/tokens, gedeelde widgets:
  sheet, pills, date tile, avatar, empty state, skeleton, toast), shell (glazen tabbar,
  zwevende pills, menu), en features: auth/onboarding/join/aanmelden, agenda, event-detail +
  RSVP, live, opstelling, verslag, carpool/MOTM, diensten, trainingsteams, spelers/staf/
  toeschouwers, stats/ranglijst/poule, boetes, spaarpot, radje, berichten, meldingen,
  afspraken, profiel, instellingen, feedback, teamwissel, push.

## Definition of Done
**API (vogels3, branch `feat/mobile-api`)**
- [ ] `php artisan test` volledig groen (bestaande ~2.100 tests + nieuwe API-tests).
- [ ] Elk gebied uit ANALYSIS §3 (behalve superadmin-console) heeft `/api/v1`-endpoints met
      ten minste één happy-path- én één autorisatie-test (verkeerde rol/ander team → 403/404).
- [ ] Een cross-team-test bewijst dat `/api/v1/teams/A/events/{event-van-B}` 404 geeft,
      zónder dat de test `CurrentTeam` vooraf zet.
- [ ] Een test bewijst dat geen Team-respons `provisional`, `ical_token` of `sportlink_*` bevat.
- [ ] Login: `auth/request` + `auth/exchange` werken met token én met code; code is gehasht,
      verloopt, en blokkeert na 5 pogingen (tests).
- [ ] RSVP via API en via web lopen door dezelfde Action (tests dekken auto-diensten,
      late-change en `activated_at` alleen bij zelf-RSVP).
- [ ] Een notificatie gaat naar WebPush én FCM, respecteert `wantsNotification` en het
      teamfilter (test met gefakete HTTP).
- [ ] `/.well-known/apple-app-site-association` en `/.well-known/assetlinks.json` worden
      geserveerd (test).
- [ ] PWA toont "Download de app" (store-links) i.p.v. de installatiestappen; `AppAdoption`
      telt native devices mee (test).
- [ ] `docs/api/v1.md` beschrijft elk endpoint met voorbeeldrespons.
- [ ] Niets gemerged naar `prod-deploy` of gedeployed zonder OK. `[user-gated]`

**Flutter (assistje-app)**
- [ ] `flutter analyze` geeft 0 issues; `flutter test` groen.
- [ ] Elk scherm uit ANALYSIS §3 (behalve superadmin-console) bestaat en is bereikbaar
      vanuit de navigatie volgens rol + feature flags (widgettest op de menuopbouw per rol).
- [ ] Teamkleur-thema: unit-tests voor contrastkleur en `liftForDark` met dezelfde
      uitkomsten als `ThemeApplier.tsx`.
- [ ] Alle vier sporten renderen hun veld/formaties/terminologie uit het API-sportprofiel
      (widgettest per sport, geen hardcoded sport in `lib/`).
- [ ] Repository-tests tegen gemockte API-responses voor elk gebied.
- [ ] Push-deeplink-mapping: unit-test dat elk `data.url`-pad uit de 38 notificaties op een
      app-route uitkomt.
- [ ] `flutter build ios --no-codesign` slaagt.
- [ ] `flutter build apk` slaagt. `[user-gated]` (Android SDK nodig)
- [ ] App draait op een iOS-simulator tegen een lokale vogels3: inloggen met code, team
      wisselen, RSVP, live-wedstrijd volgen. `[user-gated]`
- [ ] Push komt binnen op een echt toestel en opent het juiste event. `[user-gated]`
- [ ] TestFlight- en Play-internal-test-build geüpload. `[user-gated]`

## Open questions
- Bundle-id/appnaam definitief? (Voorlopig `nl.assistje.app` / "Assistje".)
- Moet de app ook team-*aanmelden* (nieuw team starten) aanbieden, of verwijst die knop naar
  de website? Pariteit zegt: native — tenzij je liever de funnel op de site houdt.
- Minimale app-versie afdwingen (force-update via `/api/v1/meta`)? Voorstel: ja, simpel
  versieveld; standaard uit.
