# ASHGROVE — Game Design Dokument

> Arbeitstitel. 2D-Horror-Survival, Godot 4, Raum-für-Raum-Standbilder.
> **Version 0.2** — kompletter Umbau nach Feedback: keine festen Nächte,
> keine direkte Monster-Bedrohung, weniger Systeme.
> Spieltexte auf Englisch, Setting Anfang der 1960er.

---

## 1. Der Pitch

Du bist nachts vor *etwas* weggelaufen und in das erstbeste Haus geflüchtet.
Die Tür ist hinter dir zugefallen. Sie geht nicht mehr auf.

Du weißt nicht, wie lange du hier drin sein wirst. Es gibt keine Frist, keinen
Countdown, kein "überlebe sieben Nächte". Es gibt nur die Vorräte, die noch da sind,
und die Frage, wie du an mehr kommst.

**Kernfantasie:** Nicht Flucht vor einem Monster, sondern das langsame Rechnen:
*"Zwei Dosen übrig. Ich bin seit 19 Stunden wach. Der Keller ist unerforscht,
aber da unten ist es dunkel — und letztes Mal, als ich im Dunkeln gesucht habe,
ist etwas passiert."*

Der nächste Verwandte im Regal ist **This War of Mine** — nur dass der Krieg
draußen durch ein Haus ersetzt ist, das nicht will, dass du gehst.

---

## 2. Die vier Achsen

Alles im Spiel hängt an genau vier Dingen. Mehr gibt es nicht.

**Zwei davon gehören dir** und werden als Leiste angezeigt:

| Achse | Anzeige | Was passiert, wenn sie fällt |
|---|---|---|
| **FOOD** (Essen) | 0–100 | Unter 30: alles dauert länger. Unter 10: Zustand *Starving*. |
| **REST** (Schlaf) | 0–100 | Unter 40: du übersiehst Dinge. Unter 20: du siehst Dinge, die nicht da sind. |

**Zwei davon gehören dem Raum**, in dem du gerade stehst:

| Achse | Stufen | Wirkung |
|---|---|---|
| **LIGHT** (Licht) | 0–3 | Bestimmt, wie schnell du suchst und wie schlimm Ereignisse ausfallen |
| **SAFETY** (Sicherheit) | 0–3 | Bestimmt, ob ein Ereignis dich erreicht oder an der Tür hängen bleibt |

Das ist der ganze Kern. Keine Angst-Leiste, keine Bedrohungsstufe, kein Monster-Zähler.
Wenn du dich fragst "warum ist das gerade schwierig?", ist die Antwort immer eine
dieser vier Achsen.

### 2.1 FOOD — Essen

- Sinkt um **4 pro Stunde** Spielzeit → ein Tag kostet etwa 50 Punkte, du brauchst
  ungefähr **eine ordentliche Mahlzeit pro Tag**.
- Nahrung gibt es in zwei Sorten:
  - **Konserven** — halten ewig, geben 30–40. Die Währung des Spiels.
  - **Verderbliches** — Brot, Obst, Eingemachtes. Gibt mehr (bis 50), aber wird nach
    2–3 Tagen schlecht. Schlechtes Essen essen → Zustand *Sick*.
- Fundorte: Küche, Speisekammer, Weinkeller — und Zufallsereignisse.
- **Wasser lasse ich bewusst weg.** Eine zweite Verbrauchsleiste würde nur die
  gleiche Entscheidung doppelt stellen.

### 2.2 REST — Schlaf

Das ist die interessanteste Achse, weil Schlafen dich hilflos macht.

- Sinkt um **5 pro wacher Stunde**. Nach etwa 20 Stunden bist du am Ende.
- Schlafen gibt **+15 pro Stunde**. Im Bett **+20**. Auf dem Boden nur **+8**.
- **Während du schläfst, zieht das Haus Ereignisse** — und du kannst nicht reagieren.
  Wie schlimm sie ausfallen, hängt vollständig an LIGHT und SAFETY des Raums,
  in dem du dich hingelegt hast.
- Unter REST 20 erscheinen **Halluzinations-Ereignisse**: Hotspots, die nicht existieren,
  Hinweise, die falsch sind, Geräusche ohne Ursache. Der Spieler kann nicht mehr
  unterscheiden, was echt ist. Das ist der Horror — nicht ein Gesicht im Fenster.
- Bei REST 0 **brichst du zusammen, wo du gerade stehst.** Vier Stunden Schlaf an
  einem ungesicherten, dunklen Ort. Das ist fast immer die schlechteste Nacht deines Lebens.

→ Die Kernfrage jeder Nacht: *Schlafe ich jetzt, wo es noch sicher ist —
oder suche ich noch zwei Räume ab und riskiere den Zusammenbruch?*

### 2.3 LIGHT — Licht im Raum

| Stufe | Quelle | Kosten | Wirkung |
|---|---|---|---|
| **0** Dark | — | — | Suchen dauert **doppelt** so lange, Ereignisse eine Stufe schlimmer |
| **1** Handheld | Taschenlampe | 1 Batterie / Stunde | Du siehst nur den Kegel, aber es reicht |
| **2** Placed | Kerze, Petroleumlampe | brennt 4 Std. ab | Der ganze Raum ist hell, bleibt auch ohne dich an |
| **3** Electric | Deckenlicht | 1 Sicherung, dauerhaft | Beste Sicht, kostet laufend nichts — aber siehe unten |

**Der Sicherungskasten** (Keller): Das Haus hat Strom, aber nur **drei intakte Sicherungen**.
Du entscheidest, welche drei Räume Licht bekommen, und kannst sie jederzeit umstecken
(kostet 20 Minuten und den Weg in den Keller).

Der Haken: **Elektrisches Licht verändert, was für Ereignisse gezogen werden.**
Nicht "das Monster kommt" — sondern das Haus wird *wach*. Sicherungen brennen durch,
Lampen platzen, in beleuchteten Räumen passieren andere, seltsamere Dinge als in dunklen.
Licht ist nicht einfach besser. Es ist anders.

### 2.4 SAFETY — Sicherheit im Raum

| Stufe | Zustand | Kosten |
|---|---|---|
| **0** Open | Tür offen | — |
| **1** Closed | Tür zu | 1 min |
| **2** Blocked | Möbel davor geschoben | 15 min |
| **3** Barricaded | Bretter vernagelt | 30 min + 2 Bretter + Nägel + Hammer |

- SAFETY entscheidet, ob ein Bedrohungs-Ereignis **dich** trifft oder nur **die Tür**.
  Bei Stufe 3 wird aus "etwas steht in deinem Zimmer" ein "etwas kratzt draußen".
- **Barrikaden halten nicht.** Ereignisse beschädigen sie (Stufe 3 → 2 → 1).
  Reparieren kostet wieder Material. Das ist der Grund, warum du raus musst.
- Material (Bretter, Nägel) findest du in Werkstatt, Dachboden, Keller —
  oder du **zerlegst Möbel**, was laut ist und den Raum dauerhaft verändert.

### 2.5 Dein Lager

Du bekommst keinen sicheren Raum zugewiesen — **du wählst ihn selbst.**
Wo du deine Vorräte hinlegst und schläfst, ist deine wichtigste Entscheidung
im ganzen Spiel, und du kannst sie später bereuen.

| Kandidat | Dafür | Dagegen |
|---|---|---|
| Schlafzimmer | Bett (+20 Schlaf), Schrank zum Verstecken | Weit weg von Küche und Keller |
| Küche | Direkt am Essen, zwei Fluchtwege | Kellertür lässt sich schlecht sichern |
| Bibliothek | Viele Regale = viel Barrikadenmaterial | Kein Bett, kein Wasser |
| Eingangshalle | Zentral, kurze Wege überall hin | Die Haustür ist hier. Und sie ist nicht still. |

Vorräte, die du im Lager stapelst, sind **nicht automatisch sicher** — manche
Ereignisse nehmen dir etwas weg. Alles auf einen Haufen legen ist bequem und riskant.

---

## 3. Die Bedrohung: nur Ereignisse

**Es gibt keine Kreatur mit Wegfindung, keinen Verfolger, keine Bedrohungsanzeige.**
Alles, was dir zustößt, kommt aus dem Ereignis-System. Das Haus ist der Gegner,
und es handelt in Momenten, nicht in Bewegungen.

### 3.1 Wann gezogen wird

- Bei jedem Raumwechsel (30 % Chance)
- Nach jeder Aktion, die über 15 Minuten dauert (20 %)
- **Jede Stunde, in der du schläfst** (60 %)
- Zu festen Uhrzeiten (Mitternacht, 03:00)

### 3.2 Die Kategorien

| Kategorie | Anteil | Was es tut |
|---|---|---|
| **Ambient** | 35 % | Nur Ton und Bild. Folgenlos. Damit das Haus nie still wirkt. |
| **Choice** | 25 % | Eine Entscheidung mit Konsequenzen — der Kern des Spiels, siehe unten |
| **Supply** | 15 % | Du findest etwas. Wird häufiger, wenn du kurz vor dem Verhungern bist. |
| **Damage** | 15 % | Barrikade beschädigt · Sicherung durchgebrannt · Vorräte verdorben · Gegenstand weg |
| **Clue** | 10 % | Ein Stück des Geheimnisses |

### 3.3 Choice-Ereignisse — hier lebt das Spiel

Statt eines Monsters bekommt der Spieler **Situationen ohne gute Antwort.** Beispiel:

> *Something is at the cellar door. Not knocking. Testing.*
>
> **[Go and look]** — 40 % ein Hinweis, 40 % nichts, 20 % Zustand *Injured*
> **[Push the dresser against it]** — 20 min, SAFETY +1, aber der Weg in den Keller ist zu
> **[Ignore it and keep working]** — die Barrikade nimmt Schaden, du verlierst nichts sonst

Weiteres Beispiel:

> *The radio picks something up. A voice reading names. One of them might be yours.*
>
> **[Listen to the end]** — 30 min, garantierter Hinweis, REST −10
> **[Turn it off]** — nichts passiert. Du wirst nie erfahren, was da kam.

Jedes Choice-Ereignis muss diese Regel erfüllen: **keine Option ist eindeutig richtig,
und mindestens eine kostet eine der vier Achsen.**

### 3.4 Schlaf-Ereignisse

Eigene Kategorie, weil du nicht reagieren kannst. Sie werden am Morgen aufgelöst —
du wachst auf und siehst, was passiert ist.

- Die Tür, die du verriegelt hattest, steht offen
- Eine Konserve fehlt
- Jemand hat neben deinem Bett gesessen — der Boden ist dort staubfrei
- Du hast im Schlaf etwas geschrieben. Es ist ein Hinweis. Es ist deine Handschrift.
- Es sind neun Stunden vergangen, nicht sechs

Wie viele und wie schlimm: direkt abhängig von LIGHT und SAFETY deines Schlafplatzes.
In einem dunklen, offenen Raum zu schlafen ist die gefährlichste Handlung im Spiel.

### 3.5 Fairness-Regeln

- Nie zwei Damage-Ereignisse hintereinander
- Sind 90 Minuten ohne Ereignis vergangen → garantiert ein Ambient-Ereignis
- FOOD unter 25 → Supply-Ereignisse werden verdreifacht (das Spiel hilft leise)
- Jedes Ereignis nur einmal pro Tag
- **Die ersten 12 Stunden ziehen nur Ambient und Supply.** Der Spieler soll das Haus
  kennenlernen, bevor es ihn kennenlernt.

---

## 4. Zustände und Tod

Ein schlecht ausgegangenes Ereignis tötet dich **nie direkt**. Es gibt dir einen Zustand.

| Zustand | Wirkung | Behandlung | Wenn unbehandelt |
|---|---|---|---|
| **Injured** | Alle Aktionen +50 % Zeit | Verbandskasten | Nach 12 Std. → *Bleeding* |
| **Sick** | FOOD sinkt doppelt so schnell | Medikamente + 8 Std. Schlaf | Nach 24 Std. → *Fevered* |
| **Shaken** | Du kannst 4 Stunden nicht schlafen | Zeit, warme Mahlzeit | vergeht von selbst |
| **Starving** | REST sinkt doppelt, Aktionen misslingen | Essen | zieht Lebenspunkte |

**Tod tritt nur ein durch:**
1. Einen Zustand der zweiten Stufe (*Bleeding*, *Fevered*), der weitere 12 Stunden unbehandelt bleibt
2. FOOD auf 0 über mehr als 24 Stunden
3. Ganz seltene Ereignisse, bei denen du eine klare Warnung ignoriert hast

Es gibt also immer eine Vorwarnung und immer einen Weg zurück — aber der kostet.

**Tod ist endgültig.** Kein Laden, kein Zurücksetzen des Tages. Der Durchlauf ist vorbei,
du siehst eine Zusammenfassung (wie viele Tage, was du herausgefunden hast, was du
nie erfahren hast) und fängst neu an. Was du behältst, ist dein Wissen über das Haus.

---

## 5. Zeit

- Uhr läuft **aktionsbasiert**, nicht in Echtzeit. Sie tickt nur, wenn du etwas tust.
  Nachdenken ist kostenlos.
- **Tag (08:00–20:00):** Milde Ereignisse, weniger Ziehungen. Zeit zum Erkunden.
- **Nacht (20:00–08:00):** Ereignisse häufiger und eine Stufe schlimmer. Zeit zum Schlafen —
  wenn du dich traust.
- Tage werden gezählt (**Day 1, Day 2, …**), aber es gibt **kein Ziel-Datum.**
  Der Spieler weiß nie, ob noch drei Tage kommen oder dreißig.

**Eskalation ohne Countdown** — alle 3 Tage wird ein neues Ereignis-Deck freigeschaltet:

| Ab | Was sich ändert |
|---|---|
| Tag 1 | Grunddeck. Das Haus ist nur ein leeres Haus. |
| Tag 4 | Damage-Ereignisse aktiv. Vorratsfunde werden seltener. |
| Tag 7 | Das Haus verändert sich: Räume tauschen Verbindungen, ein Raum wird unbetretbar. |
| Tag 10 | Schlaf-Ereignisse werden persönlich — sie beziehen sich auf das, was du getan hast. |
| Tag 13+ | Kein neues Deck. Nur noch weniger Vorräte. Ab hier ist es ein Rennen. |

---

## 6. Das Geheimnis — und der Weg hinaus

Das Ziel ist nicht "durchhalten". Das Ziel ist **rauskommen** — und das geht erst,
wenn du verstanden hast, warum die Tür zu ist.

Ein **Notizbuch** mit vier offenen Fragen:

1. **Who** is still in this house?
2. **What** happened in the room they died in?
3. **What** does it want returned?
4. **Where** does it have to go?

Jede Frage braucht 3 gefundene Fragmente, dann kannst du eine Antwort aus mehreren
Möglichkeiten wählen. Fragmente kommen aus Notizen, Fotos, Radiodurchsagen,
Telefonanrufen, Schlaf-Ereignissen und Gegenständen.

**Der Ausgangsversuch** kann jederzeit unternommen werden, sobald du alle vier Fragen
beantwortet hast — es gibt keine vorgeschriebene Nacht dafür. Du gehst zur Haustür,
mit dem, was deine Antworten vorgeben.

| Ergebnis | Ende |
|---|---|
| 4 von 4 richtig | **The Door** — du gehst hinaus. Bestes Ende. |
| 2–3 richtig | **Morning** — die Tür öffnet sich, aber etwas geht mit dir. |
| 0–1 richtig | Der Versuch schlägt fehl. Du verlierst die verwendeten Gegenstände und einen Tag. |

Der Täter, der Ort und der Gegenstand werden **pro Durchlauf neu gewürfelt** —
du kannst die Lösung nicht auswendig lernen, nur die Methode, sie zu finden.

---

## 7. Die Villa

13 Räume. Jeder ist an mindestens eine der vier Achsen gebunden — kein Raum ist Dekoration.

```
  ATTIC                    [12] Attic
                                │
  UPPER          [8]──[7 Upper Landing]──[9]     [10] Bathroom
              Bedroom      │      │    Nursery      │
                           │      └──[11] Study ────┘
                           │
  GROUND    [3]──[2]──[1 ENTRANCE HALL]──[4]──[5]──[6]
          Library Parlor      ▲ AUSGANG  Dining Kitchen Conservatory
                              │
  CELLAR                [13] Cellar ── [Fuse box]
```

| # | Raum | Achse | Rolle |
|---|---|---|---|
| 1 | Entrance Hall | — | Die Haustür. Der Ausgang. Sie geht nicht auf. |
| 2 | Parlor | SAFETY | Schwere Möbel zum Verbarrikadieren, Radio |
| 3 | Library | Geheimnis | Hauptquelle für Notiz-Fragmente, Bretter aus Regalen |
| 4 | Dining Room | LIGHT | Kerzen, Kerzenleuchter, Silber |
| 5 | Kitchen | FOOD | Speisekammer, Konserven, Herd (warme Mahlzeit) |
| 6 | Conservatory | — | Der einzige Blick nach draußen. Man sollte nicht hinsehen. |
| 7 | Upper Landing | — | Drehscheibe. Ab Tag 7 stimmen die Türen nicht mehr. |
| 8 | Bedroom | REST | Bett (+20/Std.), Schrank, Kleidung |
| 9 | Nursery | Geheimnis | Der emotionale Kern. Und ein sehr gutes Versteck. |
| 10 | Bathroom | Zustände | Medikamente, Verbandskasten, Spiegel |
| 11 | Study | Geheimnis | Telefon, Schreibtisch, Safe mit Zahlenschloss |
| 12 | Attic | SAFETY | Werkzeug, Bretter, Nägel, Koffer |
| 13 | Cellar | LIGHT | **Sicherungskasten.** Eingemachtes. Ganz dunkel. |

**Für einen ersten Prototyp reichen 5:** Entrance Hall, Kitchen, Bedroom, Library, Cellar —
damit sind alle vier Achsen abgedeckt.

### Warum du nicht rausgehst

Die Haustür ist zu und lässt sich nicht öffnen — das ist die harte Grenze.
Die Fenster sind eine weichere: sie sind **nicht** vernagelt. Du könntest eines einschlagen.
Aber der Wintergarten zeigt dir, was draußen steht und wartet, und ab dann versuchst du es nicht mehr.

Ein Fenster einzuschlagen ist im Spiel möglich. Es ist keine Lösung. Es ist ein Ende.

---

## 8. Bedienung und Bildschirm

```
┌──────────────────────────────────────────────────────────┐
│ DAY 3  ·  02:40      FOOD ▓▓▓▓░░░░    REST ▓▓░░░░░░      │
│ KITCHEN         light ●●○   safety ●●●        [Injured]  │
├──────────────────────────────────────────────────────────┤
│                                                          │
│                  RAUMBILD (Standbild)                    │
│         Hotspots leuchten schwach beim Hovern            │
│                                                          │
├──────────────────────────────────────────────────────────┤
│ [🔦][🥫][🔨][🪵][ ][ ]        [Notebook] [Map] [Sleep]   │
└──────────────────────────────────────────────────────────┘
```

- **Linksklick auf Hotspot** → Aktionsmenü. Die Kosten stehen **immer vorher** dran:
  `Search the pantry — 10 min` · `Pry open the crate — 20 min, needs crowbar`
- **Rechtsklick** → ansehen, kostenlos, gibt Atmosphäre-Text
- **Tab** Notebook · **M** Map · **F** Taschenlampe · **S** Schlafen (öffnet Schlaf-Dialog
  mit Anzeige, wie sicher der Raum gerade ist — der Spieler soll wissen, was er riskiert)
- Traglimit **6 Slots**. Der Rest liegt in deinem Lager.

---

## 9. Technische Struktur (Godot 4, GDScript)

Datengetrieben: Räume, Gegenstände, Ereignisse und Hinweise sind `Resource`-Dateien (`.tres`).
Inhalte kann man im Editor anlegen, ohne Code anzufassen.

```
res://
├── src/
│   ├── autoload/
│   │   ├── game_state.gd     # Tag, Uhr, FOOD, REST, Zustände, Flags
│   │   ├── clock.gd          # Zeit vorspulen, Tag/Nacht-Signale
│   │   ├── event_deck.gd     # Gewichtetes Ziehen, Fairness-Regeln
│   │   ├── rooms.gd          # LIGHT/SAFETY je Raum, Barrikaden-Zustand
│   │   ├── power.gd          # Sicherungskasten, 3 Sicherungen
│   │   ├── inventory.gd      # 6 Slots + Lagerbestand
│   │   ├── notebook.gd       # Fragmente, Fragen, Antworten, Enden
│   │   └── save_system.gd    # Ein Speicherstand, wird bei Tod gelöscht
│   ├── data/                 # Resource-Schemas
│   ├── scenes/               # main · room_view · hotspot · sleep · event_popup
│   └── ui/                   # hud · inventory · notebook · map · action_menu
├── content/                  # rooms/ items/ events/ clues/ als .tres
├── assets/                   # siehe ASSET_PLAN.md
└── audio/
```

- Auflösung **640 × 360**, Stretch `viewport`, Aspect `keep` → saubere Pixel in jeder Größe
- Textur-Import: Filter **Nearest**
- Licht per `CanvasModulate` + `PointLight2D` → **ein Bild pro Raum reicht**,
  die vier LIGHT-Stufen entstehen im Shader
- **Ein einziger Speicherstand**, automatisch, wird bei Tod gelöscht (Permadeath)

---

## 10. Roadmap

| Meilenstein | Inhalt |
|---|---|
| **M0** | Godot-Projekt, Ordner, Platzhalter, ein Raum ist sichtbar |
| **M1** | Bewegung zwischen 5 Räumen, Hotspots, Uhr, Aktionen mit Zeitkosten |
| **M2** | FOOD und REST, Essen, Schlafen, Zustände |
| **M3** | LIGHT und SAFETY: Taschenlampe, Kerzen, Sicherungskasten, Barrikaden |
| **M4** | Ereignis-System mit allen fünf Kategorien, ~40 Ereignisse |
| **M5** | Notizbuch, Fragmente, die vier Fragen, die Enden |
| **M6** | Alle 13 Räume, ~100 Ereignisse, Eskalationsdecks |
| **M7** | Deine Sprites rein, Ton, Balancing |

---

## 11. Offene Punkte

1. **Titel** — "Ashgrove" ist ein Platzhalter.
2. **Wovor bist du weggelaufen?** Mein Vorschlag: es wird nie beantwortet.
   Das Ding draußen und das Ding im Haus bleiben getrennt und beide ungeklärt.
3. **Umfang von Version 1** — noch offen, du wolltest das später entscheiden.
4. **Balancing-Zahlen** — alle Werte oben sind erste Schätzungen zum Draufhauen.
