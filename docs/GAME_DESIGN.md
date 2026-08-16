# ASHGROVE — Game Design Dokument

> Arbeitstitel. 2D-Horror-Survival, Godot 4, ein festes Bild pro Raum, Point & Click.
> **Version 0.6** — Ereignisse werden mit Gegenständen gelöst, nicht mit Entscheidungen.
> Spieltexte Englisch, Setting Anfang der 1960er.

---

## 1. Der Pitch

Du bist nachts vor *etwas* weggelaufen und in das erstbeste Haus geflüchtet.
Die Tür ist hinter dir zugefallen. Sie geht nicht mehr auf.

**Du hast sechs Handlungen am Tag.** Nicht mehr. Sechsmal etwas tun, dann wird es
dunkel und du musst schlafen — und im Schlaf passiert alles.

**Kernfantasie:** *"Ich habe noch zwei Handlungen. Ich könnte den Keller absuchen,
oder die Schlafzimmertür zunageln. Beides geht nicht, und heute Nacht zahle ich für
das, was ich nicht getan habe."*

Der nächste Verwandte im Regal ist **This War of Mine** — nur dass der Krieg draußen
durch ein Haus ersetzt ist, das nicht will, dass du gehst.

### Wer du bist

**Niemand.** Kein Name, kein Alter, kein Geschlecht, keine Vorgeschichte, kein Beruf.
Die Figur wird nie beschrieben und nie gezeigt — auch nicht in Spiegeln.

Harte Regel für alle Texte: **kein Ereignis darf etwas über die Figur behaupten.**
Keine Kindheit, keine Familie, kein "du hattest schon immer Angst vor…". Wenn ein
Ereignis etwas Persönliches braucht, bezieht es sich auf **das, was der Spieler getan hat** —
welchen Raum er zum Lager gemacht hat, was er aufgebrochen hat, wen er nicht gerufen hat.

---

## 2. Der Tagesablauf

Es gibt **keine Uhr und keine Minuten.** Ein Tag besteht aus einer festen Zahl Handlungen.

```
  ┌── MORGEN ──────────────────────────────────────────────┐
  │  NIGHT REPORT: was in der Nacht passiert ist           │
  │  ENERGY wird gesetzt (aus dem Schlaf berechnet)        │
  └───────────────────────────┬────────────────────────────┘
                              ▼
  ┌── TAG ─────────────────────────────────────────────────┐
  │  Du gibst deine Handlungen aus.                        │
  │  Laufen, ansehen, lesen, Notizbuch: kostenlos.         │
  │  Suchen, bauen, kochen, pflanzen: kostet.              │
  │  Fast nichts passiert. Das ist Absicht.                │
  └───────────────────────────┬────────────────────────────┘
                              ▼
  ┌── ABEND (kostenlos) ───────────────────────────────────┐
  │  Essen · Schlafplatz wählen · Schlaflänge wählen       │
  └───────────────────────────┬────────────────────────────┘
                              ▼
  ┌── NACHT ───────────────────────────────────────────────┐
  │  Pro Schlaf-Segment eine Ziehung aus dem Nacht-Deck.   │
  │  Hier passieren 90 % aller Ereignisse.                 │
  └────────────────────────────────────────────────────────┘
```

Ein Tag dauert am Bildschirm **zwei bis vier Minuten**. Ein ganzer Durchlauf
**60 bis 80 Minuten**.

---

## 3. Die vier Achsen

Mehr Systeme gibt es nicht.

| Achse | Was es ist | Anzeige |
|---|---|---|
| **ENERGY** | Wie viele Handlungen du heute hast | Punkte oben, z. B. ●●●●○○ |
| **FOOD** | Wie satt du bist | Leiste 0–100 |
| **LIGHT** | Wie hell der Raum ist, in dem du stehst | 0–3 |
| **SAFETY** | Wie gesichert der Raum ist, in dem du stehst | 0–3 |

**Es gibt bewusst keine REST-Leiste mehr.** Schlaf ist keine Anzeige, sondern die
Handlung, die deine ENERGY für morgen bestimmt. Das ist ein System weniger und macht
die Verbindung direkter: schlecht geschlafen heißt morgen weniger tun können.

### 3.1 ENERGY — dein Tagesbudget

Wird jeden Morgen neu berechnet. Basis ist, wie lange du geschlafen hast:

| Geschlafene Segmente | Basis-ENERGY |
|---|---|
| 1 (kurz) | 2 |
| 2 (normal) | 4 |
| 3 (volle Nacht) | 6 |

Dazu Modifikatoren:

| | ENERGY |
|---|---|
| In einem Bett geschlafen | **+1** |
| Warme Mahlzeit am Vorabend | **+1** |
| FOOD unter 30 | **−1** |
| FOOD unter 10 | **−2** |
| Zustand *Injured* | **−1** |
| Zustand *Sick* | **−1** |
| Zustand *Bleeding* oder *Fevered* | **−2** |
| Zustand *Exhausted* | **−2** |

**Maximum 8, Minimum 1.** Selbst am schlimmsten Morgen bekommst du eine Handlung —
das Spiel sperrt sich nie zu.

Ein guter Tag: volle Nacht im Bett, satt, warme Mahlzeit → **8 Handlungen.**
Ein schlechter: kurz geschlafen, hungrig, verletzt → **1 Handlung.**

### 3.2 Was eine Handlung kostet

| Kostenlos | 1 Handlung | 2 Handlungen |
|---|---|---|
| Zwischen Räumen laufen | Möbelstück durchsuchen | Barrikade bauen (SAFETY 3) |
| Etwas ansehen, Text lesen | Tür mit Brecheisen öffnen | Möbel zerlegen (2–3 Bretter) |
| Notizbuch und Karte | Radio hören | Schloss ohne Werkzeug knacken |
| Essen | Am Herd kochen | Safe knacken |
| Kerze aufstellen *(kostet Kerze + Streichholz)* | Beete gießen (alle auf einmal) | |
| Zustand behandeln *(kostet Material)* | Beet bepflanzen · ernten | |
| Taschenlampe an/aus | Falle bauen · aufstellen | |
| Fallen leeren | Sicherung umstecken | |
| Schlafplatz wählen | Möbel vor die Tür schieben (SAFETY 2) | |

**Laufen ist kostenlos.** Sonst wird jeder Weg zur Buchhaltung. Was Zeit kostet, ist
das Tun, nicht das Gehen.

### 3.3 FOOD — Essen

| Posten | Wert |
|---|---|
| Grundverbrauch pro Tag | **−8** |
| Pro ausgegebener Handlung | **−2** |
| Ein normaler Tag (6 Handlungen) | **−20** |

→ **Etwa eine Konserve alle anderthalb Tage.** Ein aktiver Tag mit 8 Handlungen
kostet 24 statt 20 — viel arbeiten macht hungrig, und das ist die Bremse gegen
Vielspielen.

> Diese Werte lagen zuerst bei −10 und −3. Der Smoke-Test in `tools/` hat gezeigt,
> dass ein Durchlauf damit unmöglich ist: das Haus gibt nicht genug her, jeder
> Testlauf verhungerte um Tag 8. Die Zahlen stammen also aus Messung, nicht aus Gefühl.

| Bei FOOD | passiert |
|---|---|
| unter 30 | ENERGY −1 |
| unter 10 | ENERGY −2, Zustand *Starving* |
| 0 für zwei Tage | Tod |

#### Das Haus füllt sich wieder auf

Es gibt 33 durchsuchbare Möbelstücke. Bei sechs Handlungen am Tag ist das ganze
Haus nach **fünf Tagen leer** — und der Durchlauf geht zwanzig. Deshalb:

**Ein durchsuchtes Möbelstück ist nach vier Tagen wieder durchsuchbar**, mit
halber Ausbeute. Das Spiel sagt es dir, wenn es passiert:
*"You emptied this one days ago. There is something in it again."*

Das ist keine Bequemlichkeit, sondern die Voraussetzung dafür, dass zwanzig Tage
überhaupt funktionieren. Und erzählerisch ist es das unheimlichste Element im Spiel,
weil es nie erklärt wird: jemand räumt auf.

**Im Haus liegen etwa 350 FOOD-Punkte in der ersten Runde.**
Der Weg über das Geheimnis (Tag 10–14) geht damit knapp auf. Der Weg über die
Rettung (Tag 20) braucht **560** — also eigene Produktion, siehe 3.6.

### 3.4 LIGHT — Licht im Raum

| Stufe | Quelle | Kosten | Wirkung |
|---|---|---|---|
| **0** Dark | — | — | Suchen findet nur die Hälfte, Nachtereignisse eine Stufe schlimmer |
| **1** Handheld | Taschenlampe | 1 Batterie pro Tag | Reicht zum Arbeiten |
| **2** Placed | Kerze, Petroleumlampe | Kerze hält 2 Tage | Ganzer Raum hell, bleibt auch ohne dich an |
| **3** Electric | Deckenlicht | 1 Sicherung, dauerhaft | Beste Sicht, kostet laufend nichts |

**Der Sicherungskasten** im Keller hat **drei** Sicherungen für dreizehn Räume.
Umstecken kostet eine Handlung und den Weg. Elektrisches Licht kostet laufend nichts —
aber es verändert, welche Ereignisse gezogen werden. Das Haus wird wach.
Licht ist nicht besser, es ist anders.

### 3.5 SAFETY — Sicherheit im Raum

| Stufe | Zustand | Kosten |
|---|---|---|
| **0** Open | Tür offen | — |
| **1** Closed | Tür zu | kostenlos |
| **2** Blocked | Möbel davor | 1 Handlung |
| **3** Barricaded | Bretter vernagelt | 2 Handlungen + 2 Bretter + 4 Nägel + Hammer |

Barrikaden halten nicht: Nachtereignisse setzen sie 3 → 2 → 1 herunter. Reparieren
kostet wieder Material und Handlungen. **Das ist der Grund, warum du jeden Tag raus musst.**

### 3.6 Nahrung selbst erzeugen

Für den Rettungsweg unverzichtbar, für den Geheimnisweg ein Puffer.

**Wintergarten — zwei Beete.**

| Handlung | Kosten | |
|---|---|---|
| Beet bepflanzen | 1 Handlung + 1 × `seeds` | |
| Gießen (alle Beete zusammen) | 1 Handlung | alle 2 Tage nötig |
| Ernten | 1 Handlung | ergibt ~100 FOOD-Punkte |

Reifezeit **5 Tage**, unter elektrischem Licht **4 Tage** — eine deiner drei Sicherungen
kann also Nahrung beschleunigen statt einen Raum auszuleuchten. Jede Ernte gibt mit
50 % Chance Saatgut zurück. Zwei Tage ohne Gießen und die Pflanzung stirbt.

**Fallen.** Brett + Draht, 1 Handlung zum Bauen. Alle 2 Tage **+25 FOOD**.
Roh gegessen 20 % *Sick*, am Herd gegart sicher. Maximal 3 Fallen.

Wer an Tag 2 pflanzt, erntet ab Tag 7 und hat den Rettungsweg offen.
Wer erst an Tag 10 anfängt, schafft Tag 20 nicht mehr — und merkt es erst an Tag 15.

---

## 4. Die Nacht

**90 % aller Ereignisse passieren im Schlaf.** Tagsüber ist es fast still —
nicht weil nichts da ist, sondern damit die Stille unangenehm wird.

### 4.1 Ablauf

1. Du wählst **Raum** und **Länge** (1, 2 oder 3 Segmente).
2. Ein Dialog zeigt die Einschätzung **in Worten, nicht als Zahl**:
   *"Dark. Open. You should not sleep here."* / *"Boarded up, a candle burning.
   This is as good as it gets."*
3. Pro Segment **eine Ziehung**. Zwei Verläufe:
   - **Durchgeschlafen** → du siehst die Folgen erst im Night Report
   - **Aufgewacht** → Choice-Ereignis mitten in der Nacht. Danach:
     weiterschlafen (**das Segment zählt nicht für ENERGY**) oder aufstehen.
4. Morgens der **Night Report**: eine Seite, was passiert ist.

### 4.2 Ziehungswahrscheinlichkeit

Grundwert **45 % pro Segment**. Abzüge:

| | |
|---|---|
| SAFETY 3 (vernagelt) | −20 |
| SAFETY 2 (Möbel davor) | −10 |
| LIGHT ≥ 2 (Kerze brennt) | −10 |
| Stolperschnur **im Rucksack** | wandelt Diebstahl in ein lösbares Problem |

Bester Schlafplatz: **15 % pro Segment.** Schlechtester (dunkel, offen): **55 %.**
Vollständige Sicherheit gibt es nie, und sie kostet jeden Tag neu Material und Handlungen.

### 4.3 Kategorien im Nacht-Deck

| Kategorie | Anteil | Lösbar? | Was es tut |
|---|---|---|---|
| **Problem** | 40 % | **ja, mit Gegenstand** | Der Kern des Spiels |
| **Sound** | 25 % | nein | Nur ein Geräusch, ENERGY −1 |
| **Damage** | 10 % | nein | Barrikade beschädigt, Vorräte verdorben |
| **Theft** | 10 % | nur Stolperschnur | Etwas ist weg |
| **Clue** | 10 % | nein | Ein Traum, deine eigene Handschrift |
| **Move** | 5 % | nein | Du wachst in einem anderen Raum auf |

### Ereignisse werden mit Gegenständen gelöst

**Das Spiel fragt nie, was du tun willst. Es fragt, was du dabei hast.**

```
   Etwas arbeitet an den Brettern deiner Tür.

   [Brett + Hammer]   →  Du nagelst nach. Nichts geht kaputt.
   [Brecheisen]       →  Du verkeilst es. Hält bis zum Morgen.
   Nichts davon dabei →  Die Barrikade verliert zwei Stufen.
```

Es gibt **keine Auswahl zwischen Verhaltensweisen** — kein "nachsehen / ignorieren /
zurückrufen". Die Entscheidung ist längst gefallen: am Abend, beim Packen.

**Und nachts zählt nur, was du am Körper trägst.** Der Vorratsstapel drei Räume weiter
nützt um drei Uhr morgens nichts. Damit werden die **sechs Inventarplätze zur eigentlichen
Frage des Spiels**: Hammer und Bretter? Kerzen? Verbände? Alles passt nicht.

Umpacken zwischen Lager und Rucksack kostet keine Handlung — die Entscheidung soll
nichts kosten außer Nachdenken.

**Warum das besser ist als Multiple Choice:** Eine Frage ohne erkennbar richtige Antwort
ist Glücksspiel mit Extraschritten. "Habe ich einen Hammer dabei?" ist eine echte Frage,
auf die man sich vorbereiten kann — und beim zweiten Durchlauf packt man anders, weil
man das Haus verstanden hat, nicht weil man die Antwort auswendig kennt.

Drei Kategorien sind bewusst **nicht** lösbar (Damage, Theft, Move). Sonst hätte alles
eine Antwort, und das Haus wäre nur noch eine Packliste.

### 4.4 Fairness

- **Die erste Nacht ist immer ruhig.**
- Nie zwei Damage-Ereignisse in derselben Nacht, höchstens ein Mark
- FOOD unter 25 → Fundereignisse verdreifacht (das Spiel hilft leise)
- Jedes Ereignis nur einmal pro Tag
- Nach einer sehr schlechten Nacht ist die nächste garantiert milder

Alle Ereignisse im Detail: **[`EVENTS.md`](EVENTS.md)**

---

## 5. Zustände und Tod

Ein schlecht ausgegangenes Ereignis tötet **nie direkt**. Es gibt dir einen Zustand.

| Zustand | Wirkung | Behandlung | Unbehandelt |
|---|---|---|---|
| **Injured** | ENERGY −1 | First aid tin | Nach 2 Tagen → *Bleeding* |
| **Sick** | ENERGY −1, FOOD-Verbrauch ×1,5 | Pills + eine volle Nacht | Nach 3 Tagen → *Fevered* |
| **Shaken** | Nächste Nacht nur 1 Segment möglich | Whiskey oder warme Mahlzeit | vergeht nach 2 Tagen |
| **Exhausted** | ENERGY −2, Halluzinationen | Eine volle Nacht (3 Segmente) | bleibt |
| **Starving** | ENERGY −2 | Essen | zieht Richtung Tod |
| **Bleeding** | ENERGY −2 | First aid tin | **Nach 2 Tagen Tod** |
| **Fevered** | ENERGY −2 | Pills + volle Nacht | **Nach 2 Tagen Tod** |

**Exhausted** ersetzt die alte REST-Leiste: zwei Nächte hintereinander nur ein Segment
geschlafen, und du bekommst ihn. Dann erscheinen Hotspots, die nicht existieren, und
Hinweise, die falsch sind. Der Spieler kann nicht mehr unterscheiden, was echt ist.

### Tod

Nur durch: einen Zustand zweiter Stufe (*Bleeding*, *Fevered*), der zwei weitere Tage
unbehandelt bleibt — oder FOOD 0 über zwei Tage.

**Tod ist endgültig. Es wird nicht gespeichert.** Kein Autosave, kein Speicherpunkt,
kein Laden. Der Durchlauf ist vorbei, du siehst eine Zusammenfassung und fängst neu an.

Damit das trägt, zwei Regeln:

1. **Kein Tod ohne zwei Tage sichtbare Vorwarnung.** Zustände eskalieren sichtbar,
   das Spiel sagt dir deutlich, dass du gerade stirbst.
2. Ein Durchlauf dauert **60–80 Minuten**. Bei dieser Länge ist Permadeath zumutbar —
   genau deshalb ist die Energiegrenze so wichtig.

---

## 6. Zwei Wege hinaus

### Weg 1 — THE DOOR: verstehen (der Normalweg)

Die Haustür geht auf, wenn du herausgefunden hast, was das Haus verlangt.

Ein **Notizbuch** mit vier Fragen — sie fragen nach **Regeln**, nie nach Identität:

1. **What does it take from you?**
2. **Which room is the wrong one?**
3. **What has to go back?**
4. **Where does it have to go?**

Jede Frage braucht **3 Fragmente**, dann wählst du eine Antwort aus mehreren.
**Frühestens Tag 8** — vorher sind nicht alle zwölf erreichbar, weil drei in Räumen
liegen, die sich erst ab Tag 7 öffnen. Ein guter Durchlauf endet **Tag 10–14.**

| Ergebnis | Was passiert |
|---|---|
| 4 von 4 richtig | **THE DOOR** — die Tür geht auf, du gehst hinaus |
| 2–3 richtig | **THE THRESHOLD** — sie geht auf, aber schließt sich nicht hinter dir |
| 0–1 richtig | Fehlschlag: die verwendeten Gegenstände sind weg, ein Tag verloren |

Die richtige Kombination wird **pro Durchlauf neu gewürfelt.**

### Weg 2 — RESCUE: bis Tag 20 durchhalten

Hilfe kommt an **Tag 20**, fest. Der Spieler erfährt das Datum nie direkt — das
**Radio im Salon** tastet sich über die Tage heran.

Das ist der **Ausdauerweg und ausdrücklich der schwerere**: zwanzig Nächte, und die
Hausvorräte reichen für zwölf. Ohne Anbau nicht zu schaffen.

### Weg 3 — THE WINDOW

Ein Fenster einzuschlagen ist **ab Tag 1 möglich**. Es funktioniert sogar. Der
Wintergarten zeigt dir vorher, warum das keine gute Idee ist. Eigenes Ende, eigene
Schlusskarte — und immer da, als leise Versuchung nach einer schlechten Nacht.

### Was du nie erfährst

**Es wird nicht aufgelöst**, in keinem Ende. Du erfährst, *was* das Haus verlangt,
nie *warum*. Die Fragmente passen nicht restlos zusammen: zwei Notizen widersprechen
sich, ein Datum ergibt keinen Sinn, auf einem Foto ist eine Person zu viel.
Das ist Absicht und wird nicht repariert.

Auch das, wovor du weggelaufen bist, bleibt ungeklärt.

---

## 7. Die zwanzig Tage

| Phase | Tage | Charakter |
|---|---|---|
| **Ankommen** | 1–4 | Das Haus ist nur ein leeres Haus. Erste Barrikade, erste ruhige Nacht. |
| **Aufbau** | 5–9 | Damage und Theft aktiv. Hausvorräte gehen zur Neige. |
| **Die Wende** | 10–14 | Das Geheimnis ist lösbar. Räume tauschen Verbindungen. |
| **Endspiel** | 15–20 | Nur noch eigene Nahrung. Das Radio kündigt die Suche an. |

| Ab Tag | Was neu dazukommt |
|---|---|
| 1 | Grunddeck. Die erste Nacht ist immer ruhig. |
| 3 | Damage- und Theft-Ereignisse |
| 5 | Move-Ereignisse. Funde werden seltener. |
| 7 | Dachboden und Kinderzimmer öffnen sich. Räume tauschen Verbindungen. |
| 8 | **Ab hier ist das Geheimnis lösbar** |
| 12 | Ereignisse werden persönlich: sie beziehen sich auf das, was du getan hast |
| 16 | Ein Raum wird unbetretbar. Der Sicherungskasten wird unzuverlässig. |
| 20 | **Die Rettung.** |

---

## 8. Die Villa

13 Räume, vier Ebenen. Jeder ist an eine Achse gebunden — kein Raum ist Dekoration.

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

| # | Raum | Achse | Rolle | Ab Tag |
|---|---|---|---|---|
| 1 | Entrance Hall | — | Die Haustür. Der Ausgang. Sie geht nicht auf. | 1 |
| 2 | Parlor | SAFETY | Schwere Möbel, **Radio** | 1 |
| 3 | Library | Geheimnis | Notiz-Fragmente, Regalbretter | 1 |
| 4 | Dining Room | LIGHT | Kerzen, Leuchter, Silber | 1 |
| 5 | Kitchen | FOOD | Speisekammer, **Herd**, Kellerzugang | 1 |
| 6 | Conservatory | FOOD | **Beete, Regentonne.** Blick nach draußen. | 1 |
| 7 | Upper Landing | — | Drehscheibe. Ab Tag 7 stimmen die Türen nicht mehr. | 1 |
| 8 | Bedroom | ENERGY | **Bett** (+1 ENERGY), Schrank | 1 |
| 9 | Nursery | Geheimnis | Emotionaler Kern. Sehr gutes Versteck. | 7 |
| 10 | Bathroom | Zustände | Medikamente, Verbandskasten, Spiegel | 1 |
| 11 | Study | Geheimnis | **Telefon**, Safe mit Zahlenschloss | 1 |
| 12 | Attic | SAFETY | Werkzeug, Bretter, Nägel, Draht | 7 |
| 13 | Cellar | LIGHT | **Sicherungskasten.** Eingemachtes. Ganz dunkel. | 1 |

**Prototyp:** Entrance Hall, Kitchen, Bedroom, Library, Cellar — deckt alle vier Achsen ab.

**Türen aufbrechen** geht mit dem Brecheisen (1 Handlung), beschädigt die Tür aber
dauerhaft: dieser Raum kommt **nie über SAFETY 1** hinaus. Der schnelle Weg heute
kostet dich jede weitere Nacht.

---

## 9. Bildschirm

```
┌──────────────────────────────────────────────────────────┐
│ DAY 6      ENERGY ●●●●○○      FOOD ▓▓▓▓▓░░░   [Injured]  │
│ KITCHEN                   light ●●○   safety ●●●         │
├──────────────────────────────────────────────────────────┤
│                                                          │
│                  RAUMBILD (ein festes Bild)              │
│         Hotspots leuchten schwach beim Hovern            │
│                                                          │
├──────────────────────────────────────────────────────────┤
│ [🔦][🥫][🔨][🪵][ ][ ]      [Notebook] [Map] [Sleep]     │
└──────────────────────────────────────────────────────────┘
```

- **Linksklick Hotspot** → Aktionsmenü, Kosten stehen **immer vorher** dran:
  `Search the pantry — 1 action` · `Board up the door — 2 actions, 2 boards, 4 nails`
- **Rechtsklick** → ansehen, kostenlos, Atmosphäre-Text
- **Tab** Notebook · **M** Map · **F** Taschenlampe · **S** Schlafen
- Traglimit **6 Slots**, der Rest liegt im Lager

---

## 10. Technik (Godot 4, GDScript)

Datengetrieben: Räume, Gegenstände, Ereignisse und Hinweise sind `.tres`-Dateien.
Inhalte lassen sich im Editor anlegen, ohne Code anzufassen.

```
res://
├── src/
│   ├── autoload/
│   │   ├── game_state.gd    # Tag, ENERGY, FOOD, Zustände, Flags
│   │   ├── day_cycle.gd     # Morgen / Tag / Abend / Nacht
│   │   ├── event_deck.gd    # Gewichtetes Ziehen, Fairness-Regeln
│   │   ├── rooms.gd         # LIGHT/SAFETY je Raum, Barrikaden
│   │   ├── power.gd         # Sicherungskasten, 3 Sicherungen
│   │   ├── garden.gd        # Beete, Reife, Gießen
│   │   ├── inventory.gd     # 6 Slots + Lager
│   │   └── notebook.gd      # Fragmente, vier Fragen, Enden
│   ├── data/                # Resource-Schemas
│   ├── scenes/              # main · room_view · hotspot · sleep · night_report
│   └── ui/                  # hud · inventory · notebook · map · action_menu
├── content/                 # rooms/ items/ events/ clues/ als .tres
├── assets/                  # siehe ASSET_PLAN.md
└── audio/
```

- Auflösung **640 × 360**, Stretch `viewport`, Aspect `keep`
- Textur-Import: Filter **Nearest**
- Licht per `CanvasModulate` + `PointLight2D` → **ein Bild pro Raum reicht**
- **Keine Speicherfunktion.** Permadeath ist der Modus, nicht eine Option.

---

## 11. Roadmap

| Meilenstein | Inhalt |
|---|---|
| **M0** | Godot-Projekt, Ordner, Platzhalter, ein Raum ist sichtbar |
| **M1** | 5 Räume, Hotspots, ENERGY, Tagesablauf mit Morgen/Tag/Abend/Nacht |
| **M2** | FOOD, Essen, Schlaf mit Segmenten, Night Report, Zustände |
| **M3** | LIGHT und SAFETY: Taschenlampe, Kerzen, Sicherungskasten, Barrikaden |
| **M4** | Ereignis-Deck mit allen sieben Kategorien, 45 Ereignisse |
| **M5** | Notizbuch, Fragmente, vier Fragen, Enden |
| **M6** | Alle 13 Räume, Anbau, Fallen, Radio-Staffel |
| **M7** | Deine Sprites, Ton, Balancing |

---

## 12. Weiterführende Dokumente

| Datei | Inhalt |
|---|---|
| [`DECISIONS.md`](DECISIONS.md) | Alle Festlegungen in einer Tabelle |
| [`EVENTS.md`](EVENTS.md) | Jedes Ereignis vollständig ausgeschrieben |
| [`ITEMS.md`](ITEMS.md) | Alle Gegenstände mit Werten und Fundorten |
| [`ASSET_PLAN.md`](ASSET_PLAN.md) | Grafik- und Tonliste mit Größen und Dateinamen |
