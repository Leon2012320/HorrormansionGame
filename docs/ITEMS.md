# Gegenstände — ASHGROVE

Alle Items mit konkreten Werten. Namen im Spiel sind englisch, Erklärungen deutsch.
Jede Zeile wird später eine `.tres`-Datei unter `content/items/`.

**Traglimit: 6 Slots.** Alles andere liegt in deinem Lager.
Stapelbare Dinge belegen einen Slot bis zur Stapelgröße.

---

## Die Rechnung dahinter

Damit die Zahlen unten Sinn ergeben, hier das Grundgerüst eines Tages:

| Posten | Wert |
|---|---|
| FOOD-Verbrauch wach | **3 pro Stunde** |
| FOOD-Verbrauch im Schlaf | **1 pro Stunde** |
| Tagesbedarf (16 h wach + 8 h Schlaf) | **≈ 56 Punkte** |
| REST-Verbrauch | **5 pro wacher Stunde** |
| REST-Gewinn Bett / Boden | **+20 / +8 pro Stunde** |

→ Ein Tag kostet dich also **etwa zwei Konserven oder eine warme Mahlzeit plus Kleinigkeit.**
Im Haus liegen zu Beginn Vorräte für **ungefähr 11–13 Tage**. Die Rettung kommt an
Tag 12–18. Das geht sich **nicht** von allein aus — du musst Fundereignisse mitnehmen,
sparsam essen oder früher rauskommen. Genau diese Lücke ist das Spiel.

---

## 1. Essen · `food`

| ID | Name im Spiel | FOOD | Besonderheit | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|---|
| `can_beans` | Tin of beans | +35 | hält ewig | Kitchen, Cellar | 5–8 | 4 |
| `can_meat` | Tin of meat | +40 | hält ewig | Kitchen, Cellar | 3–5 | 4 |
| `can_soup` | Tin of soup | +30 | kalt +30, aufgewärmt +45 | Kitchen | 3–6 | 4 |
| `preserves` | Jar of preserves | +30 | Glas zerbricht bei Damage-Ereignissen | Cellar | 4–8 | 3 |
| `bread` | Stale bread | +25 | **verdirbt nach 2 Tagen** | Kitchen | 1–3 | 2 |
| `apples` | Withered apples | +20 | verdirbt nach 3 Tagen | Kitchen, Conservatory | 1–3 | 3 |
| `chocolate` | Bar of chocolate | +15 | zusätzlich REST +5 | überall selten | 0–2 | 3 |
| `meal_hot` | Hot meal | +55 | **nur am Herd**, nicht lagerbar, sofort essen | selbst gekocht | — | 1 |
| `water_bottle` | Bottle of water | +10 | nur Kleinigkeit, kein eigenes System | überall | 3–6 | 3 |
| `food_spoiled` | Spoiled food | +10 | **60 % Zustand *Sick*** | entsteht von selbst | — | 3 |

**Der Herd** ist die wichtigste Nahrungsquelle: Er verwandelt eine Konserve (+35) in
eine warme Mahlzeit (+55) und gibt zusätzlich REST +10. Aber er braucht **Strom** —
also eine deiner drei Sicherungen. Eine Sicherung, die in der Küche steckt, leuchtet
kein Schlafzimmer aus. Das ist eine der schönsten Entscheidungen im Spiel.

---

## 2. Licht · `light`

| ID | Name im Spiel | Wirkung | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|
| `flashlight` | Flashlight | LIGHT 1, solange getragen · **1 Batterie pro Stunde** | Entrance Hall (Start) | 1 | 1 |
| `battery` | Battery | Eine Stunde Taschenlampe | überall | 8–12 | 6 |
| `candle` | Candle | LIGHT 2 im Raum, **brennt 4 Stunden** | Dining, Cellar, Parlor | 8–14 | 5 |
| `matches` | Box of matches | Zum Anzünden, 1 pro Vorgang | Kitchen, Parlor | 2–4 Schachteln à 8 | 3 |
| `lantern` | Oil lantern | LIGHT 2, **8 Stunden**, wiederbefüllbar | Cellar, Attic | 0–1 | 1 |
| `lamp_oil` | Can of lamp oil | Füllt die Laterne auf 8 Stunden | Cellar, Attic | 1–3 | 2 |
| `fuse` | Fuse | Ein Raum bekommt LIGHT 3 | Cellar (3 stecken drin), Attic, Study | 3 + 2–4 Ersatz | 5 |
| `bulb` | Light bulb | Ersatzbirne — ohne sie nützt die Sicherung nichts | überall | 2–5 | 4 |

**Zur Knappheit:** 8–12 Batterien für zwei Wochen sind **sehr wenig** — die Taschenlampe
ist für Notfälle und kurze Wege, nicht zum Erkunden. Wer den Keller durchsuchen will,
sollte eine Kerze mitnehmen und sie hinstellen. Kerzen sind die eigentliche Lichtwährung.

---

## 3. Bauen und Werkzeug · `build`

| ID | Name im Spiel | Wirkung | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|
| `hammer` | Hammer | Nötig für alles Vernageln | Attic | 1 | 1 |
| `board` | Wooden board | **2 pro Barrikade** (SAFETY 3) | Attic, Cellar, aus Möbeln | 8–14 | 6 |
| `nails` | Box of nails | 10 Nägel, **4 pro Barrikade** | Attic, Study | 2–4 | 3 |
| `crowbar` | Crowbar | Öffnet verschlossene Kisten und Türen ohne Schlüssel | Cellar, Attic | 0–1 | 1 |
| `screwdriver` | Screwdriver | Öffnet Sicherungskasten-Abdeckung, Schrauben | Attic, Kitchen | 1 | 1 |
| `rope` | Length of rope | Bauteil für die Stolperschnur | Attic, Cellar | 1–2 | 2 |
| `can_empty` | Empty tin | Bauteil für die Stolperschnur, entsteht beim Essen | von selbst | — | 6 |

**Möbel zerlegen:** Jedes größere Möbelstück gibt **2–3 Bretter**, kostet **25 Minuten**
und verändert den Raum dauerhaft (das Sofa, hinter dem du dich verstecken konntest,
ist dann weg). Bücherregale in der Library sind die ergiebigste Quelle.

### Die drei Bau-Rezepte

Mehr Crafting gibt es nicht — das Spiel ist kein Bastelsimulator.

| Ergebnis | Zutaten | Zeit | Wirkung |
|---|---|---|---|
| **Barricade** (SAFETY 3) | 2 × board, 4 × nail, hammer | 30 min | Beste Sicherung, hält 2–4 Nächte |
| **Trip line** | rope + 2 × can_empty | 15 min | Siehe unten — das stärkste Item im Spiel |
| **Torch** | board + rag + matches | 10 min | LIGHT 1 für 40 Minuten, danach weg. Notlösung. |

### `trip_line` — Stolperschnur

Wird in einem Raum aufgestellt und bleibt dort.
**Wirkung:** Wandelt jedes schwere Schlaf-Ereignis (Damage, Theft, Mark) in ein
Wake-Ereignis um — du wachst rechtzeitig auf und bekommst eine Wahl statt einer Rechnung.

**Haken:** Sie wird dabei zerstört und muss neu gebaut werden. Und sie weckt dich auch
bei Ereignissen, die harmlos gewesen wären: REST −10 für nichts.

Das ist das mächtigste Item im Spiel und trotzdem keine Lösung — nur eine Versicherung,
die jede Nacht Prämie kostet.

---

## 4. Gesundheit · `medical`

| ID | Name im Spiel | Wirkung | Fundort | Anzahl | Stapel |
|---|---|---|---|---|---|
| `bandage` | First aid tin | Heilt *Injured* und *Bleeding* | Bathroom, Kitchen | 3–5 | 3 |
| `pills` | Bottle of pills | Heilt *Sick*, braucht zusätzlich 8 h Schlaf | Bathroom, Bedroom | 2–4 | 3 |
| `whiskey` | Bottle of whiskey | Heilt *Shaken* sofort · **REST −15**, FOOD −5 | Parlor, Cellar | 1–2 | 2 |
| `blanket` | Wool blanket | Schlafen auf dem Boden zählt wie Bett (+20/h) | Bedroom, Nursery | 1–2 | 1 |
| `alarm_clock` | Alarm clock | Weckt dich zur eingestellten Zeit — **exakte Schlafdauer** | Bedroom | 0–1 | 1 |

**Der Wecker** klingt harmlos, ist aber taktisch stark: Ohne ihn kannst du nur in vollen
Stunden schätzen, mit ihm schläfst du exakt so lange wie geplant. Und er ist laut.
Ob das gut ist, weiß niemand.

---

## 5. Schlüssel und Zugang · `key`

| ID | Name im Spiel | Öffnet | Fundort |
|---|---|---|---|
| `key_cellar` | Cellar key | Kellertür (sonst nur mit Brecheisen) | Kitchen, Hakenbrett |
| `key_study` | Small brass key | Schreibtischschublade im Study | Bedroom, Parlor |
| `key_attic` | Attic key | Dachbodenluke | Study, Bedroom |
| `safe_code` | (Notiz, kein Item) | Safe im Study — dreistellige Zahl | drei Fragmente verteilt |

Alle Türen lassen sich alternativ mit dem **Brecheisen** öffnen — das kostet 20 Minuten
und beschädigt die Tür dauerhaft: **dieser Raum kann nie über SAFETY 1 hinaus gesichert werden.**
Der schnelle Weg heute kostet dich jede weitere Nacht.

---

## 6. Hinweis-Gegenstände · `clue`

Diese Items sind keine Ressourcen — sie gehen ins Notizbuch und belegen keinen Slot.

| ID | Name im Spiel | Frage | Fundort |
|---|---|---|---|
| `note_ledger` | Household ledger | Was nimmt es? | Study |
| `note_letter_a` | Unsent letter | Was nimmt es? | Bedroom |
| `note_receipt` | Repair receipt | Welcher Raum? | Kitchen, Cellar |
| `note_floorplan` | Floor plan, amended | Welcher Raum? | Study, Library |
| `photo_family` | Family photograph | Was muss zurück? | Parlor |
| `photo_wrong` | The same photograph, later | Was muss zurück? | Nursery |
| `note_inventory` | List of belongings | Was muss zurück? | Attic |
| `note_deed` | Deed to the house | Wohin? | Study, safe |
| `note_marker` | Rubbing from a marker | Wohin? | Cellar, Conservatory |
| `book_page` | Torn page | beliebig | Library |
| `dream_note` | *(entsteht im Schlaf)* | beliebig | Schlaf-Ereignis |

### Die vier Rückgabe-Gegenstände

Einer davon ist pro Durchlauf der richtige — welcher, sagt dir Frage 3.

| ID | Name im Spiel | Fundort |
|---|---|---|
| `ring` | Wedding ring | Bathroom, Abfluss |
| `doll` | Cloth doll | Nursery |
| `locket` | Locket with a picture | Bedroom, unter der Matratze |
| `pocket_watch` | Pocket watch, stopped | Parlor, Study |

Und einer von vier Orten ist der richtige — das beantwortet Frage 4:
**Cellar floor · Conservatory ground · Nursery hearth · Behind the front door.**

---

## 7. Was im Haus verteilt liegt — Zusammenfassung

| Kategorie | Menge zu Spielbeginn | Reicht für |
|---|---|---|
| Nahrung | 17–29 Einheiten, ~620 FOOD-Punkte | **11–13 Tage** |
| Batterien | 8–12 | 8–12 Stunden Taschenlampe |
| Kerzen | 8–14 | 32–56 Stunden Raumlicht |
| Sicherungen | 3 aktiv + 2–4 Ersatz | knapp, sie brennen durch |
| Bretter | 8–14 (+ Möbel) | 4–7 Barrikaden |
| Verbandsmaterial | 3–5 | 3–5 Verletzungen |

**Ereignisse liefern nach**, aber nicht verlässlich. Wer nur wartet, verhungert kurz
vor der Rettung. Wer alles sofort verbraucht, steht an Tag 9 im Dunkeln.

---

## 8. Offene Fragen

1. Sollen leere Dosen automatisch behalten werden oder muss man sie aufheben?
   (Aktuell: automatisch, damit die Stolperschnur nicht an Buchhaltung scheitert.)
2. Ist der Wecker zu stark? Er nimmt der Schlafdauer die Unsicherheit.
3. Braucht es Wasser als eigene Leiste? Aktuell nein — es wäre dieselbe Entscheidung zweimal.
