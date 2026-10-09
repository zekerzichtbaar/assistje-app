# Next slice — native-app

Read `docs/slides/native-app/OVERVIEW.md` first — it's the north star and guardrail.
Background facts and the full feature inventory are in `docs/slides/native-app/ANALYSIS.md`.
(`docs/slides/native-app/PROGRESS.md` does not exist yet; this is the first slice.)

Two repos are involved:
- API: `/Users/michaelvansetten/Sites/vogels3` (Laravel; read its `CLAUDE.md` first).
- App: `/Users/michaelvansetten/Sites/assistje-app` (Flutter; empty, not touched this slice).

## This slice
Lay the API foundation in vogels3: token auth (link + 6-digit code), team scoping that
is safe before route-model binding, the `/api/v1/me` bootstrap, and the first read
endpoint (agenda), all tested. This is the thinnest end-to-end path every later slice
builds on.

## Scope boundaries
- Do:
  - `cd vogels3`, check the tree is clean, `git switch -c feat/mobile-api prod-deploy`,
    `composer install` (vendor/ is missing), `npm ci` only if tests need it.
    Confirm `php artisan test` is green **before** changing anything.
  - Sanctum: publish config + `personal_access_tokens` migration, `HasApiTokens` on `User`.
    No `composer require`.
  - Login code: add a hashed 6-digit code to `LoginToken` (migration), include it in
    `MagicLoginMail`, with the same TTL, 5 attempts max, and a throttle.
  - `POST /api/v1/auth/request` (email + optional team) and `POST /api/v1/auth/exchange`
    (`token` **or** `email`+`code`, plus `device_name`). This returns a Sanctum token and
    repeats the side effects of `MagicLoginController::consume` (extract them into a shared
    Action used by both). Add `POST /api/v1/auth/logout` (revokes the current token).
  - Team-scope middleware for `/api/v1/teams/{team}/…`: membership check (super-admin
    allowed), `CurrentTeam::set()`, registered in the middleware priority **before**
    `SubstituteBindings`, plus `scopeBindings()`.
  - `GET /api/v1/me`: user, teams (whitelisted Team resource with absolute logo URL), and
    per team: role, abilities, features, sport profile, unread count. Use
    `HandleInertiaRequests::share()` as the blueprint.
  - `GET /api/v1/teams/{team}/agenda` (upcoming/past, paginated like the PWA). Reuse
    `AgendaController`'s data building by extracting it into a query/presenter class that
    the web controller also uses.
  - Pest tests for all of the above, including: the cross-team 404 **without** pre-setting
    `CurrentTeam`; the Team resource never containing `provisional`/`ical_token`/`sportlink_*`;
    code expiry and lockout; token and code exchange.
  - Start `docs/api/v1.md` (conventions + these endpoints with example JSON).
  - Commit on `feat/mobile-api` in small, Dutch-language commits.
- Don't:
  - Touch the Flutter folder.
  - Build RSVP/write endpoints, push, AASA or PWA changes (later slices).
  - Push the branch, merge, deploy or migrate anything outside the local/test DB.

## Done when
- `php artisan test` is fully green on `feat/mobile-api`.
- With a local token, `curl` against `/api/v1/me` and `/api/v1/teams/{id}/agenda` returns
  the whitelisted JSON, and `/api/v1/teams/{other-team}/…` returns 403/404.
- `docs/api/v1.md` exists with the conventions and the endpoints above.

When finished, run `/handoff` to record progress and write the next slice.
