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

**Und jetzt die entscheidende Zahl:** Im Haus liegen zu Beginn etwa **620 FOOD-Punkte —
Vorräte für elf Tage.** Ein voller Durchlauf geht bis Tag 50, der schnelle Weg über
das Geheimnis endet frühestens an Tag 20.

| | Bedarf | Gedeckt durch Hausvorräte |
|---|---|---|
| Weg über das Geheimnis (Tag 22–28) | ~1.400 Punkte | 44 % |
| Weg über die Rettung (Tag 50) | ~2.800 Punkte | 22 % |

Die Lücke ist Absicht. Fundereignisse tragen etwa 20 Punkte pro Tag bei — das reicht
für keinen der beiden Wege. **Ab etwa Tag 8 musst du Nahrung selbst produzieren**
(Abschnitt 3), sonst verhungerst du garantiert, egal wie gut du sonst spielst.

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

**Zur Knappheit:** 8–12 Batterien sind für einen Durchlauf von 50 Tagen **fast nichts** —
die Taschenlampe ist für Notfälle und kurze Wege, nicht zum Erkunden. Wer den Keller
durchsuchen will, nimmt eine Kerze mit und stellt sie hin. Kerzen sind die eigentliche
Lichtwährung, und auch sie reichen nur für etwa zwei Wochen: **ab dem Mittelspiel ist
elektrisches Licht die einzige tragfähige Quelle** — und davon gibt es drei Räume.

Nachschub kommt fast nur aus Fundereignissen. Wer im ersten Drittel großzügig
beleuchtet, sitzt ab Tag 25 im Dunkeln.

---

## 3. Nahrungsproduktion · `farm`

Ohne diesen Abschnitt ist das Spiel nicht zu gewinnen.

### 3.1 Der Wintergarten — Anbau

Vier Beete. Die einzige Quelle, die über Tag 20 hinaus trägt.

| ID | Name im Spiel | Wirkung | Fundort | Anzahl |
|---|---|---|---|---|
| `seeds` | Packet of seeds | Bepflanzt ein Beet | Conservatory, Cellar, Attic | 3–6 |
| `watering_can` | Watering can | Nötig zum Gießen | Conservatory | 1 |
| `rain_barrel` | *(fest im Wintergarten)* | Füllt sich bei Regen, fasst 6 Füllungen | — | 1 |
| `crop_ripe` | Ripe crop | Ernte: 3–5 Nahrungseinheiten, ~150 FOOD | — | — |

| Handlung | Zeit | Bedingung |
|---|---|---|
| Beet bepflanzen | 15 min | 1 × `seeds` |
| Gießen (täglich nötig) | 10 min | Wasser in der Regentonne |
| Ernten | 20 min | Beet ist reif |

- Reifezeit **10 Tage**, unter elektrischem Licht **7 Tage** —
  eine deiner drei Sicherungen kann also Nahrung beschleunigen statt Räume auszuleuchten.
- **Zwei Tage ohne Gießen und die Pflanzung stirbt.** Der Anbau bindet dich täglich.
- Ereignisse können eine Ernte kurz vor der Reife vernichten. Vier Beete parallel
  sind deshalb keine Verschwendung, sondern Risikostreuung.
- Samen aus der eigenen Ernte: jede Ernte gibt mit 50 % Chance 1 × `seeds` zurück.
  Ohne diesen Rückfluss läuft ein 50-Tage-Durchlauf irgendwann trocken.

**Zeitrechnung:** Wer an Tag 3 alle vier Beete bepflanzt, erntet ab Tag 13 etwa
600 Punkte und kann ab dann durchgehend nachpflanzen. Wer erst an Tag 15 anfängt,
kommt nicht bis Tag 50. Die Entscheidung fällt also in der ersten Woche, lange bevor
der Spieler den Druck spürt — und das ist genau die Art von Falle, die dieses Spiel stellen soll.

### 3.2 Fallen — schnell, wenig, ekelhaft

| ID | Name im Spiel | Wirkung | Fundort | Anzahl |
|---|---|---|---|---|
| `wire` | Coil of wire | Bauteil für Fallen | Attic, Cellar | 2–4 |
| `trap` | Snare | Aufgestellt in Cellar oder Attic | selbst gebaut | — |

- Bauen: `board` + `wire`, 20 Minuten.
- Alle **2–3 Tage** fängt eine Falle etwas: **+25 FOOD**.
- Roh gegessen: **20 % Zustand *Sick***. Am Herd gegart: sicher, aber das braucht
  wieder Strom — oder ein Kaminfeuer und damit Brennholz.
- Bis zu 3 Fallen gleichzeitig. Danach fängt keine mehr etwas.

Fallen sind die Überbrückung zwischen dem Aufbrauchen der Hausvorräte (Tag 11) und
der ersten Ernte (Tag 13, wenn man früh gepflanzt hat). Wer den Anbau verschlafen
hat, kann mit Fallen allein etwa **60 % seines Bedarfs** decken — genug, um langsam
zu verhungern, nicht genug, um zu überleben.

---

## 4. Bauen und Werkzeug · `build`

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

### Die vier Bau-Rezepte

Mehr Crafting gibt es nicht — das Spiel ist kein Bastelsimulator.

| Ergebnis | Zutaten | Zeit | Wirkung |
|---|---|---|---|
| **Barricade** (SAFETY 3) | 2 × board, 4 × nail, hammer | 30 min | Beste Sicherung, hält 2–4 Nächte |
| **Trip line** | rope + 2 × can_empty | 15 min | Siehe unten — das stärkste Item im Spiel |
| **Snare** | board + wire | 20 min | Fängt alle 2–3 Tage +25 FOOD |
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

## 5. Gesundheit · `medical`

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

## 6. Schlüssel und Zugang · `key`

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

## 7. Hinweis-Gegenstände · `clue`

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

## 8. Was im Haus verteilt liegt — Zusammenfassung

| Kategorie | Menge zu Spielbeginn | Reicht für | Nachschub |
|---|---|---|---|
| Nahrung | 17–29 Einheiten, ~620 Punkte | **11 Tage von 50** | Anbau + Fallen + Funde |
| Batterien | 8–12 | 8–12 Stunden Taschenlampe | nur Funde, selten |
| Kerzen | 8–14 | 32–56 Stunden Raumlicht | nur Funde |
| Sicherungen | 3 aktiv + 2–4 Ersatz | dauerhaft, aber sie brennen durch | Funde |
| Bretter | 8–14 | 4–7 Barrikaden | Möbel zerlegen (endlich!) |
| Nägel | 20–40 | 5–10 Barrikaden | nur Funde |
| Verbandsmaterial | 3–5 | 3–5 Verletzungen | nur Funde |
| Samen | 3–6 | 3–6 Pflanzungen | 50 % Rückfluss pro Ernte |

**Das Haus ist eine endliche Menge.** Nur zwei Dinge wachsen nach: die Ernte im
Wintergarten und die Fallen. Alles andere — Licht, Material, Medizin — wird über
fünfzig Tage unweigerlich weniger.

Daraus folgt die Kurve des Spiels: Die ersten zwei Wochen lebst du vom Haus.
Die dritte Woche lebst du von dem, was du aufgebaut hast. Danach lebst du davon,
dass du früh die richtigen Sachen aufgebaut hast.

**Sparen ist auch falsch.** Wer nichts verbraucht, findet nichts, sichert nichts
und schläft schlecht. Die Vorräte sind da, um benutzt zu werden — nur eben nicht alle
in der ersten Woche.

---

## 9. Offene Fragen

1. Sollen leere Dosen automatisch behalten werden oder muss man sie aufheben?
   (Aktuell: automatisch, damit die Stolperschnur nicht an Buchhaltung scheitert.)
2. Ist der Wecker zu stark? Er nimmt der Schlafdauer die Unsicherheit.
3. Braucht es Wasser als eigene Leiste? Aktuell nein — es wäre dieselbe Entscheidung zweimal.
