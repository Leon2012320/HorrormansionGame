# Gegenstände — ASHGROVE

**Version 0.5** — alle Werte im Energie-System, Mengen für einen 20-Tage-Durchlauf.
Namen im Spiel sind englisch, Erklärungen deutsch. Jede Zeile wird eine `.tres`-Datei
unter `content/items/`.

**Traglimit: 6 Slots.** Alles andere liegt in deinem Lager.
Stapelbare Dinge belegen einen Slot bis zur Stapelgröße.

---

## Die Rechnung dahinter

| Posten | Wert |
|---|---|
| FOOD-Grundverbrauch pro Tag | **−10** |
| FOOD pro ausgegebener Handlung | **−3** |
| Normaler Tag (6 Handlungen) | **−28** |
| Aktiver Tag (8 Handlungen) | **−34** |
| Schlechter Tag (2 Handlungen) | **−16** |

→ **Etwa eine Konserve pro Tag.** Viel arbeiten macht hungrig — das ist die eingebaute
Bremse dagegen, jeden Tag alles zu tun.

| | Bedarf | Hausvorräte decken |
|---|---|---|
| Weg über das Geheimnis (Tag 10–14) | ~340 Punkte | **fast genau** |
| Weg über die Rettung (Tag 20) | ~560 Punkte | **62 %** |

**Im Haus liegen etwa 350 FOOD-Punkte.** Wer das Geheimnis löst, kommt ohne Anbau
durch — knapp. Wer auf die Rettung wartet, braucht eigene Produktion (Abschnitt 3).

---

## 1. Essen · `food`

| ID | Name im Spiel | FOOD | Besonderheit | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|---|
| `can_beans` | Tin of beans | +35 | hält ewig | Kitchen, Cellar | 3–5 | 4 |
| `can_meat` | Tin of meat | +40 | hält ewig | Kitchen, Cellar | 2–3 | 4 |
| `can_soup` | Tin of soup | +30 | am Herd aufgewärmt +45 | Kitchen | 2–4 | 4 |
| `preserves` | Jar of preserves | +30 | Glas zerbricht bei N-D-03 | Cellar | 3–5 | 3 |
| `bread` | Stale bread | +25 | **verdirbt nach 2 Tagen** | Kitchen | 1–2 | 2 |
| `apples` | Withered apples | +20 | verdirbt nach 3 Tagen | Kitchen, Conservatory | 1–2 | 3 |
| `chocolate` | Bar of chocolate | +15 | zusätzlich **ENERGY +1** am selben Tag | überall selten | 0–2 | 3 |
| `meal_hot` | Hot meal | +55 | **nur am Herd**, nicht lagerbar, sofort essen | selbst gekocht | — | 1 |
| `water_bottle` | Bottle of water | +10 | Kleinigkeit, kein eigenes System | überall | 2–4 | 3 |
| `food_spoiled` | Spoiled food | +10 | **60 % Zustand *Sick*** | entsteht von selbst | — | 3 |

**Der Herd** ist die wichtigste Nahrungsquelle: 1 Handlung verwandelt eine Konserve
(+35) in eine warme Mahlzeit (+55) und gibt **ENERGY +1 am nächsten Morgen**.
Er braucht **Strom** — also eine deiner drei Sicherungen. Eine Sicherung in der Küche
leuchtet kein Schlafzimmer aus. Das ist eine der besten Entscheidungen im Spiel.

---

## 2. Licht · `light`

| ID | Name im Spiel | Wirkung | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|
| `flashlight` | Flashlight | LIGHT 1, solange getragen · **1 Batterie pro Tag** | Entrance Hall (Start) | 1 | 1 |
| `battery` | Battery | Ein Tag Taschenlampe | überall | 6–10 | 6 |
| `candle` | Candle | LIGHT 2 im Raum, **hält 2 Tage** | Dining, Cellar, Parlor | 6–10 | 5 |
| `matches` | Box of matches | Zum Anzünden, 1 pro Vorgang | Kitchen, Parlor | 2–3 Schachteln à 8 | 3 |
| `lantern` | Oil lantern | LIGHT 2, **hält 4 Tage**, wiederbefüllbar | Cellar, Attic | 0–1 | 1 |
| `lamp_oil` | Can of lamp oil | Füllt die Laterne wieder auf | Cellar, Attic | 1–2 | 2 |
| `fuse` | Fuse | Ein Raum bekommt dauerhaft LIGHT 3 | Cellar (3 stecken), Attic, Study | 3 + 2–3 Ersatz | 5 |
| `bulb` | Light bulb | Ersatzbirne — ohne sie nützt die Sicherung nichts | überall | 2–4 | 4 |

**Zur Knappheit:** 6–10 Batterien für 20 Tage heißt, die Taschenlampe ist für
Notfälle und kurze Wege, nicht zum Erkunden. Kerzen reichen für 12–20 Tage,
wenn man sie sparsam setzt. **Ab dem Mittelspiel ist elektrisches Licht die einzige
tragfähige Quelle — und davon gibt es drei Räume.**

---

## 3. Nahrungsproduktion · `farm`

Für den Rettungsweg unverzichtbar, für den Geheimnisweg ein Puffer.

### 3.1 Der Wintergarten — zwei Beete

| ID | Name im Spiel | Wirkung | Fundort | Anzahl |
|---|---|---|---|---|
| `seeds` | Packet of seeds | Bepflanzt ein Beet | Conservatory, Cellar, Attic | 2–4 |
| `watering_can` | Watering can | Nötig zum Gießen | Conservatory | 1 |
| `rain_barrel` | *(fest im Raum)* | Füllt sich bei Regen, fasst 6 Füllungen | — | 1 |
| `crop_ripe` | Ripe crop | Ernte: **~100 FOOD-Punkte** | — | — |

| Handlung | Kosten | |
|---|---|---|
| Beet bepflanzen | 1 Handlung + 1 × `seeds` | |
| Gießen | 1 Handlung | alle 2 Tage nötig, gilt für **alle** Beete gleichzeitig |
| Ernten | 1 Handlung | |

- Reifezeit **5 Tage**, unter elektrischem Licht **4 Tage** — eine Sicherung kann
  also Nahrung beschleunigen statt einen Raum auszuleuchten.
- **Zwei Tage ohne Gießen und die Pflanzung stirbt.**
- Jede Ernte gibt mit 50 % Chance 1 × `seeds` zurück. Ohne diesen Rückfluss läuft
  ein 20-Tage-Durchlauf trocken.
- Ereignisse können eine Ernte kurz vor der Reife vernichten. Zwei Beete parallel
  sind Risikostreuung, keine Verschwendung.

**Zeitrechnung:** Wer an Tag 2 beide Beete bepflanzt, erntet ab Tag 7 und noch einmal
ab Tag 13 — zusammen ~400 Punkte, genug für den Rettungsweg. Wer erst an Tag 10
anfängt, schafft Tag 20 nicht mehr und merkt es an Tag 15.

### 3.2 Fallen

| ID | Name im Spiel | Wirkung | Fundort | Anzahl |
|---|---|---|---|---|
| `wire` | Coil of wire | Bauteil für Fallen | Attic, Cellar | 2–3 |
| `trap` | Snare | Aufgestellt in Cellar oder Attic | selbst gebaut | — |

- Bauen und Aufstellen: `board` + `wire`, **1 Handlung**.
- Alle **2 Tage** fängt eine Falle etwas: **+25 FOOD**. Leeren ist kostenlos.
- Roh gegessen: **20 % *Sick***. Am Herd gegart: sicher, kostet 1 Handlung und Strom.
- Maximal **3 Fallen** gleichzeitig.

Fallen überbrücken die Lücke zwischen dem Aufbrauchen der Hausvorräte und der ersten
Ernte. Allein decken sie etwa **45 % des Bedarfs** — genug, um langsam zu verhungern,
nicht genug zum Überleben.

---

## 4. Bauen und Werkzeug · `build`

| ID | Name im Spiel | Wirkung | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|
| `hammer` | Hammer | Nötig für alles Vernageln | Attic | 1 | 1 |
| `board` | Wooden board | **2 pro Barrikade** | Attic, Cellar, aus Möbeln | 8–12 | 6 |
| `nails` | Box of nails | 10 Nägel, **4 pro Barrikade** | Attic, Study | 3–4 | 3 |
| `crowbar` | Crowbar | Öffnet Kisten und Türen ohne Schlüssel | Cellar, Attic | 0–1 | 1 |
| `screwdriver` | Screwdriver | Öffnet den Sicherungskasten | Attic, Kitchen | 1 | 1 |
| `rope` | Length of rope | Bauteil für die Stolperschnur | Attic, Cellar | 1–2 | 2 |
| `can_empty` | Empty tin | Bauteil für die Stolperschnur, entsteht beim Essen | von selbst | — | 6 |
| `rag` | Oily rag | Bauteil für die Fackel | Attic, Kitchen | 1–3 | 3 |

**Möbel zerlegen:** **2 Handlungen**, gibt 2–3 Bretter und verändert den Raum dauerhaft
(das Sofa, hinter dem du dich verstecken konntest, ist dann weg). Bücherregale in der
Library sind die ergiebigste Quelle.

### Die vier Bau-Rezepte

Mehr Crafting gibt es nicht — das Spiel ist kein Bastelsimulator.

| Ergebnis | Zutaten | Kosten | Wirkung |
|---|---|---|---|
| **Barricade** (SAFETY 3) | 2 × board, 4 × nail, hammer | 2 Handlungen | Beste Sicherung, hält 2–4 Nächte |
| **Trip line** | rope + 2 × can_empty | 1 Handlung | Siehe unten |
| **Snare** | board + wire | 1 Handlung | Alle 2 Tage +25 FOOD |
| **Torch** | board + rag + matches | 1 Handlung | LIGHT 1 für einen Tag, danach weg. Notlösung. |

### `trip_line` — Stolperschnur

Wird in einem Raum aufgestellt und bleibt dort.

**Wirkung:** Wandelt jedes Damage-, Theft- oder Mark-Ereignis dieser Nacht in das
Wake-Ereignis **N-W-14** um — du wachst rechtzeitig auf und bekommst eine Wahl statt
einer Rechnung.

**Haken:** Sie wird dabei zerstört. Und sie löst auch bei harmlosen Ereignissen aus:
dann kostet sie ein Schlaf-Segment für nichts.

Das mächtigste Item im Spiel und trotzdem keine Lösung — nur eine Versicherung,
die jede Nacht Prämie kostet.

---

## 5. Gesundheit · `medical`

| ID | Name im Spiel | Wirkung | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|
| `bandage` | First aid tin | Heilt *Injured* und *Bleeding*, kostenlos | Bathroom, Kitchen | 2–4 | 3 |
| `pills` | Bottle of pills | Heilt *Sick* und *Fevered*, braucht zusätzlich eine volle Nacht | Bathroom, Bedroom | 2–3 | 3 |
| `whiskey` | Bottle of whiskey | Heilt *Shaken* sofort · **ENERGY −1** am nächsten Tag | Parlor, Cellar | 1–2 | 2 |
| `blanket` | Wool blanket | Schlafen ohne Bett zählt wie im Bett (**ENERGY +1**) | Bedroom, Nursery | 1 | 1 |

---

## 6. Schlüssel und Zugang · `key`

| ID | Name im Spiel | Öffnet | Fundort |
|---|---|---|---|
| `key_cellar` | Cellar key | Kellertür | Kitchen, Hakenbrett |
| `key_study` | Small brass key | Schreibtischschublade im Study | Bedroom, Parlor |
| `key_attic` | Attic key | Dachbodenluke (ab Tag 7) | Study, Bedroom |
| `safe_code` | *(Notiz, kein Item)* | Safe im Study — dreistellige Zahl | drei Fragmente verteilt |

Alle Türen lassen sich mit dem **Brecheisen** öffnen: 1 Handlung, aber die Tür ist
dauerhaft beschädigt — **dieser Raum kommt nie über SAFETY 1 hinaus.**
Der schnelle Weg heute kostet dich jede weitere Nacht.

---

## 7. Hinweis-Gegenstände · `clue`

Keine Ressourcen — sie gehen ins Notizbuch und belegen **keinen Slot**.

| ID | Name im Spiel | Frage | Fundort |
|---|---|---|---|
| `note_ledger` | Household ledger | 1 · What does it take? | Study |
| `note_letter_a` | Unsent letter | 1 | Bedroom |
| `note_marks` | Tally on a doorframe | 1 | Cellar |
| `note_receipt` | Repair receipt | 2 · Which room? | Kitchen |
| `note_floorplan` | Floor plan, amended | 2 | Study, Library |
| `note_damp` | Surveyor's note | 2 | Library |
| `photo_family` | Family photograph | 3 · What goes back? | Parlor |
| `photo_wrong` | The same photograph, later | 3 | Nursery |
| `note_inventory` | List of belongings | 3 | Attic |
| `note_deed` | Deed to the house | 4 · Where to? | Study, Safe |
| `note_marker` | Rubbing from a marker | 4 | Cellar, Conservatory |
| `book_page` | Torn page | 4 | Library |
| `dream_note` | *(entsteht im Schlaf)* | beliebig | Ereignis N-C-01 |

**Zwölf Fragmente für vier Fragen.** Im Haus liegen mehr Fundorte als nötig —
du findest nie alle, und zwei widersprechen sich. Das wird nicht aufgelöst.

### Die vier Rückgabe-Gegenstände

Einer davon ist pro Durchlauf der richtige. Welcher, sagt dir Frage 3.

| ID | Name im Spiel | Fundort |
|---|---|---|
| `ring` | Wedding ring | Bathroom, im Abfluss |
| `doll` | Cloth doll | Nursery |
| `locket` | Locket with a picture | Bedroom, unter der Matratze |
| `pocket_watch` | Pocket watch, stopped | Parlor, Study |

Und einer von vier Orten ist der richtige — Frage 4:
**Cellar floor · Conservatory ground · Nursery hearth · Behind the front door.**

---

## 8. Was im Haus liegt — Zusammenfassung

| Kategorie | Menge zu Beginn | Reicht für | Nachschub |
|---|---|---|---|
| Nahrung | 12–20 Einheiten, ~350 Punkte | **12 von 20 Tagen** | Anbau, Fallen, Funde |
| Batterien | 6–10 | 6–10 Tage Taschenlampe | nur Funde |
| Kerzen | 6–10 | 12–20 Tage Raumlicht | nur Funde |
| Sicherungen | 3 aktiv + 2–3 Ersatz | dauerhaft, brennen aber durch | Funde |
| Bretter | 8–12 | 4–6 Barrikaden | Möbel zerlegen (endlich) |
| Nägel | 30–40 | 7–10 Barrikaden | nur Funde |
| Verbandsmaterial | 2–4 | 2–4 Verletzungen | nur Funde |
| Samen | 2–4 | 2–4 Pflanzungen | 50 % Rückfluss pro Ernte |

**Nur zwei Dinge wachsen nach:** die Ernte und die Fallen. Licht, Material und
Medizin werden über zwanzig Tage unweigerlich weniger.

**Sparen ist auch falsch.** Wer nichts verbraucht, findet nichts, sichert nichts und
schläft schlecht — und schlecht schlafen heißt weniger Handlungen, also noch weniger
finden. Die Abwärtsspirale ist das eigentliche Fail-State-Design.

---

## 9. Offene Fragen

1. `chocolate` gibt ENERGY +1 — die einzige Möglichkeit, das Tagesbudget direkt zu
   erhöhen. Zu stark für ein 15-Punkte-Item?
2. Leere Dosen werden automatisch behalten, damit die Stolperschnur nicht an
   Buchhaltung scheitert. In Ordnung?
3. Reicht ein Traglimit von 6 Slots, wenn Laufen kostenlos ist? Es zwingt zu mehreren
   Wegen, kostet aber keine Handlungen mehr — die Beschränkung könnte zahnlos sein.
