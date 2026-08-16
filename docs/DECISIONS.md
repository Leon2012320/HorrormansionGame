# Entscheidungstabelle — ASHGROVE

Alles, was bisher festgelegt wurde. **Stand: Konzept v0.6**

| Zeichen | Bedeutung |
|---|---|
| ✅ | **Von dir entschieden.** Steht fest. |
| 💡 | **Mein Vorschlag.** Braucht dein OK oder dein Nein. |
| ⚠️ | **Mein Vorschlag mit Bedenken.** Bitte draufschauen. |

**So antwortest du am schnellsten:** Nur die Nummern nennen, die weg sollen oder
anders müssen. Alles andere gilt als angenommen.

---

## A · Rahmen

| # | Thema | Festlegung | |
|---|---|---|---|
| A1 | Engine | Godot 4, GDScript | ✅ |
| A2 | Perspektive | **Ein festes Bild pro Raum**, Point & Click | ✅ |
| A3 | Grafik | Du zeichnest die echten Sprites, ich baue nur Platzhalter | ✅ |
| A4 | Zeitalter | Anfang der 1960er, Strom vorhanden aber ausgefallen | ✅ |
| A5 | Spieltexte | Englisch | ✅ |
| A6 | Dokumentation | Deutsch | ✅ |
| A7 | Rahmenhandlung | Auf der Flucht ins Haus gelaufen, die Tür fiel zu | ✅ |
| A8 | Spielfigur | Namenlos, ohne Vorgeschichte, wird nie gezeigt | ✅ |
| A9 | **Spielzeit** | **1–2 Stunden pro Durchlauf** | ✅ |
| A10 | Auflösung | 640 × 360, skaliert auf 1080p | 💡 |
| A11 | Titel | "Ashgrove" ist ein Platzhalter | 💡 |

## B · Zeit und Energie — **neu, ersetzt die alte Uhr**

| # | Thema | Festlegung | |
|---|---|---|---|
| B1 | **Keine Uhr, keine Minuten** | Ein Tag besteht aus Handlungen, nicht aus Zeit | ✅ |
| B2 | **Limitierte Energie** | Du kannst pro Tag nur eine feste Zahl Dinge tun | ✅ |
| B3 | Nicht zu viel pro Tag | Das war das Hauptproblem der alten Fassung | ✅ |
| B4 | Basis-ENERGY | 2 / 4 / 6 je nach geschlafenen Segmenten (1 / 2 / 3) | 💡 |
| B5 | Boni | Bett +1 · warme Mahlzeit +1 | 💡 |
| B6 | Abzüge | FOOD < 30 −1 · FOOD < 10 −2 · Injured −1 · Sick −1 · Bleeding/Fevered −2 · Exhausted −2 | 💡 |
| B7 | Grenzen | Maximum 8, **Minimum 1** — das Spiel sperrt sich nie zu | 💡 |
| B8 | Laufen ist kostenlos | Sonst wird jeder Weg zur Buchhaltung | 💡 |
| B9 | 1 Handlung | Durchsuchen · Radio · Kochen · Gießen · Pflanzen · Ernten · Falle bauen · Sicherung umstecken · Möbel vor die Tür | 💡 |
| B10 | 2 Handlungen | Barrikade bauen · Möbel zerlegen · Safe knacken | 💡 |
| B11 | Ein Tag am Bildschirm | 2–4 Minuten | 💡 |

## C · Länge

| # | Thema | Festlegung | |
|---|---|---|---|
| C1 | **20 Tage** statt 50 | Trifft die 1–2 Stunden | 💡 |
| C2 | Geheimnis lösbar | Ab Tag 8, Normalweg endet Tag 10–14 | 💡 |
| C3 | Rettung | Tag 20, fester Tag, wird nie genannt | 💡 |
| C4 | Nebeneffekt | Ein Durchlauf zieht ~14 Nachtereignisse statt 150. Damit reichen die geschriebenen aus — das alte Deck-Problem ist erledigt. | 💡 |

## D · Die vier Achsen

| # | Thema | Festlegung | |
|---|---|---|---|
| D1 | Kernprobleme | Essen, Schlaf, Sicherheit, Licht | ✅ |
| D2 | Anzeigen | **ENERGY** (Punkte) · **FOOD** (Leiste) · **LIGHT** und **SAFETY** (Raumwerte) | 💡 |
| D3 | **REST-Leiste gestrichen** | Schlaf ist keine Anzeige mehr, sondern bestimmt direkt die ENERGY von morgen | 💡 |
| D4 | Keine Angst-Leiste | Bleibt gestrichen | ✅ |
| D5 | Kein Wasser | Wäre dieselbe Entscheidung doppelt | 💡 |
| D6 | FOOD-Verbrauch | −8 pro Tag plus −2 pro Handlung → normaler Tag −20. **Gemessen**: mit −10/−3 verhungerte jeder Testlauf um Tag 8. | 💡 |
| D7 | Arbeiten macht hungrig | Die eingebaute Bremse gegen Vielspielen | 💡 |
| D8 | LIGHT-Stufen | 0 dunkel · 1 Taschenlampe · 2 Kerze · 3 elektrisch | 💡 |
| D9 | SAFETY-Stufen | 0 offen · 1 zu · 2 Möbel davor · 3 vernagelt | 💡 |
| D10 | Barrikaden halten nicht | Ereignisse setzen sie herunter, Reparatur kostet wieder | 💡 |
| D11 | Traglimit | 6 Slots — **jetzt die wichtigste Entscheidung des Spiels**, weil nachts nur Getragenes zählt. Der frühere Einwand ist damit erledigt. | 💡 |
| D12 | Lager frei wählbar | Der Spieler bestimmt selbst, welcher Raum sein Lager wird | 💡 |

## E · Strom und 60er-Technik

| # | Thema | Festlegung | |
|---|---|---|---|
| E1 | Sicherungskasten | Im Keller, **drei** Sicherungen für 13 Räume | ✅ |
| E2 | Umstecken | 1 Handlung plus der Weg in den Keller | 💡 |
| E3 | Strom verändert Ereignisse | Elektrisches Licht macht das Haus wach — andere Ereignisse, nicht weniger | 💡 |
| E4 | Radio | Im Salon, 1 Handlung, einzige Vorwarnung auf die Rettung | ✅ |
| E5 | Telefon | Im Arbeitszimmer, Leitung tot, klingelt trotzdem | ✅ |
| E6 | Blitzlichtkamera, Tonband | **Gestrichen** | ✅ |
| E7 | Herd braucht Strom | Warme Mahlzeit +55 statt +35, dazu ENERGY +1 morgen | 💡 |

## F · Schlaf

| # | Thema | Festlegung | |
|---|---|---|---|
| F1 | Verteilung | **90 % aller Ereignisse passieren im Schlaf** | ✅ |
| F2 | Tag ist ruhig | 4 % pro Raumwechsel, meist harmlos | 💡 |
| F3 | Segmente statt Stunden | 1, 2 oder 3 — eine Auswahl statt eines Schiebereglers | 💡 |
| F4 | Ziehung | 45 % pro Segment, abzüglich SAFETY und LIGHT | 💡 |
| F5 | Bester Schlafplatz | 15 % pro Segment. Nie ganz sicher. | 💡 |
| F6 | Risiko vorher sichtbar | In Worten, nicht als Prozentzahl | 💡 |
| F7 | Problem-Ereignisse | Wecken dich → du setzt einen Gegenstand ein oder zahlst | 💡 |
| F8 | Gelöst kostet nichts | Wer vorbereitet war, schläft weiter. Ungelöst kostet das Segment. | 💡 |
| F9 | Night Report | Morgens eine Seite: was passiert ist | 💡 |
| F10 | Erste Nacht ruhig | Immer | 💡 |
| F11 | *Exhausted* | Zwei Nächte hintereinander nur 1 Segment → Halluzinationen, ENERGY −2 | 💡 |
| F12 | Stolperschnur | Muss **getragen** werden; wandelt Diebstahl in ein lösbares Problem, wird dabei zerstört | 💡 |

## G · Ereignisse

| # | Thema | Festlegung | |
|---|---|---|---|
| G1 | Einzige Bedrohung | Keine Kreatur, kein Verfolger, keine Bedrohungsanzeige | ✅ |
| G2 | **Mit Gegenständen lösen, nicht mit Entscheidungen** | Das Spiel fragt nicht, was du tun willst, sondern was du dabei hast | ✅ |
| G3 | **Nur Getragenes zählt nachts** | Das Lager nützt um drei Uhr morgens nichts. Damit werden die sechs Slots zur Kernentscheidung. | 💡 |
| G4 | Umpacken kostet nichts | Die Entscheidung soll nur Nachdenken kosten, keine Handlung | 💡 |
| G5 | Kategorien | Problem (40 %) · Sound (25 %) · Damage · Theft · Clue · Move | 💡 |
| G6 | Drei bleiben unlösbar | Damage, Theft, Move — sonst wäre das Haus nur eine Packliste | 💡 |
| G7 | Jede Lösung muss naheliegen | Wer bei "etwas arbeitet an den Brettern" an einen Hammer denkt, soll recht haben | 💡 |
| G8 | Kein Ereignis tötet | Sie geben Zustände, Zustände töten bei Vernachlässigung | ✅ |
| G9 | Fairness | Nie zwei Damage pro Nacht, jedes Ereignis nur einmal pro Tag | 💡 |
| G10 | Leise Hilfe | FOOD unter 25 → Fundereignisse verdreifacht | 💡 |
| G11 | Abgeschwächt | "Missing page" ist wieder holbar · gestohlene Sachen tauchen wieder auf | ✅ |
| G12 | Deckgröße | 16 Problem- und 24 weitere Nachtereignisse, 11 am Tag — alle ausgeschrieben | ✅ |
| G13 | Ausbaustufe | Problem-Ereignisse später auf 25 bringen; sie sind die Kategorie, die trägt | 💡 |

## H · Tod

| # | Thema | Festlegung | |
|---|---|---|---|
| H1 | Permadeath | Tod ist endgültig | ✅ |
| H2 | **Keine Speicherung** | Kein Autosave, kein Speicherpunkt, kein Laden. Gestrichen. | ✅ |
| H3 | Ereignisse töten nicht | Zustände töten, wenn man sie ignoriert | ✅ |
| H4 | Zwei Stufen | Injured → Bleeding nach 2 Tagen · Sick → Fevered nach 3 Tagen | 💡 |
| H5 | Vorwarnung | Kein Tod ohne zwei Tage sichtbare Warnung | 💡 |
| H6 | Kein Kartenwissen mehr | ⚠️ Bei 20 Tagen und 1–2 Stunden ist ein Neustart zumutbar. Vorschlag: **auch die Karte startet leer**, sonst wird der zweite Durchlauf zu leicht. | ⚠️ |

## I · Nahrung

| # | Thema | Festlegung | |
|---|---|---|---|
| I1 | Hausvorräte | ~350 Punkte = 12 von 20 Tagen; Möbelstücke füllen sich nach 4 Tagen mit halber Ausbeute wieder auf | 💡 |
| I2 | Geheimnisweg | Geht knapp ohne Anbau auf | 💡 |
| I3 | Rettungsweg | Braucht eigene Produktion | 💡 |
| I4 | Wintergarten | **2 Beete** (statt 4), 5 Tage Reife, Gießen alle 2 Tage, ~100 Punkte pro Ernte | 💡 |
| I5 | Licht beschleunigt | Elektrisch: 4 statt 5 Tage — bindet eine Sicherung | 💡 |
| I6 | Samen-Rückfluss | 50 % pro Ernte | 💡 |
| I7 | Fallen | Brett + Draht, alle 2 Tage +25 FOOD, roh 20 % *Sick*, max. 3 | 💡 |
| I8 | Nur zwei Dinge wachsen nach | Ernte und Fallen. Licht, Material, Medizin werden nur weniger. | 💡 |
| I9 | Abwärtsspirale | Wenig schlafen → wenig Handlungen → wenig finden → schlechter schlafen. Das ist das eigentliche Fail-State-Design. | 💡 |

## J · Das Geheimnis

| # | Thema | Festlegung | |
|---|---|---|---|
| J1 | Nichts wird erklärt | Keine Auflösung, in keinem Ende | ✅ |
| J2 | Kein Wesen wird benannt | Nur Wirkungen | ✅ |
| J3 | Widersprüche bleiben | Zwei Notizen widersprechen sich, ein Datum stimmt nicht | 💡 |
| J4 | Die Sache draußen | Wird nie geklärt | ✅ |
| J5 | Vier Fragen | Fragen nach **Regeln**, nie nach Identität | 💡 |
| J6 | 12 Fragmente | 3 pro Frage, im Haus liegen mehr Fundorte als nötig | 💡 |
| J6b | **Jedes Fragment streicht eine falsche Antwort** | Drei Fragmente lassen genau eine Möglichkeit übrig. Ohne das müsste der Spieler mit 1:256 raten — die Fragmente wären reine Zähler. | 💡 |
| J6c | Hinweis-Gegenstände geben Fragmente | War im Code nicht verdrahtet: das Geheimnis war schlicht nicht lösbar | ✅ |
| J7 | Lösung gewürfelt | Pro Durchlauf neu | 💡 |
| J8 | Falsche Antwort | Kostet die Gegenstände und einen Tag, kein Tod | 💡 |

## K · Enden

| # | Ende | Wie | |
|---|---|---|---|
| K1 | **THE DOOR** | Alle vier Fragen richtig, ab Tag 8 | ✅ |
| K2 | **THE THRESHOLD** | 2–3 richtig — du kommst raus, aber nicht allein | 💡 |
| K3 | **RESCUE** | Tag 20 erreichen | ✅ |
| K4 | **THE WINDOW** | Fenster einschlagen, ab Tag 1, endet schlecht | 💡 |
| K5 | **DEATH** | Zustand zweiter Stufe oder FOOD 0, endgültig | ✅ |

## L · Die Villa

| # | Thema | Festlegung | |
|---|---|---|---|
| L1 | 13 Räume | Jeder an eine Achse gebunden | 💡 |
| L2 | Prototyp | Entrance Hall, Kitchen, Bedroom, Library, Cellar | 💡 |
| L3 | Haustür | Der Ausgang, geht nicht auf | ✅ |
| L4 | Fenster | Einschlagbar, aber der Wintergarten zeigt vorher warum nicht | 💡 |
| L5 | Räume tauschen Verbindungen | Ab Tag 7 | 💡 |
| L6 | Türen aufbrechen | 1 Handlung, aber der Raum kommt nie über SAFETY 1 | 💡 |
| L7 | Möbel zerlegen | 2 Handlungen, 2–3 Bretter, verändert den Raum dauerhaft | 💡 |
| L8 | Dachboden und Kinderzimmer | Öffnen sich erst ab Tag 7 | 💡 |

## M · Technik

| # | Thema | Festlegung | |
|---|---|---|---|
| M1 | Datengetrieben | Räume, Items, Ereignisse als `.tres` — erweiterbar ohne Code | 💡 |
| M2 | Ein Bild pro Raum | Licht per Shader darüber | ✅ |
| M3 | Pixel-Art | Nearest-Filter, kein Anti-Aliasing, ~32 Farben | 💡 |
| M4 | Asset-Umfang Prototyp | 44 Grafiken, davon 5 Raumbilder | 💡 |
| M5 | Ton wichtiger als Grafik | Die Bedrohung ist unsichtbar | 💡 |

---

## Was sich zuletzt geändert hat

| Weg | Neu |
|---|---|
| Uhr mit Minuten | ENERGY: feste Zahl Handlungen pro Tag |
| REST als Leiste | Schlaf bestimmt direkt die ENERGY von morgen |
| 50 Tage | 20 Tage |
| Autosave | Keine Speicherung |
| **Ereignisse mit Verhaltensoptionen** | **Ereignisse mit Gegenständen lösen** |
| Inventar egal für Ereignisse | **Nur Getragenes zählt nachts** |

## Die Punkte, auf die ich dich hinweisen will

**1 · Die Packliste ist jetzt das Spiel (G3).** Nachts zählt nur, was du am Körper
trägst. Der Smoke-Test zeigt die Wirkung: Solange das Lager mitzählte, löste der Bot
50 % aller Probleme, mit der Beschränkung sind es 28 %. Das frühere Problem — sechs
Inventarplätze ohne Bedeutung — ist damit erledigt.

**2 · Sechs von sechzehn Problemen brauchen Bretter.** Das ist viel für ein
einzelnes Material. Vielleicht sollte ein zweites Baumaterial her, sonst ist die
Packliste in Wahrheit immer dieselbe.

**3 · Werkzeuge halten ewig.** Hammer und Brecheisen gehen nie kaputt. Ein
Bruchrisiko von etwa 5 % pro Nacht würde Ersatzbeschaffung erzwingen und dem
Mittelspiel eine Sorge geben, die es gerade nicht hat.

**4 · Der Bot überlebt zu 55 %, ohne je eine Barrikade zu bauen.** Die
SAFETY-Achse ist immer noch schwächer als gedacht — sie senkt nur die
Ziehungschance, verhindert aber kein einziges Problem. Denkbar wäre, dass
bestimmte Probleme bei SAFETY 3 gar nicht erst gezogen werden.
