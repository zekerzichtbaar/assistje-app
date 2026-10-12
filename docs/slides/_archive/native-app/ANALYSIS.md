# Analyse — vogels3 (Assistje) → native Flutter-app

> Momentopname 2026-10-09, branch `prod-deploy` @ `e23c0655`. Bronrepo:
> `/Users/michaelvansetten/Sites/vogels3`. Paden hieronder zijn relatief aan die repo.
> Dit is naslag voor de slices; de noordster is `OVERVIEW.md`.

## 1. Wat het is

Laravel 12 + Inertia v2 + React 18 + Tailwind 3 teamapp voor Nederlandse amateurteams,
in productie als **Assistje**. Vier sporten (voetbal, hockey, volleybal, korfbal) via
`app/Sports/*Profile.php`. Elk team draait op een eigen subdomein (`<slug>.assistje.nl`)
en wordt als losse PWA geïnstalleerd. ~70 Inertia-pagina's, ~75 controllers,
`routes/web.php` 877 regels, ~2.100 Pest-tests (in-memory SQLite).

## 2. Het kernprobleem (bevestigd in de code)

De installatiedrempel zit in de PWA zelf:

- **iOS heeft geen installeerknop**: `Components/InstallSteps.tsx` legt per browser 3–4
  stappen uit via het verborgen Deel-menu (iOS 26 verplaatste dat weer; comments
  documenteren herhaald breken).
- **Uitnodigingen openen in WhatsApp/Gmail in-app browsers**, waar installeren
  onmogelijk is → eerst link kopiëren naar Safari.
- **Installeren en push zijn twee stappen**: push werkt op iOS alleen in de
  geïnstalleerde app, dus installeren → nieuw icoon openen → opnieuw push vragen.
- **Geïnstalleerde app = opnieuw inloggen** (iOS scheidt opslag van Safari; login is
  alleen magic-link per mail).
- **Eén beginscherm-app per team** (subdomein); de teamwisselaar redirect cross-origin.
- Vijf plekken vragen hetzelfde (WelcomeSheet, InstallHint, AppStepBanner, `/app`,
  PushPrompt) met eigen cooldowns en wisselende termen.

Een store-app lost alle zes tegelijk op: één download, push via het OS, in-app
teamwissel, sessie blijft bewaard.

## 3. Functionaliteit (volledige inventaris)

Rollen: `trainer`, `player`, `spectator` ("toeschouwer") op de `team_user`-pivot.
Abilities (`app/Enums/Ability.php`): `lineup`, `training_points`, `fines`
(= penningmeester). Trainer heeft ze impliciet allemaal; superadmin is overal trainer.
Middleware: `trainer`, `treasurer`, `not_spectator`, `feature:<key>[,<key>]` (404 als
uit), `can:<ability>`.

| Gebied | Kernroutes | Wie | Gebruik |
|---|---|---|---|
| Agenda (home): aankomend/verleden/mijn taken, verjaardagen, inline RSVP | `GET /agenda` | iedereen | dagelijks |
| Event-detail: info, RSVP, tellingen, spelers per status, MOTM, carpool, diensten, spaarpot-inleg, sportlink-info, live | `GET /events/{e}` | iedereen | dagelijks |
| RSVP zelf (`present/absent/nonplay/pending`, reden bij `absence_reason`) | `PATCH /events/{e}/attendance` | speler, staf, toeschouwer alleen bij `spectators_can_rsvp` | dagelijks |
| Aanwezigheid namens anderen | `GET /events/{e}/attendance`, `PATCH …/{player}`, `…/staff/{user}` | trainer | dagelijks (trainer) |
| Events CRUD, afgelasten, import (bestand, voetbal.nl, iCal-feed, "regel het voor me") | `/schedule/*` | trainer | beheer |
| Opstelling (formaties per sport, drag&drop, publiceren) | `/events/{e}/lineup*` | zien: iedereen na publicatie; bewerken `can:lineup` | wedstrijddag |
| Live: klok, goals, tegengoal, kaarten, momenten, wissels | `/events/{e}/live/*`, `/goals`, `/cards`, `/moments`, `/subs` (al JSON) | `can:lineup` + `feature:live` | dagelijks |
| Live volgen, reacties (6 emoji), publieke live-pagina met token | `/events/{e}/live/follow`, `/live/reactions`, `/live/{token}` | leden; publiek | dagelijks |
| Wedstrijdverslag: score, sets, spelersstats, scout-import, vlagdienst | `/events/{e}/report*`, `PUT /events/{e}/flag` | `can:lineup` | na wedstrijd |
| MOTM stemmen | `POST/DELETE /events/{e}/motm` | iedereen met account, niet op jezelf | dagelijks |
| Carpool | `POST/DELETE /events/{e}/carpool` | leden, `feature:carpool` | dagelijks |
| Diensten: groepen, auto-indelen, toewijzingen, afvinken | `/duties/*`, `PATCH /events/{e}/duties/{type}` | trainer beheert, speler ziet | beheer/zien |
| Trainingsteams & trainingspunten | `/events/{e}/teams/*`, `/players/{p}/strength` | `can:training_points` | training |
| Gastspelers | `/events/{e}/guests*` | trainer | wedstrijddag |
| Vakanties, vaste afwezigheid, blessure | `/vacations`, `/standing-absences`, `/profile/injury`, `/players/{p}/injury` | zelf / trainer | regelmatig |
| Team-overzicht, spelerdetail | `GET /team`, `GET /players/{p}` | leden | dagelijks |
| Spelersbeheer: aanmaken, CSV-import, uitnodigen, rol, aanvoerder, abilities, trainers, toeschouwers, teamlink/QR | `/players/*`, `/trainers/*`, `/spectators/*`, `/teamlink` | trainer | beheer |
| Statistieken (+CSV), Ranglijst/Hall of Fame/titels/mijlpalen, persoonlijke stats | `/stats`, `/hall-of-fame`, `/profile` | leden, `feature:stats` | dagelijks |
| Seizoenen & periodes | `/seasons/*`, `/periods/*` | trainer | beheer |
| Poule (stand/uitslagen/programma, Sportlink) | `GET /poule` | leden, alleen met poulecode | dagelijks |
| Boetes: overzicht per periode, per persoon, toevoegen, types, periodes, pot | `/fines*`, `/fine-*` | zien: niet-toeschouwers; beheren: `treasurer` | dagelijks/beheer |
| Spaarpot: potten, betalingen afvinken, herinneren, afrekenen | `/savings*` | zien: niet-toeschouwers; beheren: `treasurer`; `feature:savings` | dagelijks/beheer |
| Radje (boeterad) | `/wheel*` | leden, `feature:wheel` | fun |
| Berichten (handmatige push + auto-push-instellingen) | `/messages*` | trainer, `feature:messages` | beheer |
| Meldingen-inbox | `/notifications*` | iedereen | dagelijks |
| Pushvoorkeuren per categorie (17 keys) | `PATCH /profile/notifications` | zelf | beheer |
| Afspraken (teamregels) | `/agreements*` | lezen: leden; schrijven: trainer | lezen |
| Profiel: naam, mail (claim), avatar (base64), spelerprofiel koppelen, account verwijderen, thema | `/profile*` | zelf | regelmatig |
| Instellingen: Team (naam, kleur, logo), Seizoen, Deadlines (RSVP), Functies (19 flags), Diensttypes, iCal roteren, carpool, gasten, trainingspunten | `/settings*` | trainer | beheer |
| Onboarding-checklist trainer | `/onboarding` | trainer nieuw team | beheer |
| Teams kiezen/wisselen/verlaten | `/teams/select`, `/teams/switch`, `/teams/{t}/leave` | ingelogd | dagelijks |
| Agenda-abonnementen (ICS, token) | `/calendar/{token}/*.ics` | tokenhouders | eenmalig |
| Feedback aan de bouwer | `/feedback*` | iedereen | soms |
| Zelf aanmelden (nieuw team) | `/aanmelden*` | publiek, algemene host | eenmalig |
| Join via teamlink / uitnodiging | `/meedoen/{token}*`, `/register/invite/{token}` | publiek | onboarding |
| Login (magic link) | `/login`, `/magic*` | publiek | — |
| Demo-omgevingen (auto-login, schrijven geblokkeerd) | `demo-<sport>.` | publiek | — |
| Superadmin-console | `admin.` | superadmin | **niet in app** |

**Feature flags** (`app/Services/Features.php`, standaard): aan — fines, wheel, stats,
motm, vacations, injuries, standing_absences, messages, push, carpool; uit —
absence_reason, live (n.v.t. volleybal), live_reactions, training_points, savings,
duty_helpers, training_teams, scout_import (alleen volleybal), agreements.

**Navigatie** (`resources/js/Layouts/navItems.ts`, `Components/BottomNav.tsx`):
tabbar Agenda · Stats (sportbal-icoon) · Ranking · Poule (als gekoppeld) · Mij.
Hamburger-menu: trainer → Spelers, Diensten, Boetepot, Spaarpot, Radje, Berichten,
Afspraken, Instellingen, Feedback; speler → Team, Boetepot, Spaarpot, Radje, Afspraken,
Feedback. Items vallen weg op feature flag / rol.

## 4. Sportprofielen (stuurt UI)

`Team::sportProfile()->toArray()` levert: scoremodel (`goals` | `sets`), statsmodus
(`timeline` | `postmatch` volleybal), periodes (voetbal 2×45 "Helft", hockey 4×17
"Kwart", korfbal 2×30, volleybal ≤5 sets), kaarten (hockey + groen), formaties met
slotcode + x/y-percentages (voetbal 4-3-3 e.a., hockey 3-3-3-1 e.a., volleybal
basis/libero P1–P6, korfbal achttal/viertal), posities, terminologie (`terms()`),
`designation()`, vlagdienst (alleen voetbal). **De app hardcodeert geen sport**; het
profiel komt als JSON uit de API.

## 5. Backend-feiten die de API bepalen

- **Geen JSON-API.** `routes/api.php` = alleen webhooks. Sommige live-endpoints
  geven al JSON/204.
- **Sanctum** zit in de lockfile (v4.3.1) maar is niet geconfigureerd — geen
  `composer require` nodig, alleen config/migratie/`HasApiTokens`.
- **Auth** = `MagicLoginService` (token sha256, 30 min / 72 u, 5 min hergebruik).
  `MagicLoginController::consume` doet `confirmEmailClaim` + `invite_accepted_at` —
  een API-exchange moet dat herhalen.
- **Tenancy** = `CurrentTeam`-singleton + `BelongsToTeam` global scope, gezet door
  `ResolveTeamFromHost`. **Let op:** die middleware draait ná `SubstituteBindings`;
  de API moet het team zetten vóór route-model binding (of scoped bindings), anders
  lekt data tussen teams. Tests verbergen dit (`actingAsTrainer()` zet het team vooraf).
- **Logica deels in dikke controllers**: `EventDetailController` 811 r.,
  `AgendaController` 537 r., `FineController` 603 r.; RSVP-bijwerkingen
  (auto-diensten, live-follow, late-change, activatie) in `AttendanceController`.
  Herbruikbaar: ~35 services in `app/Services`, `app/Support/*` (AttendanceTally =
  enige teller, FinePot, SavingsParticipants, LiveMatchPresenter, …), 15 Form Requests
  (`UpdateAttendanceRequest` hangt af van de routenaam!).
- **Shared props** in `HandleInertiaRequests::share()` = blauwdruk voor `/me`.
- **Push**: 38 notificaties via WebPush + database; `RespectsUserPreference`,
  `TimeCritical`, `TeamDatabaseChannel`; `data.url` is een webpad. Geen
  device-token-abstractie.
- **Files**: avatar als base64 → relatieve URL `/img/avatar/...`; teamlogo relatief
  `/storage/...` → API moet absolute URL's geven.
- **Lekgevaar**: `Team` heeft geen `$hidden` → `provisional`, `ical_token`,
  `sportlink_*` altijd whitelisten.
- **Demo**: `DemoMode` blokkeert schrijven behalve een allowlist van routenamen.
- `vendor/` ontbreekt in de checkout → `composer install` eerst. PHP lokaal 8.4.17
  (de CLAUDE.md-noot over 8.3 is achterhaald).

## 6. Look & feel (bron van waarheid = live React-code, niet `project/`)

- **Tokens** (`tailwind.config.js`, `resources/css/app.css`), licht/donker:
  surface `#FFFFFF`/`rgb(21,21,28)`, sunken `rgb(243,244,246)`/`rgb(10,10,16)`,
  raised `rgb(249,250,251)`/`rgb(31,31,41)`, ink `rgb(17,24,39)`/wit,
  ink-soft `rgb(55,65,81)`/`rgb(210,210,220)`, muted `rgb(107,114,128)`/`rgb(140,140,155)`,
  line `rgb(229,231,235)`/`rgb(46,46,60)`. Dark: 1px hairline wit 5,5%.
- **Teamkleur** (`Components/ThemeApplier.tsx`): `primary_color`, fallback `#006837`
  / dark `#35c07d`; contrastkleur via luminantie > 0,5; `liftForDark()` (HSL,
  L ≥ 0,5, S ≤ 0,85).
- **Status**: aanwezig emerald-600, afwezig red-600, kijken orange-500, blessure
  red-500, vakantie sky-500.
- **Type**: Figtree 400/500/600 (+ Archivo Black op de "deur"-schermen). Radii: kaart
  16, sheet 24, knoppen/pills volledig rond. Plat, hairlines, nauwelijks schaduw.
- **Iconen**: Phosphor, standaard `duotone`, actief `fill`.
- **Shell**: zwevende glazen tabbar (blur, schuivende pill met veer-animatie),
  zwevende pills linksboven (logo → terug-knop bij scroll) en rechtsboven
  (bel + hamburger), push-menu dat de app 80% wegschuift, bottom sheets met grabber,
  pull-to-refresh, swipe-back, haptics, confetti, wake-lock tijdens live.
- **Deur/onboarding**: grasgroen `#61f6a9` met maaistrepen, ink `#0c120d`, actie
  `#ffff87`, harde drop-shadow pills.
- **Copy**: alles hardcoded Nederlands, `nl-NL` datumnotatie.

## 7. Realtime

Alleen polling: `hooks/useLivePoll.ts` elke 12 s zolang live, pauzeert bij
achtergrond. Klok wordt client-side berekend uit `Event::liveState()`
(`resources/js/lib/matchClock.ts`).
