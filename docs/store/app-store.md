# App Store — store-gegevens Assistje

Wat je in App Store Connect invult. Stand: november 2026, app 1.0.0,
`nl.assistje.app`. Bouwen en uploaden: README → *Release (iOS)*
(`ios/fastlane`). Beelden: `docs/store/README.md`. Voor gedeelde onderwerpen
(privacybeleid, accountverwijdering, wat er verzameld wordt) is
`google-play.md` de bron.

## Vermelding (Nederlands)

Apple ID: **6830074966** —
`https://apps.apple.com/nl/app/assistje/id6830074966`.

Zoekgewicht: naam > ondertitel > trefwoorden. Een woord telt één keer, dus
wat in naam of ondertitel staat hoort niet meer in de trefwoorden.
Stopwoorden ("voor", "en", "&") tellen niet mee. Naam, ondertitel en
trefwoorden wijzigen alleen met een nieuwe versie (review); de promotietekst
kan altijd.

**Naam (≤ 30):** Assistje: teamapp voor sport *(28)*

*(Was "Assistje": 22 tekens ongebruikt, terwijl de naam het zwaarst weegt.)*

**Ondertitel (≤ 30):** Voetbal, hockey, korfbal & co *(29)*

**Promotietekst (≤ 170, zonder review aan te passen):**

> Wie komt er zaterdag? Zet de opstelling klaar, volg de wedstrijd live en
> zie wie topscorer is. Alles voor je team in één app.

Pas hem aan per seizoensmoment (seizoensstart, winterstop, toernooien).

**Trefwoorden (≤ 100 tekens, komma's zonder spaties):**

```
volleybal,aanwezigheid,opstelling,trainer,coach,elftal,team,wedstrijd,agenda,boetepot,training,club
```

*(99 tekens.)* "teamapp", "sport", "voetbal", "hockey" en "korfbal" staan al in
naam en ondertitel. "team" staat er los in: Apple ziet "teamapp" als één woord.

## Vermelding Engels (VK) — extra trefwoorden voor Nederland

De Nederlandse App Store doorzoekt naast de Nederlandse ook de **Engelse
(VK)**-vermelding. Die geeft dus nog een naam, ondertitel en 100 tekens
trefwoorden die in Nederland meetellen. Naam en ondertitel zien gebruikers
met hun iPhone op Engels; de trefwoorden ziet niemand, dus daar kunnen
Nederlandse woorden in die hierboven niet pasten. (Controleer in App Store
Connect → *App-informatie* → *Lokalisaties* dat dit nog zo werkt.)

**Naam:** Assistje: Sports Team App *(25)*

**Ondertitel:** Football, hockey & korfball *(27)*

**Trefwoorden:**

```
amateur,ploeg,spelers,sportclub,vereniging,teammanager,spaarpot,diensten,topscorer,poule,uitslag
```

*(96 tekens.)* Beschrijving en screenshots mogen de Nederlandse zijn.

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

## Vindbaarheid en groei

### "assistje" wordt verbeterd naar "assistent"

De App Store verbetert onbekende zoektermen met weinig volume. Dat gaat over
naarmate mensen op "assistje" zoeken en Assistje installeren. Versnellen:

- **Apple Search Ads** (searchads.apple.com, *Advanced*): een campagne op
  alleen het exacte trefwoord `assistje` (en eventueel `assistje app`), klein
  dagbudget. Er biedt niemand anders op, dus de klik is goedkoop, en
  installaties via die zoekterm leren Apple dat het een merknaam is.
- **Directe links in plaats van zoeken:** overal waar mensen de app moeten
  vinden de App Store-link of een QR-code, niet "zoek op Assistje".
  - In de app: Profiel → *Tip een ander team* deelt op iOS de App
    Store-link (`lib/core/store/store_links.dart`).
  - Teamlinks en uitnodigingen gaan naar `login.assistje.nl`. Zonder app
    toont die pagina een **Smart App Banner** en downloadknoppen, maar alleen
    als `IOS_APP_STORE_ID=6830074966` in de `.env` van vogels3 op productie
    staat (`config/mobile.php`).
  - assistje.nl: een App Store-badge en dezelfde
    `<meta name="apple-itunes-app" content="app-id=6830074966">`.

### Beoordelingen

Beoordelingen wegen zwaar voor de positie en de conversie. De app vraagt er
zelf om (`lib/core/store/review_prompt.dart`) met de systeemvraag van Apple,
op een blij moment: een wedstrijd afgesloten (live → eindsignaal), een
opstelling gedeeld, "ik ben erbij" op een event. Pas na 3 zulke momenten,
als de app 3 dagen op het toestel staat, hooguit eens per 120 dagen, en nooit
in een demoteam (App Review). iOS toont de vraag zelf hooguit 3× per jaar.
Daarnaast staat in Profiel *Beoordeel Assistje* (opent de store-pagina).

Reageer in App Store Connect op elke beoordeling; dat zien andere bezoekers.

### Aangepaste productpagina's

App Store Connect → *Aangepaste productpagina's*: per sport een pagina met
eigen screenshots en promotietekst (voetbal, hockey, volleybal, korfbal),
elk met een eigen link. Gebruik die link als je een club van die sport
benadert. Zonder nieuwe build, wel met review.

### Elke update telt

Een app die regelmatig een update krijgt, met korte release notes in
"Wat is er nieuw", doet het beter dan een stilstaande app. Een nieuwe versie
is ook het moment om naam, ondertitel en trefwoorden bij te stellen. Kijk in
App Store Connect → *App-analyse* → *Bronnen* welke zoektermen installaties
opleveren en schuif de trefwoorden daarop.

