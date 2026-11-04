# App Store — store-gegevens Assistje

Wat je in App Store Connect invult. Stand: november 2026, app 1.0.0,
`nl.assistje.app`. Bouwen en uploaden: README → *Release (iOS)*
(`ios/fastlane`). Beelden: `docs/store/README.md`. Voor gedeelde onderwerpen
(privacybeleid, accountverwijdering, wat er verzameld wordt) is
`google-play.md` de bron.

## Vermelding (Nederlands)

**Naam (≤ 30):** Assistje

**Ondertitel (≤ 30):** De teamapp voor amateurteams *(28)*

**Promotietekst (≤ 170, zonder review aan te passen):**

> Wie komt er zaterdag? Zet de opstelling klaar, volg de wedstrijd live en
> zie wie topscorer is. Alles voor je team in één app.

**Trefwoorden (≤ 100 tekens, komma's zonder spaties, geen woorden die al in
naam/ondertitel staan):**

```
voetbal,hockey,volleybal,aanwezigheid,opstelling,trainer,club,wedstrijd,agenda,boetepot,training
```

*(96 tekens.)* "team", "teamapp" en "amateur" staan al in de naam en
ondertitel en tellen dus al mee.

**Beschrijving:** gelijk aan de *Volledige beschrijving* in
`google-play.md`. Daar is één tekst de bron, zodat de stores niet uit elkaar
lopen.

**Wat is er nieuw (1.0.0):**

> De eerste versie van Assistje in de App Store.

**Ondersteunings-URL:** `https://assistje.nl` (verplicht)
**Marketing-URL:** `https://assistje.nl` (optioneel)
**Privacybeleid-URL:** `https://assistje.nl/privacy` (ook in de app: Profiel →
Privacybeleid).

## Categorie en leeftijd

- **Primair:** Sport. **Secundair:** Productiviteit.
- **Leeftijdsclassificatie:** alles "Nee"/"Geen", behalve **door gebruikers
  gegenereerde content / berichten** (teamberichten, reacties). Verwacht
  resultaat: **9+** of **12+**, afhankelijk van de nieuwe Apple-vragenlijst.
  Geen Kids-categorie (zie de doelgroepkeuze in `google-play.md`).

## App-privacy ("voedingslabel")

Dezelfde gegevens als de Play-tabel *Data safety*. In Apple-termen: alles
**gekoppeld aan de gebruiker**, **niet gebruikt om te volgen**, doel
*App-functionaliteit*, en voor e-mail ook *Accountbeheer*:

| Apple-categorie | Type |
| --- | --- |
| Contactgegevens | Naam, E-mailadres |
| Gezondheid en fitness | Gezondheid (blessurestatus, optioneel) |
| Gebruikersinhoud | Foto's, Overige gebruikersinhoud (berichten, aanwezigheid, opstellingen, statistieken), Klantenservice (feedback) |
| ID's | Apparaat-ID (pushtoken) |
| Overige gegevens | Geboortedatum (optioneel), rugnummer, positie |

**Niet verzameld:** locatie, financiële info, browse- of zoekgeschiedenis,
diagnostiek, gebruiksgegevens en analytics.

## App Review

- **Inloggen:** zonder wachtwoord, met een code per e-mail. Apple kan die
  e-mail niet ontvangen. Daarvoor is er een reviewaccount met een vaste
  code: vogels3 `APP_REVIEW_EMAIL` + `APP_REVIEW_CODE` (`.env` op productie),
  als trainer in het demoteam `demo-voetbal` (de uurlijkse `demo:reset`
  koppelt het steeds opnieuw). Vul adres en code in bij *App Review
  Information → Sign-in required* (Guideline 2.1).
- **Notities voor de reviewer** (voorbeeld):

  > Assistje is een teamapp voor amateursportteams. Log in met
  > review@assistje.nl en code ######. Het account zit in het demoteam
  > "Assistje" met wedstrijden, een opstelling en statistieken.
  > Pushmeldingen worden na het inloggen gevraagd.

- **Account verwijderen in de app:** bestaat (Guideline 5.1.1(v)): Profiel →
  Account → Verwijderen.
- **Export compliance:** `ITSAppUsesNonExemptEncryption = false` staat al in
  `Info.plist` (alleen HTTPS).

## Screenshots

App Store Connect vraagt (november 2026) als **verplichte** iPhone-maat de
"iPhone with Dynamic Island (medium display)", 6,1"/6,3", 1206×2622:
`docs/store/ios/iphone-6.3/`. Die gebruikt Apple ook voor alle andere
iPhones. Daarnaast iPad 13": `docs/store/ios/ipad-13/`. De 6,9"-set
(`iphone-6.9/`) is optioneel ("large display"). De volgorde is de
bestandsnaam: 01 en 02 staan in de zoekresultaten.

Uploaden kan via de API (de webpagina van Media Manager hapert soms):
spaceship `AppScreenshot.create` per bestand in de set
`APP_IPHONE_61` / `APP_IPAD_PRO_3GEN_129`, met de sleutel uit
`ios/fastlane/.env`.
