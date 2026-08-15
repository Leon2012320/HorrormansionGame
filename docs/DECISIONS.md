# Entscheidungstabelle — ASHGROVE

Alles, was bisher festgelegt wurde. **Stand: Konzept v0.5**

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
| C4 | Nebeneffekt | ⚠️ Ein Durchlauf zieht jetzt ~14 Nachtereignisse statt 150. **Damit reichen die 45 geschriebenen Ereignisse** — das alte Deck-Problem ist erledigt. | ⚠️ |

## D · Die vier Achsen

| # | Thema | Festlegung | |
|---|---|---|---|
| D1 | Kernprobleme | Essen, Schlaf, Sicherheit, Licht | ✅ |
| D2 | Anzeigen | **ENERGY** (Punkte) · **FOOD** (Leiste) · **LIGHT** und **SAFETY** (Raumwerte) | 💡 |
| D3 | **REST-Leiste gestrichen** | Schlaf ist keine Anzeige mehr, sondern bestimmt direkt die ENERGY von morgen | 💡 |
| D4 | Keine Angst-Leiste | Bleibt gestrichen | ✅ |
| D5 | Kein Wasser | Wäre dieselbe Entscheidung doppelt | 💡 |
| D6 | FOOD-Verbrauch | −10 pro Tag plus −3 pro Handlung → normaler Tag −28 | 💡 |
| D7 | Arbeiten macht hungrig | Die eingebaute Bremse gegen Vielspielen | 💡 |
| D8 | LIGHT-Stufen | 0 dunkel · 1 Taschenlampe · 2 Kerze · 3 elektrisch | 💡 |
| D9 | SAFETY-Stufen | 0 offen · 1 zu · 2 Möbel davor · 3 vernagelt | 💡 |
| D10 | Barrikaden halten nicht | Ereignisse setzen sie herunter, Reparatur kostet wieder | 💡 |
| D11 | Traglimit | ⚠️ 6 Slots — aber weil Laufen kostenlos ist, könnte die Beschränkung zahnlos sein | ⚠️ |
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
| F7 | Wake-Ereignisse | Wecken dich → echte Entscheidung mitten in der Nacht | 💡 |
| F8 | Aufwachen kostet | Das Segment zählt dann nicht für ENERGY | 💡 |
| F9 | Night Report | Morgens eine Seite: was passiert ist | 💡 |
| F10 | Erste Nacht ruhig | Immer | 💡 |
| F11 | *Exhausted* | Zwei Nächte hintereinander nur 1 Segment → Halluzinationen, ENERGY −2 | 💡 |
| F12 | Stolperschnur | Wandelt schwere Ereignisse in Aufwachen, wird dabei zerstört | 💡 |

## G · Ereignisse

| # | Thema | Festlegung | |
|---|---|---|---|
| G1 | Einzige Bedrohung | Keine Kreatur, kein Verfolger, keine Bedrohungsanzeige | ✅ |
| G2 | Kategorien | Sound · Wake · Damage · Theft · Mark · Clue · Move | 💡 |
| G3 | Choice-Regel | Keine Option darf offensichtlich die beste sein | 💡 |
| G4 | Kein Ereignis tötet | Sie geben Zustände, Zustände töten bei Vernachlässigung | ✅ |
| G5 | Fairness | Nie zwei Damage pro Nacht, höchstens ein Mark, jedes nur einmal pro Tag | 💡 |
| G6 | Leise Hilfe | FOOD unter 25 → Fundereignisse verdreifacht | 💡 |
| G7 | Abgeschwächt | "Missing page" ist wieder holbar · "Tucked In" gibt das Item später zurück | ✅ |
| G8 | Deckgröße | 45 Nacht- und 22 Tagereignisse, **alle vollständig ausgeschrieben** | ✅ |
| G9 | Ausbaustufe | Später Wake auf 20 und Sound auf 12 bringen, Rest kann bleiben | 💡 |

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
| I1 | Hausvorräte | ~350 Punkte = **12 von 20 Tagen** | 💡 |
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

## Was sich gegenüber v0.4 geändert hat

| Weg | Neu |
|---|---|
| Uhr mit 480 Minuten pro Nacht | ENERGY: feste Zahl Handlungen pro Tag |
| REST als Leiste | Schlaf bestimmt direkt die ENERGY von morgen |
| Zeitkosten in Minuten | Kosten in Handlungen (0, 1 oder 2) |
| 50 Tage | 20 Tage |
| Autosave zwischen den Tagen | Keine Speicherung |
| Kartenwissen bleibt beim Neustart | Vorschlag: fällt weg (H6) |
| 4 Beete, 10 Tage Reife | 2 Beete, 5 Tage Reife |
| Deck muss auf 150 wachsen | 45 reichen |

---

## Die drei Punkte, auf die ich dich hinweisen will

**1 · Das Traglimit könnte zahnlos sein (D11).** Sechs Slots waren eine echte
Beschränkung, solange Laufen Zeit gekostet hat. Jetzt ist Laufen kostenlos — du kannst
also beliebig oft hin- und herrennen. Entweder das Limit fällt weg, oder Laufen zwischen
Etagen kostet doch etwas. Ich würde es erst einmal so lassen und im Test anschauen.

**2 · Kartenwissen beim Neustart (H6).** Bei 50 Tagen war es sinnvoll, den zweiten
Durchlauf abzukürzen. Bei 20 Tagen und einer Stunde Spielzeit würde ich es streichen —
sonst ist der zweite Durchlauf deutlich leichter als der erste, und Permadeath
verliert seinen Sinn.

**3 · Die Abwärtsspirale ist scharf (I9).** Wenig schlafen heißt wenig Handlungen,
heißt wenig finden, heißt schlechter schlafen. Wer zwei schlechte Nächte hintereinander
hat, kommt kaum zurück. Das ist gutes Survival-Design, aber es muss im Test geprüft
werden — sonst ist ein Durchlauf an Tag 6 faktisch verloren, während der Spieler noch
zehn Tage weiterspielt.
