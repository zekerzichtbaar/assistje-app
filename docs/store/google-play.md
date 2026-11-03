# Google Play — store-gegevens Assistje

Alles wat je in de Play Console invult, afgeleid van wat de app (en de API van
vogels3) echt doet. Stand: november 2026, app 1.0.0, `nl.assistje.app`.
Bouwen en tekenen: README → *Release (Android)*.

## Technische eisen (al geregeld in `android/`)

| Eis | Hoe |
| --- | --- |
| Target-API | `targetSdk = 36` (Android 16): verplicht voor nieuwe apps en updates sinds 31 aug 2026. `minSdk = 24`. |
| App Bundle | `flutter build appbundle --release --dart-define-from-file=env/prod.json` |
| Ondertekening | Uploadsleutel via `android/key.properties`; Play App Signing beheert de app-sleutel. |
| 16 KB-pagina's | Alle `.so`'s (libflutter, libapp, libdartjni, libdatastore_shared_counter) hebben LOAD-uitlijning ≥ 16 KB; `zipalign -c -P 16 -v 4` op de APK slaagt. |
| Edge-to-edge | Flutter tekent edge-to-edge; statusbalk-/navigatiebalkiconen volgen het app-thema (`systemBarsStyle` in `lib/app.dart`). |
| Voorspellend terug | `android:enableOnBackInvokedCallback="true"`. |
| Taal | Alleen `nl` (`localeFilters`, `res/xml/locales_config.xml`). |
| Back-up | Uit (`allowBackup=false` + `data_extraction_rules.xml`): het inlogtoken is versleuteld met een Keystore-sleutel die niet meegaat. |

### Toestemmingen in de release-manifest

| Toestemming | Waarvoor | Bron |
| --- | --- | --- |
| `POST_NOTIFICATIONS` | pushmeldingen (gevraagd na inloggen) | app |
| `INTERNET`, `ACCESS_NETWORK_STATE` | API, FCM | firebase_messaging |
| `WAKE_LOCK`, `com.google.android.c2dm.permission.RECEIVE` | FCM-berichten ontvangen | firebase_messaging |
| `VIBRATE` | trillen bij een melding | flutter_local_notifications |
| `nl.assistje.app.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` | interne beveiliging van broadcast-receivers (geen gebruikersvraag) | androidx.core |

Geen opslag-, foto-, camera-, locatie-, contacten- of wekker-toestemmingen:
foto's en bestanden kiezen loopt via de systeemkiezer (Photo Picker /
Storage Access Framework). De Play Console vraagt daarom geen
*Photo and video permissions*-verklaring.

## Data safety

Algemeen:

- **Versleuteld onderweg:** ja (alleen HTTPS naar `assistje.nl`, FCM via Google).
- **Gegevens verwijderen:** ja, de gebruiker kan zijn account verwijderen
  (zie *Accountverwijdering*).
- **Gedeeld met derden:** nee. Google (Firebase Cloud Messaging) is een
  dienstverlener die meldingen bezorgt; dat telt volgens Play niet als
  "delen".
- **Geen** advertenties, analytics-SDK's of crashrapportage in de app.

Verzameld (alles: *verplicht voor de app-functionaliteit*, *niet optioneel*
tenzij vermeld, niet gedeeld, niet voor advertenties):

| Play-categorie | Gegevenstype | Wat precies | Doel |
| --- | --- | --- | --- |
| Persoonlijke info | Naam | naam van gebruiker en spelers | App-functionaliteit, Accountbeheer |
| Persoonlijke info | E-mailadres | inloggen met code/magic link | Accountbeheer, Communicatie |
| Persoonlijke info | Overige info | geboortedatum (optioneel), rugnummer, positie | App-functionaliteit |
| Gezondheid en fitness | Gezondheidsinfo | blessure-status (optioneel, zichtbaar voor de trainer) | App-functionaliteit |
| Foto's en video's | Foto's | profielfoto, teamlogo, schermafbeeldingen bij feedback (optioneel) | App-functionaliteit, Ondersteuning (feedback) |
| Bestanden en documenten | Bestanden | geïmporteerd speelschema/CSV, scoutingrapport (optioneel, trainers) | App-functionaliteit |
| Berichten | Overige in-app-berichten | teamberichten, feedback aan Assistje | App-functionaliteit, Ondersteuning |
| App-activiteit | Overige door gebruiker gemaakte content | aanwezigheid, opstellingen, wedstrijdstatistieken, diensten, afwezigheid (met notitie), boetes en spaarpot-bedragen | App-functionaliteit |
| App-info en -prestaties | — | niet verzameld | — |
| Apparaat- of andere ID's | Apparaat-ID's | FCM-pushtoken en apparaatnaam (bij inloggen, voor "ingelogde apparaten") | App-functionaliteit (meldingen), Accountbeheer |

Niet verzameld: locatie, financiële gegevens (boetes/spaarpot zijn
teamadministratie, er gaat geen betaling via de app), contacten, agenda van het
toestel, audio, webgeschiedenis, zoekgeschiedenis, gezondheidsdata van
sensoren.

Let op bij wijzigingen: komt er analytics, crashrapportage of een nieuwe
toestemming bij, pas dan dit formulier én deze tabel aan.

## Accountverwijdering

Play eist een pad **in de app** én een **webadres** waar je verwijdering kunt
aanvragen zonder de app.

- **In de app: bestaat.** Profiel → *Account* → *Verwijderen* (typen ter
  bevestiging) → `DELETE /api/v1/profile`. Aanwezigheid en statistieken blijven
  onder een geanonimiseerd profiel bij het team staan; vermeld dat in het
  formulier als "sommige gegevens blijven bewaard (geanonimiseerd)".
- **Web: bestaat alleen ingelogd** (`https://assistje.nl/profile`,
  `DELETE /profile` in vogels3). Play wil een openbaar vindbare URL die uitlegt
  hoe het werkt. **Nog te doen:** een openbare pagina, bv.
  `https://assistje.nl/account-verwijderen`, met de stappen (inloggen →
  Profiel → Verwijderen) en een e-mailadres voor een verzoek zonder in te
  loggen. Die URL vul je in bij *Data safety → Gegevensverwijdering*.

## Privacybeleid

**Nog te doen (blokkerend):** Play wil een openbare URL naar een privacybeleid
(store-vermelding én in de app vindbaar). Er is er nu geen in vogels3 of in de
app. Maak bv. `https://assistje.nl/privacy` en zet een link in de app
(Profiel/Meer).

## Doelgroep en contentclassificatie

- **Doelgroep:** 13 jaar en ouder (aanvinken: 13–15, 16–17, 18+). De app is
  voor teams; jeugdteams worden beheerd door trainers/ouders. Kies **niet**
  "jonger dan 13": dan valt de app onder het Families-beleid (strengere eisen
  aan SDK's en advertenties) en zijn magic-link-mails aan kinderen lastig te
  verantwoorden. Spelers onder de 13 staan als speler in de app zonder eigen
  account (de trainer of een ouder beheert ze).
- **Spreekt de app kinderen aan?** Nee (zakelijke vormgeving, geen spel).
- **Contentclassificatie (IARC-vragenlijst):** categorie *Utility,
  Productivity, Communication or Other*. Geen geweld, seks, grof taalgebruik,
  gokken of drugs. **Wel**: gebruikers kunnen met elkaar communiceren
  (teamberichten, reacties op live-wedstrijden) → "Users can interact"; geen
  locatie delen; geen digitale aankopen. Verwacht resultaat: PEGI 3 / IARC 3+
  met de melding "Users interact".
- **Advertenties:** nee. **In-app-aankopen:** nee.
- **Nieuws-app:** nee. **Overheidsapp:** nee. **Gezondheidsapp:** nee (de
  blessure-status is een teamnotitie, geen medische functie).

## Store-vermelding (nl-NL)

**Naam (≤ 30):** Assistje

**Korte beschrijving (≤ 80):**

> De teamapp voor amateurteams: agenda, aanwezigheid, opstelling en meer.

**Volledige beschrijving (≤ 4000):**

> Assistje is de teamapp voor amateurteams. Trainers, spelers en ouders zien
> in één app wie er komt, wie er speelt en wie wat doet.
>
> **Agenda en aanwezigheid**
> Wedstrijden, trainingen en activiteiten op een rij. Meld je met één tik aan
> of af, en zie meteen wie er zijn. Vaste afwezigheid en vakanties geef je één
> keer door.
>
> **Opstelling en live wedstrijd**
> Zet de opstelling klaar op het veld, houd tijdens de wedstrijd de stand,
> doelpunten en wissels bij, ook bij verlenging en strafschoppen. Wie niet
> kan kijken volgt de wedstrijd live.
>
> **Diensten**
> Rijden, wassen, fluiten, bardienst: plan diensten en zie wie aan de beurt
> is.
>
> **Statistieken en ranglijsten**
> Doelpunten, assists, speelminuten, man van de wedstrijd en de stand in de
> poule.
>
> **Team regelen**
> Teamberichten, afspraken, boetepot en spaarpot, het rad voor eerlijke
> beurten, en uitnodigen via een teamlink.
>
> **Meldingen**
> Een seintje als er iets verandert, alleen voor wat jij belangrijk vindt.
>
> Inloggen gaat met je e-mailadres, zonder wachtwoord. Assistje werkt voor
> voetbal, hockey, volleybal en andere teamsporten.

(Pas de sportenlijst aan als die niet klopt; claim geen functies die de app
niet heeft.)

**Categorie:** Sport. **Tags:** teambeheer, sportclub.
**Contact:** e-mailadres en website (`https://assistje.nl`) verplicht.

## Graphics

| Wat | Eis | Bestand |
| --- | --- | --- |
| App-icoon | 512×512, 32-bit PNG, ≤ 1 MB | `docs/store/android/icon-512.png` |
| Feature graphic | 1024×500, JPEG of 24-bit PNG (geen alfa) | `docs/store/android/feature-graphic-1024x500.png` |
| Telefoon-screenshots | 2–8 stuks, 16:9 of 9:16, 320–3840 px; ≥ 4 van ≥ 1080 px voor aanbevelingen | `docs/store/android/phone/01…07-*.png` (7 × 1080×1920) |
| Tablet-screenshots (7"/10") | optioneel, alleen als je tablets wilt aanbevelen | — |

Alles wordt gegenereerd uit de echte app (Android-gedrag, demoteam). Zie
`docs/store/README.md` voor het opnieuw maken en de ontwerpkeuzes.

## Clubwapen als app-icoon

Het app-icoon wisselt automatisch naar het wapen van de club van het actieve
team: per club een uitgeschakelde `activity-alias` met het wapen in de build
(module `android/club_icons`, `tool/app_icons.dart`), waarvan
`AppIconChannel.kt` er één aanzet. Daar is geen toestemming of verklaring voor
nodig. Zie README → *App-iconen*.

## App Links

`assetlinks.json` (vogels3, `ANDROID_SHA256_FINGERPRINTS` in `.env`) moet de
SHA-256 van de **app-ondertekeningssleutel van Play** bevatten (Play Console →
*Testen en releasen → App-integriteit*), anders openen links naar
`assistje.nl` de browser i.p.v. de app. Voeg ook de uploadsleutel toe voor
interne test-builds.
