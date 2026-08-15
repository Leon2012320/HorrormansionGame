# ASHGROVE — Game Design Dokument

> Arbeitstitel. 2D-Horror-Survival, Godot 4, Raum-für-Raum-Standbilder.
> Status: Konzeptentwurf v0.1 — noch nichts davon ist in Stein gemeißelt.

---

## 1. Der Pitch in drei Sätzen

Du bist über Nacht im Anwesen Ashgrove eingeschlossen und hast sieben Nächte,
um herauszufinden, was hier passiert ist — bevor es dich findet.
Die Villa hat keinen Strom: dein Licht ist begrenzt, deine Zeit ist begrenzt,
und alles, was du tust, macht Geräusche.
Jede Nacht ist anders, weil das Haus selbst würfelt.

**Kernfantasie:** Nicht "kämpfe gegen das Monster", sondern
*"ich habe zu wenig Öl, zu wenig Zeit und noch drei Räume zu durchsuchen — was lasse ich weg?"*

---

## 2. Die zentrale Mechanik: drei Währungen

Das ist das Herz des Spiels. **Jede Aktion kostet mindestens eine von drei Währungen:**

| Währung | Anzeige | Woher der Druck kommt |
|---|---|---|
| **Zeit** | Uhr, 22:00 → 06:00 (480 Minuten) | Läuft nur, wenn du handelst. Nacht endet hart. |
| **Lärm** | Präsenz-Anzeige 0–5 | Lärm zieht *es* an. Bei 5 kommt es in deinen Raum. |
| **Ressourcen** | Öl, Streichhölzer, Kerzen, Werkzeug | Endlich. Nachschub ist knapp und zufällig. |

Der Spieler zahlt immer in einer Währung, um in einer anderen zu sparen.
**Beispiel — eine verschlossene Schublade:**

| Weg | Zeit | Lärm | Ressource |
|---|---|---|---|
| Mit Brecheisen aufbrechen | 5 min | +3 | Brecheisen nutzt sich ab |
| Mit Dietrich knacken | 20 min | +0 | Dietrich kann brechen (30 %) |
| Den Schlüssel suchen gehen | 40 min+ | +0 | keine |
| Im Dunkeln aufbrechen (spart Öl) | 10 min | +3 | Angst +15 |

→ Es gibt nie *die* richtige Lösung, nur die, die heute Nacht am wenigsten wehtut.
Das ist der Grund, warum das Spiel ohne Monster-KI und ohne Kampf funktioniert.

---

## 3. Die Systeme im Detail

### 3.1 Zeit

- Eine Nacht = **480 Minuten Spielzeit** (22:00–06:00).
- Die Uhr ist **aktionsbasiert**, nicht in Echtzeit. Sie tickt nur, wenn du etwas tust.
  Du kannst also in Ruhe nachdenken — der Horror kommt aus Entscheidungen, nicht aus Hektik.
- Richtwerte:
  | Aktion | Zeit |
  |---|---|
  | Raumwechsel (Nachbarraum) | 5 min |
  | Etagenwechsel (Treppe) | 10 min |
  | Möbelstück durchsuchen | 10 min |
  | Notiz/Buch lesen | 5 min |
  | Kerze platzieren & anzünden | 5 min |
  | Verstecken (pro Runde) | 10 min |
  | Ausruhen (Angst −20) | 30 min |
- Um **06:00 musst du in einem sicheren Raum sein** (Eingangshalle mit Kamin, oder ein Raum mit brennender Kerze).
  Wenn nicht: kein sofortiger Tod, sondern **Blackout** → du verlierst getragene Gegenstände
  und einen zufälligen noch nicht notierten Hinweis. Das ist schmerzhaft, aber nicht frustrierend.

### 3.2 Licht & Ressourcen

Die Villa hat keinen Strom. Licht ist Ausrüstung.

- **Öllampe** — Hauptlichtquelle. Verbraucht **1 Öl pro 10 Minuten** während sie brennt.
  Du kannst sie ausmachen (spart Öl, aber Dunkelheit → Angst +2/Min, Suchen dauert doppelt so lange).
- **Kerzen** — werden in einem *Raum platziert*, brennen 60 Minuten.
  Ein Raum mit Kerze ist **sicher**: die Präsenz betritt ihn nicht und Angst sinkt langsam.
  Kerzen sind die wichtigste taktische Ressource — sie bauen dir sichere Inseln im Haus.
- **Streichhölzer** — zum Anzünden von allem. 1 Streichholz pro Anzündvorgang. Sehr knapp.
- **Werkzeug** — Brecheisen (laut, schnell), Dietrich (leise, langsam, kann brechen), Schlüssel (perfekt, aber selten).
- **Laudanum** — senkt Angst sofort um 40, kostet 10 min. Nebenwirkung: die nächsten 60 min siehst du Dinge, die nicht da sind (falsche Hotspots im Raum).

**Traglimit:** 6 Slots. Du kannst nicht alles mitnehmen — was du dabei hast, ist eine Aussage darüber,
was du heute Nacht vorhast.

### 3.3 Angst (0–100)

| Steigt durch | Sinkt durch |
|---|---|
| Dunkelheit (+2/min) | Sicherer Raum mit Kerze (−1/min) |
| Zufallsereignisse (+5 bis +25) | Ausruhen am Kamin (−20, 30 min) |
| Heimsuchung (+30) | Laudanum (−40, mit Nebenwirkung) |
| Leichen/Funde/Visionen (+10) | Einen Hinweis ins Notizbuch eintragen (−5) |

Schwellen:
- **ab 50** — Bildschirmrand pulsiert, Herzschlag hörbar, Hotspots flackern
- **ab 75** — falsche Hotspots erscheinen, Türen führen manchmal woanders hin
- **bei 100** — **Zusammenbruch**: 60 Minuten Zeitsprung, du wachst an einem zufälligen Ort auf,
  Inventar verstreut, Präsenz auf 4.
- **Drei Zusammenbrüche in einem Durchlauf = Game Over.**

### 3.4 Die Präsenz (Bedrohungsstufe 0–5)

Kein patrouillierendes Monster mit Pathfinding — das passt nicht zu festen Raumbildern.
Stattdessen ein **Druck-Zähler**, der zu dir kommt.

- Steigt durch: Lärm-Aktionen, Zeitverlauf (+1 alle 90 min), bestimmte Ereignisse, hohe Angst.
- Sinkt durch: Stillsitzen (10 min = −1), sicherer Raum, Anbruch der Morgendämmerung.
- Zeigt sich gestaffelt: **1** = Geräusche eine Etage entfernt · **2** = im selben Stockwerk ·
  **3** = Schritte im Nachbarraum · **4** = die Türklinke bewegt sich · **5** = **Heimsuchung**.

**Heimsuchung** (das einzige "Echtzeit"-Element im Spiel): 20 Sekunden, in denen du reagieren musst.
- Lampe sofort löschen und stillhalten → funktioniert, kostet aber Angst +30
- In einen Schrank/unters Bett (falls im Raum vorhanden) → sicher, kostet 10 min
- In einen Raum mit brennender Kerze fliehen → sicher, wenn erreichbar
- Nichts tun → du verlierst 90 Minuten und einen Gegenstand, Angst +50

### 3.5 Zufallsereignisse — der "Drama-Manager"

Das Haus würfelt, aber es würfelt **nicht fair, sondern dramaturgisch**.
Statt reinem Zufall ein gewichtetes Deck, das den Spielzustand liest
(Nacht-Nummer, Angst, Präsenz, Licht an/aus, Raum, wie lange nichts passiert ist).

Fünf Kategorien:

| Kategorie | Anteil | Beispiele |
|---|---|---|
| **Atmosphäre** (folgenlos) | 40 % | Ein Bild fällt von der Wand · Schritte über dir · dein Atem wird sichtbar |
| **Bedrohung** | 20 % | Präsenz +2 · eine Tür verriegelt sich hinter dir · das Licht geht aus |
| **Ressource** | 15 % | Streichhölzer im Sofa · eine halbvolle Ölkanne · ein Schlüssel im Kaminrost |
| **Weltveränderung** | 15 % | Der Flur führt heute Nacht woanders hin · ein Raum ist "verdorben" (Angst doppelt) · ein neuer Raum öffnet sich |
| **Story/Vision** | 10 % | Eine Erinnerung, die dir ein Hinweis-Fragment gibt |

**Anti-Frust-Regeln (wichtig):**
- Kein Bedrohungs-Event zweimal hintereinander.
- Wenn 40 Minuten nichts passiert ist → garantiert ein Atmosphäre-Event (das Haus darf nie still wirken).
- Wenn der Spieler unter 20 % Ressourcen hat → Ressourcen-Events werden doppelt gewichtet (verstecktes Mitleid).
- Jedes Event kann nur einmal pro Nacht ziehen.

### 3.6 Das Geheimnis — die eigentliche Siegbedingung

Überleben ist nicht das Ziel, sondern die Bedingung. Das Ziel ist **Verstehen**.

Ein **Notizbuch** mit vier offenen Fragen:

1. **Wer** ist in dieser Villa gestorben?
2. **Wo** genau ist es passiert?
3. **Was** will es?
4. **Wie** bringt man es zur Ruhe?

Jede Frage braucht **3 Fragmente** (12 insgesamt, im Spiel verteilt sind ~20 — du findest nie alle).
Fragmente kommen aus Notizen, Gegenständen, Visionen und Ereignissen.
Der Spieler muss sie **selbst kombinieren** — das Spiel löst es nicht für ihn:
Du wählst pro Frage eine Antwort aus mehreren Möglichkeiten.

**Das Finale:** In der 7. Nacht führst du in der Verborgenen Kammer das Ritual durch,
mit den Gegenständen, die deine vier Antworten vorgeben.
- Alle vier richtig → **Bannung** (bestes Ende)
- Zwei bis drei richtig → **Flucht** (du überlebst, aber es bleibt)
- Weniger → **Übernahme** (schlechtes Ende)
- Ritual nie versucht, aber 7 Nächte überlebt → **Morgen** (neutrales Ende)

→ **Wiederspielwert:** Der Täter/Ort/Motiv wird pro Durchlauf aus mehreren Varianten gewürfelt.
Du kannst die Lösung nicht auswendig lernen, nur die *Methode*.

---

## 4. Ablauf einer Nacht

```
  ┌─ VORBEREITUNG (Eingangshalle, keine Zeit läuft) ───────────┐
  │  Inventar sichten · 6 Slots packen · Notizbuch lesen       │
  │  Ziel für die Nacht wählen (optional, gibt Bonus)          │
  └──────────────────────────────┬─────────────────────────────┘
                                 ▼
  ┌─ DIE NACHT (22:00 – 06:00) ────────────────────────────────┐
  │  Raum betreten → Hotspots anklicken → Zeit/Lärm zahlen     │
  │  Ereignisse ziehen · Präsenz steigt · Öl brennt runter     │
  │  Fragmente finden → ins Notizbuch eintragen                │
  └──────────────────────────────┬─────────────────────────────┘
                                 ▼
  ┌─ MORGENGRAUEN (06:00) ─────────────────────────────────────┐
  │  Im sicheren Raum? → Nacht bestanden                       │
  │  Sonst → Blackout (Verlust von Gegenständen + 1 Hinweis)   │
  └──────────────────────────────┬─────────────────────────────┘
                                 ▼
  ┌─ TAG-INTERLUDE (Text + Standbild) ─────────────────────────┐
  │  Kurze Erzählung · minimaler Nachschub · Nacht N+1         │
  └────────────────────────────────────────────────────────────┘
```

**Sieben Nächte, mit Steigerung:**

| Nacht | Was neu ist |
|---|---|
| 1 | Tutorial ohne Präsenz. Nur Haus, Uhr, Öl. Ein Fragment garantiert. |
| 2 | Präsenz aktiv (max. 3). Keller wird zugänglich. |
| 3 | Erste Heimsuchung möglich. Weltveränderungs-Events schalten frei. |
| 4 | Wendepunkt: Ein Raum wird dauerhaft unbetretbar. Öl-Nachschub halbiert. |
| 5 | Dachboden öffnet sich. Präsenz startet bei 2. |
| 6 | Die Villa "atmet": Raumverbindungen ändern sich pro Nacht. |
| 7 | Verborgene Kammer erreichbar. Kein Morgengrauen — es endet so oder so. |

---

## 5. Die Villa — Raumplan

14 Räume, vier Ebenen. Der sichere Raum ist die Eingangshalle.

```
  DACHBODEN            [12] Dachboden
                              │
  OBERGESCHOSS   [8]──[7 Oberer Flur]──[9]      [10] Bad
                 Schlaf-      │   │    Kinder-    │
                 zimmer       │   └──[11] Arbeitszimmer
                              │
  ERDGESCHOSS  [3]──[2]──[1 EINGANGSHALLE]──[4]──[5]──[6]
              Biblio- Salon    ▲ SICHER    Speise- Küche Winter-
              thek                │        zimmer        garten
                                  │
  KELLER                    [13] Weinkeller ── [14] Verborgene Kammer
```

| # | Raum | Rolle im Spiel | Ab Nacht |
|---|---|---|---|
| 1 | Eingangshalle | Sicherer Raum, Kamin, Ausrüstung, Speicherpunkt | 1 |
| 2 | Salon | Viele Möbel zum Durchsuchen, Klavier (laut!) | 1 |
| 3 | Bibliothek | Hauptquelle für Notiz-Fragmente, Geheimtür | 1 |
| 4 | Speisezimmer | Kerzenleuchter, Silber (Ritualgegenstand) | 1 |
| 5 | Küche | Öl, Streichhölzer, Kellerzugang | 1 |
| 6 | Wintergarten | Einziger Blick nach draußen, Wetter-Events | 2 |
| 7 | Oberer Flur | Drehscheibe, hier ändern sich ab Nacht 6 die Türen | 1 |
| 8 | Schlafzimmer | Bett zum Verstecken, persönliche Gegenstände | 1 |
| 9 | Kinderzimmer | Emotionaler Kern der Story, hohe Angst | 2 |
| 10 | Bad | Spiegel-Mechanik (Visionen), Wasser | 3 |
| 11 | Arbeitszimmer | Safe mit Zahlenschloss, Dokumente | 2 |
| 12 | Dachboden | Truhen, das meiste Öl, sehr gefährlich | 5 |
| 13 | Weinkeller | Dunkel, kein Kerzenhalter, Abkürzungen | 2 |
| 14 | Verborgene Kammer | Ritualort, Finale | 7 |

**Für den ersten Prototyp reichen 5 Räume:** Eingangshalle, Salon, Bibliothek, Küche, Oberer Flur.

---

## 6. Steuerung & Bildschirmaufbau

Maus-first (Point & Click), Tastatur als Alternative.

```
┌──────────────────────────────────────────────────────────┐
│ 03:20  ▓▓▓▓▓░░░ Öl        Präsenz ●●●○○      Angst ▓▓▓░░ │ ← HUD oben
├──────────────────────────────────────────────────────────┤
│                                                          │
│                  RAUMBILD (Standbild)                    │
│         Hotspots leuchten schwach beim Hovern            │
│                                                          │
├──────────────────────────────────────────────────────────┤
│ [🕯][🔥][🔧][📄][ ][ ]        [Notizbuch] [Karte] [Lampe]│ ← Inventar unten
└──────────────────────────────────────────────────────────┘
```

- **Linksklick Hotspot** → Aktionsmenü ("Durchsuchen — 10 min · leise", "Aufbrechen — 5 min · LAUT")
  Die Kosten stehen **immer vorher** dran. Der Spieler soll informiert entscheiden, nicht raten.
- **Rechtsklick** → ansehen (kostenlos, gibt Atmosphäre-Text)
- **Tab** → Notizbuch · **M** → Karte · **L** → Lampe an/aus · **Leertaste** → in Heimsuchung: verstecken

---

## 7. Technische Struktur (Godot 4.x, GDScript)

**Grundprinzip: datengetrieben.** Räume, Gegenstände, Ereignisse und Hinweise sind
`Resource`-Dateien (`.tres`), kein hartcodierter Inhalt. So kannst du Inhalte im Godot-Editor
hinzufügen, ohne eine Zeile Code zu schreiben.

```
res://
├── project.godot
├── src/
│   ├── autoload/
│   │   ├── game_state.gd      # Nacht, Uhr, Angst, Präsenz, Flags
│   │   ├── clock.gd           # Zeit vorspulen, Signale bei Schwellen
│   │   ├── event_deck.gd      # Drama-Manager, gewichtetes Ziehen
│   │   ├── inventory.gd       # 6 Slots, Ressourcenverbrauch
│   │   ├── notebook.gd        # Fragmente, Fragen, Antworten
│   │   ├── audio.gd           # Bus-Management, Ducking bei Heimsuchung
│   │   └── save_system.gd     # JSON-Speicherstand pro Nacht
│   ├── data/                  # Resource-Klassen (Schema)
│   │   ├── room_data.gd · item_data.gd · event_data.gd
│   │   ├── clue_data.gd · action_data.gd · hotspot_data.gd
│   │   └── ...
│   ├── scenes/
│   │   ├── main.tscn          # Einstieg, Szenenwechsel
│   │   ├── room_view.tscn     # Zeigt ein RoomData an
│   │   ├── hotspot.tscn       # Klickbereich + Outline-Shader
│   │   ├── haunting.tscn      # Die 20-Sekunden-Sequenz
│   │   └── interlude.tscn     # Tag-Übergang
│   └── ui/
│       ├── hud.tscn · inventory_bar.tscn · notebook.tscn
│       ├── map.tscn · action_menu.tscn · main_menu.tscn
├── content/                   # DIE eigentlichen Inhalte als .tres
│   ├── rooms/ · items/ · events/ · clues/
├── assets/                    # Grafik (siehe ASSET_PLAN.md)
└── audio/
```

**Wichtige Godot-Details für diesen Stil:**
- Projekt-Auflösung **640×360**, Stretch-Mode `viewport`, Aspect `keep` → knackige Pixel bei jeder Fenstergröße
- Textur-Import: Filter **Nearest**, Mipmaps aus
- Licht/Dunkelheit über `CanvasModulate` + `PointLight2D` mit weichem Lichtkegel-Textur —
  **so brauchst du pro Raum nur EIN Bild**, keine Hell/Dunkel-Varianten
- Hotspots als `Area2D` mit `CollisionPolygon2D`, im Editor direkt aufs Raumbild gemalt
- Speichern nur zwischen den Nächten (kein Quicksave — das ist Teil des Drucks)

---

## 8. Entwicklungs-Roadmap

| Meilenstein | Inhalt | Ergebnis |
|---|---|---|
| **M0 — Gerüst** | Godot-Projekt, Ordner, Autoloads leer, ein Raum mit Platzhalter | Startet und zeigt einen Raum |
| **M1 — Kernschleife** | Uhr, Raumwechsel, Hotspots, Aktionen mit Zeitkosten | Eine Nacht ist spielbar |
| **M2 — Druck** | Öl/Licht, Angst, Präsenz, Heimsuchung | Es wird bedrohlich |
| **M3 — Zufall** | Event-Deck mit Drama-Manager, 30 Ereignisse | Jede Nacht fühlt sich anders an |
| **M4 — Geheimnis** | Notizbuch, Fragmente, Kombinieren, Enden | Das Spiel hat ein Ziel |
| **M5 — Inhalt** | Alle 14 Räume, 7 Nächte, ~60 Ereignisse | Vollständiger Durchlauf |
| **M6 — Politur** | Deine echten Sprites rein, Sound, Balancing, Menüs | Veröffentlichbar |

---

## 9. Offene Entscheidungen

Diese Punkte habe ich vorläufig festgelegt — sag Bescheid, wenn du es anders willst:

1. **Titel** — "Ashgrove" ist nur ein Platzhalter.
2. **Zeitalter** — Ich bin von ~1920er ausgegangen (Öllampe statt Taschenlampe, kein Strom).
   Modern (Taschenlampe + Batterien) würde auch funktionieren, ändert aber die Ressourcen-Fantasie.
3. **Sprache** — Konzept auf Deutsch. Spieltexte: Deutsch, Englisch oder beides?
4. **Tod** — Aktuell kein sofortiger Tod, sondern Verlust. Härter (Permadeath) wäre möglich.
5. **Umfang** — 7 Nächte / 14 Räume ist ambitioniert. Eine 3-Nächte-Version wäre ein realistisches erstes Ziel.
