# Entscheidungstabelle — ASHGROVE

Alles, was bisher festgelegt wurde, in einer Liste zum Durchgehen.
**Stand: Konzept v0.4**

## Legende

| Zeichen | Bedeutung |
|---|---|
| ✅ | **Von dir entschieden.** Steht fest, ich fasse es nicht an. |
| 💡 | **Mein Vorschlag.** Braucht dein OK oder dein Nein. |
| ⚠️ | **Mein Vorschlag mit Bedenken.** Bitte hier besonders draufschauen. |

**So antwortest du am schnellsten:** Nur die Nummern nennen, die weg sollen oder
anders müssen. Alles, was du nicht erwähnst, gilt als angenommen.

---

## A · Rahmen

| # | Thema | Festlegung | |
|---|---|---|---|
| A1 | Engine | Godot 4, GDScript | ✅ |
| A2 | Perspektive | Raum für Raum, feste Standbilder, Point & Click | ✅ |
| A3 | Grafik | Du zeichnest die echten Sprites, ich baue nur Platzhalter | ✅ |
| A4 | Zeitalter | Anfang der 1960er, Strom vorhanden aber ausgefallen | ✅ |
| A5 | Spieltexte | Englisch | ✅ |
| A6 | Dokumentation | Deutsch | ✅ |
| A7 | Rahmenhandlung | Du bist auf der Flucht vor etwas ins Haus gelaufen, die Tür fiel zu | ✅ |
| A8 | Spielfigur | Namenlos, ohne Vorgeschichte, wird nie gezeigt oder beschrieben | ✅ |
| A9 | Auflösung | 640 × 360, skaliert auf 1080p | 💡 |
| A10 | Titel | "Ashgrove" ist ein Platzhalter | 💡 |

## B · Die vier Achsen

| # | Thema | Festlegung | |
|---|---|---|---|
| B1 | Kernprobleme | Essen, Schlaf, Sicherheit, Licht — mehr Systeme gibt es nicht | ✅ |
| B2 | Anzeigen | FOOD und REST als Leisten am Spieler, LIGHT und SAFETY als Werte des Raums | 💡 |
| B3 | Keine Angst-Leiste | Gestrichen, war ein System zu viel | ✅ |
| B4 | Kein Wasser | Zweite Verbrauchsleiste würde dieselbe Entscheidung doppelt stellen | 💡 |
| B5 | FOOD-Verbrauch | 3 pro wacher Stunde, 1 pro Schlafstunde → 56 pro Tag | 💡 |
| B6 | REST-Verbrauch | 5 pro wacher Stunde; Bett gibt +20/h, Boden +8/h | 💡 |
| B7 | LIGHT-Stufen | 0 dunkel · 1 Taschenlampe · 2 Kerze · 3 elektrisch | 💡 |
| B8 | SAFETY-Stufen | 0 offen · 1 zu · 2 Möbel davor · 3 vernagelt | 💡 |
| B9 | Barrikaden halten nicht | Ereignisse beschädigen sie, Reparatur kostet Material | 💡 |
| B10 | Traglimit | 6 Slots, Rest liegt im Lager | 💡 |
| B11 | Lager frei wählbar | Der Spieler entscheidet selbst, welcher Raum sein Lager wird | 💡 |

## C · Strom und 60er-Technik

| # | Thema | Festlegung | |
|---|---|---|---|
| C1 | Sicherungskasten | Im Keller, **drei** Sicherungen für 13 Räume, jederzeit umsteckbar | ✅ |
| C2 | Strom verändert Ereignisse | Elektrisches Licht macht das Haus wach — andere Ereignisse, nicht weniger | 💡 |
| C3 | Radio | Im Salon, einzige Vorwarnung auf die Rettung | ✅ |
| C4 | Telefon | Im Arbeitszimmer, Leitung tot, klingelt trotzdem | ✅ |
| C5 | Blitzlichtkamera | **Gestrichen** | ✅ |
| C6 | Tonbandgerät | **Gestrichen** | ✅ |
| C7 | Herd braucht Strom | Warme Mahlzeit (+55 statt +35) kostet eine deiner drei Sicherungen | 💡 |

## D · Schlaf — die Hauptmechanik

| # | Thema | Festlegung | |
|---|---|---|---|
| D1 | Verteilung | **90 % aller Ereignisse passieren im Schlaf** | ✅ |
| D2 | Tag ist ruhig | Wach nur 4 % Ereignischance pro Raumwechsel, meist harmlos | 💡 |
| D3 | Ziehung | 35 % pro Schlafstunde, gedämpft durch LIGHT und SAFETY | 💡 |
| D4 | Bester Schlafplatz | Kommt auf ~8 % pro Stunde — eine ruhige Nacht in vier. Nie ganz sicher. | 💡 |
| D5 | Dauer wählbar | Spieler wählt Raum und Stundenzahl vor dem Schlafen | 💡 |
| D6 | Risiko vorher sichtbar | In Worten, nicht als Prozentzahl ("Dark. Open. You should not sleep here.") | 💡 |
| D7 | Wake-Ereignisse | Manche wecken dich → echte Entscheidung mitten in der Nacht | 💡 |
| D8 | Night Report | Am Morgen eine Seite: was passiert ist, was fehlt, was kaputt ist | 💡 |
| D9 | REST 0 | Du brichst zusammen, wo du stehst — 6 Stunden ohne Wahl des Ortes | 💡 |
| D10 | REST unter 20 | Halluzinationen: falsche Hotspots, falsche Hinweise, falsche Geräusche | 💡 |
| D11 | Erste Nacht ruhig | Immer. Der Spieler soll einmal denken, es sei alles in Ordnung. | 💡 |
| D12 | Stolperschnur | Wandelt schwere Ereignisse in "du wachst rechtzeitig auf", wird dabei zerstört | 💡 |

## E · Ereignisse

| # | Thema | Festlegung | |
|---|---|---|---|
| E1 | Einzige Bedrohung | Keine Kreatur mit Wegfindung, kein Verfolger, keine Bedrohungsanzeige | ✅ |
| E2 | Kategorien | Sound · Wake · Damage · Theft · Mark · Clue · Move | 💡 |
| E3 | Choice-Regel | Keine Option darf offensichtlich die beste sein | 💡 |
| E4 | Kein Ereignis tötet | Ereignisse geben Zustände, Zustände töten bei Vernachlässigung | ✅ |
| E5 | Fairness | Nie zwei Damage-Ereignisse pro Nacht, höchstens ein Mark | 💡 |
| E6 | Leise Hilfe | FOOD unter 25 → Fundereignisse verdreifacht | 💡 |
| E7 | "The missing page" | Abgeschwächt: Fragment wird unleserlich, ist am Fundort wieder holbar | ✅ |
| E8 | "Tucked In" | Abgeschwächt: Gegenstand taucht 2–4 Tage später woanders auf | ✅ |
| E9 | Deckgröße jetzt | 45 ausgeschriebene Ereignisse | ✅ |
| E10 | Deckgröße nötig | ⚠️ **Ein 50-Tage-Durchlauf zieht ~150 Ereignisse.** Mit 45 wiederholt sich alles dreifach. Vor Release müssen es **mindestens 150** sein — reine Schreibarbeit, aber viel davon. | ⚠️ |

## F · Zeit, Länge, Enden

| # | Thema | Festlegung | |
|---|---|---|---|
| F1 | Kein Countdown | Der Spieler bekommt nie gesagt, wie lange er noch drin ist | ✅ |
| F2 | Uhr | Läuft aktionsbasiert, nicht in Echtzeit. Nachdenken ist kostenlos. | 💡 |
| F3 | Tag/Nacht | Tag 08:00–20:00, Nacht 20:00–08:00 | 💡 |
| F4 | Volle Länge | **50 Tage** bis zur Rettung | ✅ |
| F5 | Geheimnis lösbar | **Ab Tag 20**, gedachter Normalweg endet Tag 22–28 | ✅ |
| F6 | Rettung ist der harte Weg | Tag 50 ist der Ausdauerweg für Könner, nicht der Normalfall | 💡 |
| F7 | Rettungstag fest | Kein Würfeln — Tag 50, aber nie genannt | 💡 |
| F8 | Radio-Staffel | 11 Meldungen von Tag 1 bis 50, tasten sich heran | 💡 |
| F9 | Der Tiefpunkt | Tag 34: "Die Suche wurde eingestellt." Erst Tag 40 zeigt, dass es weitergeht. | 💡 |
| F10 | Ende: THE DOOR | Alle vier Fragen richtig | ✅ |
| F11 | Ende: THE THRESHOLD | 2–3 Fragen richtig — du kommst raus, aber nicht allein | 💡 |
| F12 | Ende: RESCUE | Tag 50 erreicht | ✅ |
| F13 | Ende: THE WINDOW | Fenster einschlagen, ab Tag 1 möglich, endet schlecht | 💡 |
| F14 | Eskalation | Neue Decks ab Tag 4, 8, 16, 20, 26, 34 | 💡 |

## G · Das Geheimnis

| # | Thema | Festlegung | |
|---|---|---|---|
| G1 | Nichts wird erklärt | Keine Auflösung, in keinem Ende | ✅ |
| G2 | Kein Wesen wird benannt | Nur Wirkungen: offene Tür, warmer Stuhl, fehlendes Glas | ✅ |
| G3 | Widersprüche bleiben | Zwei Notizen widersprechen sich, ein Datum stimmt nicht, das ist Absicht | 💡 |
| G4 | Die Sache draußen | Wird nie geklärt, kommt nicht wieder vor | ✅ |
| G5 | Vier Fragen | Fragen nach **Regeln**, nie nach Identität | 💡 |
| G6 | 12 Fragmente | 3 pro Frage, im Spiel liegen mehr als nötig | 💡 |
| G7 | Lösung wird gewürfelt | Pro Durchlauf neu — nicht auswendig lernbar | 💡 |
| G8 | Falsche Antwort | Kostet die verwendeten Gegenstände und einen Tag, kein Tod | 💡 |

## H · Tod

| # | Thema | Festlegung | |
|---|---|---|---|
| H1 | Permadeath | Tod ist endgültig, kein Zurücksetzen | ✅ |
| H2 | Ereignisse töten nicht | Sie geben Zustände: Injured, Sick, Shaken, Starving | ✅ |
| H3 | Zwei Stufen | Zustände eskalieren erst nach 12 Stunden zu Bleeding / Fevered | 💡 |
| H4 | Vorwarnung | ⚠️ Kein Tod ohne 24 Stunden sichtbare Warnung — Pflicht bei dieser Spiellänge | ⚠️ |
| H5 | Autosave | Ein Speicherstand zwischen den Tagen, wird beim Tod gelöscht | 💡 |
| H6 | Kartenwissen bleibt | Beim Neustart ist der Grundriss bekannt, alles andere neu gewürfelt | 💡 |
| H7 | Spielzeit pro Durchlauf | ⚠️ 50 Tage sind grob **6–10 Stunden**. Ein Tod an Tag 38 ist bitter. Falls das im Test nicht trägt: freiwilliger Modus mit Speicherpunkten statt weicherem Tod. | ⚠️ |

## I · Nahrung über 50 Tage

| # | Thema | Festlegung | |
|---|---|---|---|
| I1 | Die Lücke | ⚠️ Hausvorräte decken **11 von 50 Tagen**. Ohne eigene Produktion verhungerst du garantiert. | ⚠️ |
| I2 | Wintergarten-Anbau | 4 Beete, 10 Tage Reifezeit, täglich gießen, ~150 Punkte pro Ernte | 💡 |
| I3 | Licht beschleunigt | Beet unter elektrischem Licht reift in 7 statt 10 Tagen — bindet eine Sicherung | 💡 |
| I4 | Samen-Rückfluss | Jede Ernte gibt mit 50 % Chance Saatgut zurück | 💡 |
| I5 | Fallen | Brett + Draht, alle 2–3 Tage +25 FOOD, roh 20 % *Sick* | 💡 |
| I6 | Die Falle im Design | Wer erst an Tag 15 mit dem Anbau anfängt, schafft Tag 50 nicht mehr — die Entscheidung fällt in Woche 1, bevor der Druck spürbar ist | 💡 |
| I7 | Alles andere schrumpft | Licht, Material, Medizin wachsen **nicht** nach, nur Ernte und Fallen | 💡 |

## J · Die Villa

| # | Thema | Festlegung | |
|---|---|---|---|
| J1 | 13 Räume | Vier Ebenen, jeder Raum an eine Achse gebunden | 💡 |
| J2 | Prototyp-Räume | Entrance Hall, Kitchen, Bedroom, Library, Cellar | 💡 |
| J3 | Haustür | Der Ausgang, geht nicht auf — harte Grenze | ✅ |
| J4 | Fenster | Nicht vernagelt, einschlagbar. Der Wintergarten zeigt, warum man es lässt. | 💡 |
| J5 | Räume tauschen Verbindungen | Ab Tag 16 | 💡 |
| J6 | Türen aufbrechen | Mit Brecheisen möglich, aber der Raum kommt nie über SAFETY 1 hinaus | 💡 |
| J7 | Möbel zerlegen | Gibt 2–3 Bretter, verändert den Raum dauerhaft | 💡 |

## K · Technik

| # | Thema | Festlegung | |
|---|---|---|---|
| K1 | Datengetrieben | Räume, Items, Ereignisse, Hinweise als `.tres` — Inhalte ohne Code erweiterbar | 💡 |
| K2 | Ein Bild pro Raum | Licht per Shader darüber, keine Hell/Dunkel-Varianten zeichnen | 💡 |
| K3 | Pixel-Art | Nearest-Filter, kein Anti-Aliasing, gemeinsame Palette ~32 Farben | 💡 |
| K4 | Asset-Umfang Prototyp | 43 Grafiken, davon 5 Raumbilder | 💡 |
| K5 | Ton wichtiger als Grafik | Die Bedrohung ist unsichtbar — bei knapper Zeit lieber besserer Ton | 💡 |

---

## Die drei Punkte, auf die ich dich besonders hinweisen will

**1 · Die Deckgröße (E10).** Ein 50-Tage-Durchlauf zieht rund 150 Ereignisse.
Wir haben 45. Das heißt: entweder wächst das Deck auf 150+, oder ein Durchlauf
fühlt sich in der zweiten Hälfte sehr wiederholt an. Das ist kein technisches
Problem, sondern schlicht viel Schreibarbeit — und es ist der größte Einzelposten
im ganzen Projekt.

**2 · Permadeath bei 6–10 Stunden Spielzeit (H7).** Das ist eine harte Kombination.
Ich habe drei Sicherungen eingebaut (Vorwarnung, Autosave gegen Abstürze,
Kartenwissen bleibt). Ob das reicht, zeigt erst der Test.

**3 · Der Anbau (I1–I7).** Den habe ich neu erfunden, weil deine 50 Tage sonst
mathematisch unmöglich wären. Er ist ein ordentliches System für sich — wenn du
das Spiel schlanker willst, ist das die Stelle, an der man streichen müsste.
Dann müsste allerdings die Länge runter.
