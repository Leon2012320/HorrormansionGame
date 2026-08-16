# Ereignisse — ASHGROVE

**Version 0.6 — Ereignisse werden mit Gegenständen gelöst, nicht mit Entscheidungen.**

Texte sind **Englisch** (Spielsprache), Erklärungen deutsch.
Alle Einträge stehen als Datentabelle in `content/events_db.gd`.

---

## Das Grundprinzip

Ein Ereignis stellt ein **Problem**. Das Spiel fragt dich nicht, was du tun willst —
es fragt, **was du dabei hast**.

```
   Etwas arbeitet an den Brettern deiner Tür.

   [Hammer + 1 Brett]  →  Du nagelst nach. Nichts geht kaputt.
   [Brecheisen]        →  Du verkeilst es. Hält bis zum Morgen.
   Nichts davon dabei  →  Die Barrikade verliert zwei Stufen.
```

Es gibt **keine Auswahl zwischen Verhaltensweisen** mehr — kein "nachsehen /
ignorieren / zurückrufen". Die Entscheidung ist längst gefallen: nämlich am Tag,
als du entschieden hast, was in deine sechs Inventarplätze kommt.

### Warum das besser ist

1. **Der Tag bekommt Bedeutung.** Vorbereitung ist keine Fleißaufgabe mehr,
   sondern die eigentliche Entscheidung des Spiels.
2. **Die sechs Slots werden zur Kernfrage.** Hammer und Bretter? Kerzen? Verbände?
   Alles passt nicht, und was fehlt, merkst du nachts um drei.
3. **Man kann es lernen.** Ereignisse haben logische Lösungen. Beim zweiten
   Durchlauf packst du anders — nicht, weil du die Antwort auswendig kannst,
   sondern weil du das Haus verstanden hast.
4. **Kein Raten.** Eine Multiple-Choice-Frage ohne erkennbar richtige Antwort ist
   Glücksspiel mit Extraschritten. "Habe ich einen Hammer?" ist eine echte Frage.

### Wenn du mehrere Lösungen dabei hast

Dann zeigt das Spiel sie alle, und du wählst. Das ist keine Rückkehr zur
Multiple-Choice: die Möglichkeiten stehen nicht im Ereignis, sondern in deiner Tasche.
Meist unterscheiden sie sich im Preis — das Brett ist verbraucht, das Brecheisen nicht.

---

## Schreibregeln für neue Ereignisse

1. **Nie ein Wesen benennen.** Nur Wirkungen: eine offene Tür, ein warmer Stuhl.
2. **Nie erklären.** Kein Ereignis nennt eine Ursache.
3. **Alltäglich, dann falsch.**
4. **Nichts über die Figur behaupten.** Sie hat keinen Namen und keine Vergangenheit.
5. **Jedes Problem-Ereignis braucht eine Lösung, auf die man von selbst kommt.**
   Wer bei "etwas arbeitet an den Brettern" an einen Hammer denkt, soll recht haben.
6. **Kein Ereignis tötet.** Es gibt Zustände, und Zustände töten bei Vernachlässigung.
7. **Die Strafe ohne Lösung muss weh tun, aber weitergehen lassen.**

---

## Die Kategorien

| Kategorie | Anteil | Lösbar? | Was es tut |
|---|---|---|---|
| **PROBLEM** | 40 % | **ja, mit Gegenstand** | Der Kern des Spiels |
| **SOUND** | 25 % | nein | Nur Geräusch, ENERGY −1 |
| **DAMAGE** | 10 % | nein | Es ist schon passiert |
| **THEFT** | 10 % | nur Stolperschnur | Etwas fehlt |
| **CLUE** | 10 % | nein | Das Haus gibt dir etwas |
| **MOVE** | 5 % | nein | Du wachst woanders auf |

Damage, Theft und Move sind bewusst **nicht** lösbar. Sonst hätte alles eine Antwort,
und das Haus wäre nur noch eine Werkzeugliste.

**Format:** `needs` wird verbraucht · `tool` bleibt erhalten · beides muss dabei sein.

---

# TEIL A · PROBLEM-EREIGNISSE

Die Hauptkategorie. Jedes ist ein Problem mit mindestens zwei Lösungswegen.

---

### N-P-01 · The Boards
`weight 5` · ab Tag 3 · nur bei SAFETY ≥ 2

> *Something is working at the boards across the door. Not forcing them. Testing
> where the wood is thinnest.*

| Lösung | Ergebnis |
|---|---|
| **1 × board** + Werkzeug **hammer** | Du nagelst nach. Die Barrikade bleibt, wie sie war. |
| Werkzeug **crowbar** | Du verkeilst die Tür. Hält bis zum Morgen, aber nicht länger. |
| **nichts davon** | Barrikade **−2 Stufen**. Der Rest der Nacht zählt nicht für ENERGY. |

---

### N-P-02 · The Door Standing Open
`weight 5` · ab Tag 1 · nur bei SAFETY ≥ 1

> *The door is open. Not forced — opened. Whatever you wedged under the handle has
> been set neatly against the wall.*

| Lösung | Ergebnis |
|---|---|
| **2 × board** + **1 × nails** + **hammer** | SAFETY 3. Der Rest der Nacht ist ruhig. |
| **padlock_chain** *(Sonder-Item)* | Diese Tür ist ab jetzt dauerhaft dicht. |
| **trip_line** | Du hörst es beim nächsten Mal. Die Nacht läuft normal weiter. |
| **nichts davon** | ENERGY −1, und ein zufälliger Gegenstand ist am Morgen weg. |

---

### N-P-03 · Breathing in the Dark
`weight 5` · ab Tag 1 · nur bei LIGHT ≤ 1

> *Someone in the room is breathing. Slow, even, patient. When you hold your breath
> to listen, so do they.*

| Lösung | Ergebnis |
|---|---|
| **1 × candle** + **matches** | Der Raum ist leer. LIGHT 2 für den Rest der Nacht. |
| **1 × battery** + Werkzeug **flashlight** | Der Raum ist leer. LIGHT 1 für den Rest der Nacht. |
| Werkzeug **lantern** + **1 × lamp_oil** | Der Raum ist leer, und er bleibt hell. |
| **nichts davon** | Zustand *Shaken*, Segment verfällt. |

Das häufigste Ereignis im Spiel und die klarste Lektion: **nimm Licht mit ins Bett.**

---

### N-P-04 · The Cold
`weight 4` · ab Tag 2

> *Your breath is showing. The window is shut. It is not that time of year.*

| Lösung | Ergebnis |
|---|---|
| **blanket** *(bleibt erhalten)* | Du schläfst weiter. Nichts passiert. |
| **1 × board** + **matches** | Ein Feuer. Der Raum bleibt bis zum Morgen warm. |
| **1 × whiskey** | Hilft gegen die Kälte. ENERGY −1 am nächsten Tag. |
| **nichts davon** | 40 % Zustand *Sick*, Segment verfällt. |

---

### N-P-05 · The Cut
`weight 4` · ab Tag 2

> *You wake up bleeding. Four thin lines along the forearm, evenly spaced. They did
> not hurt until you looked at them.*

| Lösung | Ergebnis |
|---|---|
| **1 × bandage** | Verbunden. Kein Zustand. |
| **1 × whiskey** | Ausgewaschen. *Injured*, aber es wird nicht schlimmer. |
| **nichts davon** | Zustand *Injured*. Unbehandelt wird daraus nach zwei Tagen *Bleeding*. |

---

### N-P-06 · The Fuse
`weight 3` · ab Tag 4 · nur wenn eine Sicherung steckt

> *Everything electric goes out at once. The box in the cellar is warm to the touch.*

| Lösung | Ergebnis |
|---|---|
| **1 × fuse** + Werkzeug **screwdriver** | Ersetzt. Das Licht kommt zurück. |
| **1 × fuse** | Ersetzt, aber du reißt dir die Hand auf: *Injured*. |
| **nichts davon** | Die Sicherung ist zerstört. Der Raum fällt auf LIGHT 0. |

---

### N-P-07 · The Window
`weight 4` · ab Tag 2 · nur in Räumen mit Fenster

> *The window is open. You did not open it. Outside there is no wind, no sound, no
> insects — as if the night is holding still to see what you do.*

| Lösung | Ergebnis |
|---|---|
| **1 × board** + **1 × nails** + **hammer** | Zugenagelt. Dieser Raum bekommt dauerhaft **+1 SAFETY**. |
| Werkzeug **crowbar** | Du klemmst es fest. Hält diese Nacht. |
| **nichts davon** | Kälte und offene Flanke: ENERGY −1, nächste Ziehung +15. |

Die einzige Gelegenheit im Spiel, einen Raum **dauerhaft** zu verbessern.
Wer nie Bretter dabei hat, bekommt sie nie.

---

### N-P-08 · Something Under the Floor
`weight 4` · ab Tag 5 · nur Erdgeschoss oder Keller

> *Under the boards, something shifts its weight. It is not scratching. It is making
> itself comfortable.*

| Lösung | Ergebnis |
|---|---|
| Werkzeug **crowbar** | Du hebst ein Brett an. Darunter ist ein Hohlraum: **1 Fragment**. |
| **1 × trap** | Du stellst die Falle darüber. Am Morgen ist sie zugeschnappt: **+25 FOOD**. |
| **nichts davon** | Es geht die ganze Nacht so. ENERGY −1, Segment verfällt. |

---

### N-P-09 · In the Stores
`weight 4` · ab Tag 4 · nur wenn du Nahrung im Lager hast

> *Something is in the stores. You can hear the tins moving against each other,
> unhurried, one at a time.*

| Lösung | Ergebnis |
|---|---|
| **1 × trap** | Gestellt und zugeschnappt. Nichts fehlt, und **+25 FOOD** dazu. |
| **trip_line** *(wird zerstört)* | Du wachst rechtzeitig auf. Nichts fehlt. |
| **nichts davon** | **Zwei** Nahrungsgegenstände sind weg. |

---

### N-P-10 · The Lock
`weight 3` · ab Tag 6

> *The door you came through will not open from this side. It has no lock. It has
> never had a lock.*

| Lösung | Ergebnis |
|---|---|
| Werkzeug **crowbar** | Aufgehebelt. Der Raum kommt danach nie über SAFETY 1 hinaus. |
| Werkzeug **lockpicks** *(Sonder-Item)* | Sauber geöffnet, ohne Schaden. |
| **1 × board** + **hammer** | Du schlägst dich durch die Wandverkleidung. Laut, aber es geht. |
| **nichts davon** | Du sitzt bis zum Morgen fest: **Nacht endet**, ENERGY morgen 2. |

---

### N-P-11 · The Damp
`weight 3` · ab Tag 5

> *Water is coming through the ceiling, exactly and only above the place where you
> keep your things.*

| Lösung | Ergebnis |
|---|---|
| **1 × rag** | Aufgefangen und abgedeckt. Nichts wird nass. |
| **blanket** *(wird nass, bleibt aber)* | Deine Sachen sind trocken, du frierst: ENERGY −1. |
| **nichts davon** | Ein zufälliger Gegenstand ist ruiniert — Streichhölzer, Notiz, Batterie oder Samen. |

---

### N-P-12 · Rot
`weight 3` · ab Tag 6 · nur wenn du verderbliche Lebensmittel hast

> *There is a smell. Everything soft you own has turned overnight, and it has turned
> further than one night allows.*

| Lösung | Ergebnis |
|---|---|
| **1 × preserves** *(als Tausch)* | Du sortierst rechtzeitig aus. Nur das eine Glas geht verloren. |
| Küche hat **LIGHT 3** *(Strom)* | Was kühl stand, hat gehalten. Nichts verdirbt. |
| **nichts davon** | **Alle verderblichen Lebensmittel** sind hin. |

Das einzige Ereignis, das eine **Sicherung** als Lösung akzeptiert —
und damit ein Grund, Strom in die Küche zu legen statt ins Schlafzimmer.

---

### N-P-13 · The Fever
`weight 3` · ab Tag 4 · nur wenn du *Sick* bist

> *You are burning up. The room is cold and you are soaked through, and you cannot
> tell which of those two things is the wrong one.*

| Lösung | Ergebnis |
|---|---|
| **1 × pills** | Heruntergefiebert. *Sick* ist weg. |
| **morphine** *(Sonder-Item)* | Alles weg, sofort. Zwei Tage ENERGY −1. |
| **nichts davon** | *Sick* wird zu *Fevered*. Von da sind es zwei Tage bis zum Tod. |

---

### N-P-14 · Scratching at the Cellar Door
`weight 4` · ab Tag 3

> *Something is at the cellar door. Not knocking. Testing.*

| Lösung | Ergebnis |
|---|---|
| **2 × board** + **1 × nails** + **hammer** | Zugenagelt. Der Keller ist bis auf Weiteres zu. |
| **trip_line** *(wird zerstört)* | Es geht weg, als die Dosen fallen. |
| **1 × candle** + **matches** | Licht im Flur. Es hört auf. Die Kerze ist morgen herunter. |
| **nichts davon** | Barrikade des Kellers **−1**, ENERGY −1. |

---

### N-P-15 · The Weight
`weight 3` · ab Tag 6 · nur in Räumen mit Bett

> *The mattress dips beside you. Not much. Just the weight of someone sitting down on
> the edge, careful not to wake you.*

| Lösung | Ergebnis |
|---|---|
| **1 × candle** + **matches** | Beim Licht ist niemand da. Die Seite des Betts ist warm. **1 Fragment**. |
| **1 × whiskey** | Du schläfst darüber hinweg. ENERGY −1 morgen. |
| **nichts davon** | Zustand *Shaken*, **Nacht endet**. |

---

### N-P-16 · The Smell of Cooking
`weight 2` · ab Tag 5 · Einmal

> *Something is cooking. It smells like a proper meal, the kind you have not had in
> days. The stove has no power.*

| Lösung | Ergebnis |
|---|---|
| **1 × can_beans** *oder eine andere Konserve* | Du isst deine eigene, im Dunkeln, und gehst nicht nachsehen. Nichts passiert. |
| **nichts dabei** | Du gehst hin und isst, was da steht: **FOOD +55**, **1 Fragment**, und *Shaken*. |

Das einzige Ereignis, bei dem **die Lösung schlechter ist als das Scheitern** —
wer nichts zu essen hat, bekommt das beste Ergebnis und bezahlt mit dem Verstand.

---

# TEIL B · NICHT LÖSBAR

Diese passieren einfach. Sie sind das Gegengewicht: Wären alle Ereignisse mit
Werkzeug abzuwenden, wäre das Haus nur eine Packliste.

## B1 · SOUND — nur Geräusch

Alle: Gewicht 3, ab Tag 2, **ENERGY −1**, sonst nichts.

| ID | Text |
|---|---|
| **N-S-01** | *Water running somewhere below. It stops when you notice it.* |
| **N-S-02** | *A door closes, two floors down. Then again. Then again, more quietly.* |
| **N-S-03** | *Something is dragged across the ceiling, corner to corner, and back.* |
| **N-S-04** | *A chair scrapes in the room next to yours. There is no chair in that room.* |
| **N-S-05** | *Someone is humming. It is a tune you know, but not from anywhere you can name.* |
| **N-S-06** | *The house settles. It settles again. It settles in perfect rhythm, like breathing.* |
| **N-S-07** | *A cough. Close. Politely muffled, the way you cough in a room where someone is sleeping.* |
| **N-S-08** | *Footsteps on the stairs, going down. They stop halfway and do not continue.* |

## B2 · DAMAGE — schon passiert

Ab Tag 4, höchstens eines pro Nacht.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-D-01** | 3 | *Two of the jars have burst. The shelf is wet and the cellar smells sweet.* | 2 × `preserves` weg |
| **N-D-02** | 2 | *The window in the next room has cracked from corner to corner. Nothing hit it.* | Nachbarraum nie über SAFETY 2 |
| **N-D-03** | 3 | *The boards have come away at one corner. The nails are on the floor, in a row.* | Barrikade −1 |

## B3 · THEFT — etwas fehlt

Ab Tag 4. **Nur die Stolperschnur** kann sie abwenden — dann wird stattdessen
N-P-09 gezogen.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-T-01** | 4 | *One tin is missing. You counted them last night. You counted them twice.* | 1 Konserve |
| **N-T-02** | 3 | *The hammer is not where you left it.* | Hammer weg, taucht in 1–3 Tagen woanders auf |
| **N-T-03** | 3 | *The batteries are flat. All of them. You have not used the flashlight since yesterday.* | alle Batterien |
| **N-T-04** | 3 | *The matches are damp. The box has been sitting in something.* | 1 Schachtel |
| **N-T-05** | 1 | *A page in your notebook has run. The ink is smeared edge to edge. You remember writing it. You do not remember what it said.* | 1 Fragment unleserlich, am Fundort wieder holbar |

## B4 · MOVE — du wachst woanders auf

Ab Tag 5.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-V-01** | 3 | *You wake in the upstairs hall. Your shoes are beside you, set side by side.* | Nacht endet |
| **N-V-02** | 2 | *You wake in front of the door. Your hand is on the handle. It is still locked.* | Nacht endet, ENERGY morgen 2 |
| **N-V-03** | 2 | *You wake in the cellar. There is no light and you do not remember the stairs.* | Getragenes bleibt im alten Raum |

## B5 · CLUE — das Haus gibt dir etwas

Ab Tag 2.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-C-01** | 4 | *There is writing on the last page of your notebook. It is your handwriting. It is not your sentence.* | 1 Fragment |
| **N-C-02** | 2 | *You dreamed about a room in this house. You have not been in it yet. You know where the door is.* | Raum aufgedeckt |
| **N-C-03** | 3 | *A word has been written in the dust on the floor. It is a name, or half of one.* | 1 Fragment |
| **N-C-04** | 3 | *You remember something clearly that you know you did not do.* | 1 Fragment |
| **N-C-05** | 2 | *There is a note under the door. The paper is old. The ink is not.* | 1 Fragment |

---

# TEIL C · TAG

4 % Chance pro Raumwechsel. Fast nur Atmosphäre.

## C1 · AMBIENT — folgenlos

| ID | Text |
|---|---|
| **D-A-01** | *The picture in the hall is crooked. You straighten it. Later, it is crooked again.* |
| **D-A-02** | *There are footprints in the dust. Your size. Facing the other way.* |
| **D-A-03** | *The hall clock is running. It was not running yesterday and there is no key for it.* |
| **D-A-04** | *The seat of the armchair is warm.* |
| **D-A-05** | *Every door upstairs is open. You closed them all this morning.* |
| **D-A-06** | *You can hear yourself moving around upstairs.* |

## C2 · SUPPLY — Funde

Gewicht **×3**, wenn FOOD unter 25.

| ID | Text | Fund |
|---|---|---|
| **D-S-01** | *Something has rolled behind the dresser and been there a long time.* | 1–2 Konserven |
| **D-S-02** | *There is a box of matches in the coat by the door. The coat is not yours.* | 1 Schachtel |
| **D-S-03** | *A toolbox under the workbench, closed with a latch that still works.* | Nägel + Draht |
| **D-S-04** | *A drawer of candle stubs. Household candles, kept for power cuts.* | 3 Kerzen |
| **D-S-05** | *Somebody kept a bag packed by the back door.* | Verband, Konserve, Batterie |

---

# TEIL D · Die Packliste

Weil Ereignisse jetzt Werkzeug verlangen, ist die eigentliche Frage jedes Abends:
**was kommt in die sechs Plätze?** Hier, was womit gelöst wird:

| Gegenstand | Löst |
|---|---|
| **hammer** *(Werkzeug)* | N-P-01 · N-P-02 · N-P-07 · N-P-10 · N-P-14 |
| **board** | N-P-01 · N-P-02 · N-P-04 · N-P-07 · N-P-10 · N-P-14 |
| **candle** + **matches** | N-P-03 · N-P-14 · N-P-15 |
| **crowbar** *(Werkzeug)* | N-P-01 · N-P-07 · N-P-08 · N-P-10 |
| **bandage** | N-P-05 |
| **whiskey** | N-P-04 · N-P-05 · N-P-15 |
| **trip_line** | N-P-02 · N-P-09 · N-P-14 · wendet Diebstahl ab |
| **trap** | N-P-08 · N-P-09 |
| **fuse** + **screwdriver** | N-P-06 |
| **pills** | N-P-13 |
| **blanket** | N-P-04 · N-P-11 |
| **rag** | N-P-11 |

**Hammer und Bretter decken die meisten Probleme ab** — und belegen die meisten Plätze.
Kerzen sind die zweitbeste Wahl, weil Dunkelheit die häufigste Ursache ist.
Verbände und Pillen liegen tot in der Tasche, bis du sie brauchst, und dann ist es zu spät,
sie zu holen.

Wer alles mitnimmt, nimmt nichts mit: sechs Plätze sind sechs Plätze.

---

# TEIL E · Offene Fragen

1. **N-P-16 "The Smell of Cooking"** ist absichtlich verdreht — wer Nahrung dabei
   hat, bekommt das schlechtere Ergebnis. Reizvoll oder verwirrend?
2. **Sollen Werkzeuge verschleißen?** Aktuell hält der Hammer ewig. Ein Bruchrisiko
   von 5 % pro Nacht würde Ersatzbeschaffung erzwingen.
3. **Zu viele Probleme brauchen Bretter.** Sechs von sechzehn. Vielleicht sollte
   ein zweites Baumaterial her — Draht? Seil?
4. **Sollen ungelöste Probleme dasselbe Ereignis am nächsten Abend wiederholen?**
   Das würde Druck aufbauen, könnte aber unfair wirken, wenn das Material fehlt.
