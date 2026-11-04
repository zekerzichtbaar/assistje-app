# Storebeelden en app-icoon

Alles hier wordt **gegenereerd uit de echte app**, met een fictief demoteam
(FC Dijkzicht 1, `test/store/demo_data.dart`). Verandert er iets aan de UI?
Draai het script opnieuw, dan lopen de beelden mee.

```sh
# Screenshots + Play-featuregraphic (docs/store/…)
STORE_OUT=docs/store flutter test test/store --tags store

# … en ook het app-icoon (iOS-appiconset, Android-mipmaps, Play 512)
STORE_OUT=docs/store STORE_ICONS=1 flutter test test/store --tags store
```

Zonder `STORE_OUT` slaan de tests zichzelf over, dus CI (`flutter test
--exclude-tags a11y`) maakt niets aan. Draai op macOS: de tekstrasterisatie
van Linux oogt minder scherp.

## Wat er ligt

| Bestand | Maat | Voor |
| --- | --- | --- |
| `ios/iphone-6.9/01…07-*.png` | 1320 × 2868 | App Store, iPhone 6,9" (Apple schaalt dit zelf naar kleinere iPhones) |
| `ios/ipad-13/01…07-*.png` | 2064 × 2752 | App Store, iPad 13" (verplicht: de app ondersteunt iPad) |
| `android/phone/01…07-*.png` | 1080 × 1920 | Google Play, telefoon (9:16) |
| `android/feature-graphic-1024x500.png` | 1024 × 500 | Google Play, featuregraphic |
| `android/icon-512.png` | 512 × 512 | Google Play, app-icoon (vol vierkant; Play rondt zelf af) |
| `ios/Runner/Assets.xcassets/AppIcon.appiconset/*` | 20–1024 px | iOS-app-icoon |
| `android/app/src/main/res/mipmap-*/ic_launcher.png` | 48–192 px | Android-icoon voor API 24–25 (afgerond, met alfa) |

Alle PNG's behalve de Android-mipmaps zijn **zonder alfakanaal**. App Store
Connect weigert een 1024-icoon met alfa, en Play wil de featuregraphic als
24-bit PNG.

Het adaptieve Android-icoon (Android 8+) is vector:
`drawable/ic_launcher_background.xml` (lijnveld) +
`ic_launcher_foreground.xml` (mascotje) + `ic_launcher_monochrome.xml`
(thema-iconen). Die worden niet gegenereerd. Pas de kleuren daar met de hand
aan als `Brand` in `test/store/store_frames.dart` verandert.

## Lettertype

De storebeelden gebruiken, net als assistje.nl, **Obviously** (Regular en
Bold). Dat is een licentiefont en staat daarom niet in de repo. Wijs bij het
genereren een map aan met de OTF/TTF-bestanden (met commerciële licentie). De
generator pakt daaruit alleen `Obviously-Regular` en `Obviously-Bold`; de
Comp/Cond/Narrow/Wide/Extd-varianten mogen in dezelfde map staan:

    STORE_FONT_DIR=~/Fonts/Obviously STORE_OUT=docs/store \
      flutter test test/store --tags store

Zonder `STORE_FONT_DIR` valt alles terug op Figtree. Gebruik niet de
*Obviously Demo*-bestanden: die missen accenten en leestekens (é, ?, !) en de
licentie verbiedt commercieel gebruik.

## Ontwerpkeuzes (huisstijl van assistje.nl)

- **Icoon:** de huisstijl van assistje.nl: het mascotje (zwarte contour, geel
  vizier) op het grasveld uit de hero, `#61F6A9` met maaistroken van 4,5 %
  zwart, zonder krijtlijnen: rustig en herkenbaar op 60 px. Geen tekst, geen
  witte rand.
- **Eén boodschap per beeld,** een kop in hoofdletters (zoals de hero van de
  site) van maximaal 5 woorden met één
  geaccentueerd woord op een markeerpil met zwarte rand en harde schaduw,
  zoals de knoppen op de site (geel op het grasveld, mint op zand). Erboven
  een wit pilletje ("01 Agenda"), zoals de sectielabels op de site. Duolingo en
  Strava verkopen een voordeel ("Wie wordt topscorer?"), geen functie
  ("Statistiekenscherm").
- **De eerste twee beelden doen het werk.** Die zie je in de zoekresultaten:
  1 = de belofte (hele team, één app, met het mascotje), 2 = de kernactie
  (aanmelden met één tik).
- **Wisselend veld:** grasveld (`#61F6A9`) en zandveld (`#F5ECDF`) om en om,
  allebei met maaistroken, zoals de secties van de site. Achter het toestel
  liggen de middenlijn en de middencirkel als zwarte krijtlijnen. Alle tekst
  is inktzwart (`#0C120D`).
- **Echte UI** in een toestelframe, met een nette statusbalk (9:41, volle
  balkjes). Dat eist Apple, en het werkt beter dan alleen marketingbeeld.
  De onderkant van het toestel loopt net uit beeld: dat oogt dynamischer en
  houdt de app groot.
- **Het mascotje** komt alleen terug op het eerste en het laatste beeld, als
  begin en afsluiting.

Teksten aanpassen: `_shots` in `test/store/store_assets_test.dart`
(`*woord*` = markeerpil). Kleuren en layout: `store_frames.dart`.

## Naar de stores

Alleen de beelden, zonder build of tekst. De huidige beelden worden vervangen:

    cd android && bundle exec fastlane images   # Play: icoon, featuregraphic, telefoonscreenshots (nl-NL)
    cd ios && bundle exec fastlane images       # App Store Connect: iPhone 6.9"/6.3" + iPad 13" (nl-NL), versie uit pubspec

Het App Store-icoon komt uit de build zelf, dus dat verandert pas bij de
volgende upload van een build (`fastlane beta` of `release`).

**App Store-header** (`ios/header-3840x1646.png`, 21:9, productpagina vanaf
iOS 27): fastlane en de gedocumenteerde API kunnen dit nog niet uploaden.
Sleep het bestand in App Store Connect → *App Previews and Screenshots* →
*Header*, of upload het via de *Asset Library*.
