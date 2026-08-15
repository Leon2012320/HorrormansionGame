# Ereignisse — ASHGROVE

**Version 0.5** — jedes Ereignis vollständig ausgeschrieben, alle Werte im
Energie-System. Texte sind **Englisch** (Spielsprache), Erklärungen deutsch.
Jeder Eintrag wird eine `.tres`-Datei unter `content/events/`.

---

## Wie die Werte zu lesen sind

Nachts gibt es keine Handlungen — die kosten Ereignisse also nie. Sie kosten:

| Angabe | Bedeutung |
|---|---|
| **Segment verfällt** | Das laufende Schlaf-Segment zählt nicht für ENERGY (also −2 morgen) |
| **ENERGY −1** | Morgen früh eine Handlung weniger |
| **Nacht endet** | Alle restlichen Segmente verfallen |
| **Zustand** | *Injured*, *Sick*, *Shaken*, *Exhausted* — siehe GAME_DESIGN Abschnitt 5 |
| **Fragment** | Ein Hinweis fürs Notizbuch |

Tag-Ereignisse kosten dagegen **Handlungen**, wie alles am Tag.

**Gewicht** = relative Häufigkeit innerhalb der eigenen Kategorie.
**Einmal** = kann pro Durchlauf nur einmal gezogen werden.

---

## Schreibregeln für neue Ereignisse

1. **Nie ein Wesen benennen.** Keine Gestalt, kein Gesicht, kein Name. Nur **Wirkungen**:
   eine offene Tür, ein warmer Stuhl, ein fehlendes Glas.
2. **Nie erklären.** Kein Ereignis nennt eine Ursache.
3. **Alltäglich, dann falsch.** Ein umgestellter Stuhl wirkt stärker als eine Erscheinung.
4. **Kurz.** Zwei bis drei Sätze. Präsens, zweite Person.
5. **Nichts über die Figur behaupten.** Keine Vorgeschichte, keine Erinnerungen.
6. **Keine Option darf offensichtlich die beste sein.**
7. **Kein Ereignis tötet.** Es gibt Zustände, und Zustände töten bei Vernachlässigung.

---

# TEIL A · NACHT-DECK

90 % aller Ereignisse. Eine Ziehung pro Schlaf-Segment.

---

## A1 · WAKE — du wachst auf und entscheidest

14 Ereignisse. Die wichtigste Kategorie: hier trifft der Spieler seine echten Entscheidungen.

---

### N-W-01 · The Chair
**Wake** · Gewicht 4 · ab Tag 2 · nur bei SAFETY ≤ 2

> *You wake because the room is wrong. The chair from the corner is at the foot of
> the bed now, turned to face you.*

| Option | Kosten | Folge |
|---|---|---|
| **Put it back** | Segment verfällt | Nichts weiter. Die Nacht läuft normal weiter. |
| **Leave it. Don't look at it again.** | — | Alle restlichen Segmente dieser Nacht zählen nur halb (aufgerundet). |
| **Sit in it** | Segment verfällt | 25 % Fragment · 25 % *Shaken* · 50 % nichts |

---

### N-W-02 · The Door You Locked
**Wake** · Gewicht 5 · ab Tag 1 · nur bei SAFETY ≥ 1

> *The door is open. Not forced — opened. The chair you wedged under the handle has
> been set neatly against the wall.*

| Option | Kosten | Folge |
|---|---|---|
| **Close it and go back to sleep** | — | 50 % dasselbe Ereignis kommt in dieser Nacht noch einmal |
| **Barricade it properly** | Segment verfällt · 2 boards, 4 nails, hammer | SAFETY 3. Rest der Nacht garantiert ruhig. |
| **Move to another room** | Segment verfällt | Neuer Raum mit seinen Werten. Alles, was hier lag, bleibt hier. |
| **Stay awake until morning** | Nacht endet | Nichts passiert mehr. ENERGY morgen: nur was du bis jetzt geschlafen hast. |

---

### N-W-03 · Breathing
**Wake** · Gewicht 4 · ab Tag 1 · nur bei LIGHT ≤ 1

> *Someone in the room is breathing. Slow, even, patient. When you hold your breath
> to listen, so do they.*

| Option | Kosten | Folge |
|---|---|---|
| **Turn on the flashlight** | 1 battery | Der Raum ist leer. LIGHT 1 für den Rest der Nacht, Ziehungschance −10. |
| **Light a candle** | 1 candle, 1 match | LIGHT 2 für den Rest der Nacht, Ziehungschance −10. Teuerste und sicherste Antwort. |
| **Lie still and wait** | Segment verfällt | 60 % es hört auf · 40 % *Shaken* |

---

### N-W-04 · The Weight
**Wake** · Gewicht 3 · ab Tag 4 · nur in Räumen mit Bett

> *The mattress dips beside you. Not much. Just the weight of someone sitting down
> on the edge, careful not to wake you.*

| Option | Kosten | Folge |
|---|---|---|
| **Don't move** | Segment verfällt | Nach einer Weile hebt sich die Matratze wieder. Nichts weiter. |
| **Get up** | Segment verfällt | 40 % Fragment · 40 % nichts · 20 % *Shaken* |
| **Reach out** | — | 50 % Fragment · 50 % *Shaken*. Der Text sagt nie, was du berührst. |

---

### N-W-05 · Three Knocks
**Wake** · Gewicht 4 · ab Tag 2 · nur bei SAFETY ≥ 2

> *Three knocks on the boards. Polite. A pause exactly long enough to be an answer.
> Then three more.*

| Option | Kosten | Folge |
|---|---|---|
| **Knock back** | — | 30 % Fragment · 30 % nichts · 40 % es geht bis zum Morgen weiter (**Nacht endet**) |
| **Say nothing** | Segment verfällt | Nach vier Runden hört es auf. |
| **Check the barricade** | Segment verfällt | Du siehst den Schaden früh: die nächste Barrikaden-Beschädigung dieser Nacht wird verhindert. |

---

### N-W-06 · Your Name
**Wake** · Gewicht 3 · ab Tag 5

> *Someone downstairs is calling your name. They sound tired. They sound like they
> have been looking for you for a while.*

| Option | Kosten | Folge |
|---|---|---|
| **Answer** | — | 20 % Fragment · 30 % *Shaken* · 50 % Stille für den Rest der Nacht |
| **Go down** | Segment verfällt · LIGHT ≥ 1 nötig | 40 % Fragment · 30 % Fund (1 zufälliges Item) · 30 % *Injured* |
| **Cover your ears** | ENERGY −1 | Es hört irgendwann auf. |

Die Figur hat keinen Namen — der Text nennt deshalb nie einen. Der Spieler weiß trotzdem, was gemeint ist.

---

### N-W-07 · The Cold
**Wake** · Gewicht 3 · ab Tag 1

> *Your breath is showing. The window is shut. It is not that time of year.*

| Option | Kosten | Folge |
|---|---|---|
| **Get the blanket** | Segment verfällt | Wenn `blanket` im Lager: Ereignis endet folgenlos. Sonst: ENERGY −1. |
| **Light the fire** | 1 match, 1 board | Der Raum bleibt bis zum Morgen warm. Alle weiteren Ziehungen dieser Nacht −10. |
| **Endure it** | Segment verfällt | 25 % *Sick* |

---

### N-W-08 · The Candle
**Wake** · Gewicht 3 · ab Tag 2 · nur wenn eine Kerze im Raum brennt

> *The candle is out. You put your hand near the wick to feel for heat, and there
> is none. It is long and white and has never been lit.*

| Option | Kosten | Folge |
|---|---|---|
| **Light it again** | 1 match | 50 % es geht sofort wieder aus — dann kostet ein erneuter Versuch ein weiteres Streichholz |
| **Use a different candle** | 1 candle, 1 match | Funktioniert normal. LIGHT 2 bleibt. |
| **Sleep in the dark** | — | LIGHT 0 für den Rest der Nacht: alle weiteren Ziehungen +12 |

---

### N-W-09 · Counting the Stairs
**Wake** · Gewicht 3 · ab Tag 3

> *Footsteps on the staircase. You count them without meaning to. The staircase has
> fourteen steps. You are at twenty-one and they are still coming up.*

| Option | Kosten | Folge |
|---|---|---|
| **Keep counting** | Segment verfällt | Bei vierzig hört es auf. 35 % Fragment fürs Durchhalten. |
| **Block the door** | Segment verfällt | SAFETY +1 für diese Nacht. Die Schritte hören sofort auf. |
| **Open the door and look** | — | 20 % Fragment · 30 % *Shaken* · 50 % ein leeres Treppenhaus |

---

### N-W-10 · The Smell of Cooking
**Wake** · Gewicht 2 · ab Tag 4 · Einmal

> *Something is cooking. It smells like a proper meal, the kind you have not had in
> days. The stove has no power.*

| Option | Kosten | Folge |
|---|---|---|
| **Go to the kitchen** | Segment verfällt | Ein `meal_hot` steht auf dem Tisch. → Folgefrage unten |
| **Stay where you are** | FOOD −10 | Der Hunger wird schlimmer. Sonst nichts. |

**Folgefrage, wenn du in die Küche gehst:**

| Option | Folge |
|---|---|
| **Eat it** | FOOD +55, ein Fragment, und *Shaken*. |
| **Leave it** | Am nächsten Morgen ist der Teller abgeräumt und abgewaschen. Fragment ohne Zustand. |

---

### N-W-11 · The Window
**Wake** · Gewicht 3 · ab Tag 2 · nur in Räumen mit Fenster

> *The window is open. You did not open it. Outside there is no wind, no sound,
> no insects. It is as if the night is holding still to see what you do.*

| Option | Kosten | Folge |
|---|---|---|
| **Close and latch it** | — | Nichts weiter. |
| **Board it up** | Segment verfällt · 1 board, 2 nails | Dauerhaft dicht: dieser Raum bekommt **+1 SAFETY für den ganzen Durchlauf**. |
| **Look out** | — | 30 % Fragment · 30 % *Shaken* · 40 % nichts |

---

### N-W-12 · Tucked In
**Wake** · Gewicht 2 · ab Tag 6

> *The blanket has been pulled up to your chin and folded back. Neatly. The way
> someone does it for a child.*

| Option | Kosten | Folge |
|---|---|---|
| **Throw it off and get up** | Segment verfällt | Nichts weiter. |
| **Go back to sleep** | — | Rest der Nacht garantiert ruhig. Am Morgen fehlt ein zufälliger Gegenstand — er **taucht 2–4 Tage später in einem anderen Raum wieder auf**, ordentlich hingelegt. |

---

### N-W-13 · Something Under the Floor
**Wake** · Gewicht 3 · ab Tag 5 · nur Erdgeschoss oder Keller

> *Under the boards, something shifts its weight. It is not scratching. It is making
> itself comfortable.*

| Option | Kosten | Folge |
|---|---|---|
| **Pry up a board** | Segment verfällt · crowbar | 35 % Fragment · 25 % Fund · 40 % *Injured*. Der Raum verliert **dauerhaft 1 SAFETY**. |
| **Move your bedding** | Segment verfällt | Ereignis endet. |
| **Ignore it** | ENERGY −1 | 30 % es wiederholt sich in diesem Raum jede weitere Nacht |

---

### N-W-14 · The Trip Line
**Wake** · kein Gewicht — **wird ausgelöst statt eines Damage-, Theft- oder Mark-Ereignisses**, wenn `trip_line` im Raum steht

> *The cans go off. Whatever it was, it is on the other side of the door now,
> and it knows you are awake.*

| Option | Kosten | Folge |
|---|---|---|
| **Hold the door** | Segment verfällt | Es gibt auf. Nichts geht verloren, nichts geht kaputt. |
| **Reinforce it now** | Segment verfällt · 2 boards, 4 nails | SAFETY 3, Rest der Nacht garantiert ruhig. |
| **Run to another room** | Segment verfällt | Du bist sicher — aber alles, was im alten Raum lag, ist am Morgen durchwühlt: 1 zufälliges Item weg. |

Die Stolperschnur ist danach **zerstört** und muss neu gebaut werden. Sie löst auch
bei harmlosen Ereignissen aus: dann kostet sie ein Segment für nichts.

---

## A2 · SOUND — nur Geräusch

8 Ereignisse. Gleiches Gewicht (3), ab Tag 1, immer dieselbe Folge:
**ENERGY −1**, sonst nichts. Sie sind der Grund, warum das Haus nie leer wirkt.

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

---

## A3 · DAMAGE — es kostet dich Material

6 Ereignisse · ab Tag 3 · **höchstens eines pro Nacht** · werden im Night Report aufgelöst.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-D-01** | 4 | *There are marks on the boards. Not deep. Methodical, like someone testing where the wood is thinnest.* | Barrikade des Schlafraums **−1 Stufe** |
| **N-D-02** | 3 | *The fuse has blown. The box is warm.* | Eine gesteckte Sicherung ist **zerstört**, der Raum fällt auf LIGHT 0 |
| **N-D-03** | 3 | *Two of the jars have burst. The shelf is wet and the cellar smells sweet.* | **2 × `preserves`** weg |
| **N-D-04** | 2 | *The window in the next room has cracked from corner to corner. Nothing hit it.* | Ein zufälliger Nachbarraum kann **nie über SAFETY 2** hinaus |
| **N-D-05** | 3 | *Water came through the ceiling in the night.* | Ein zufälliges Item im Lager ruiniert: Streichhölzer, Notiz, Batterie oder Samen |
| **N-D-06** | 2 | *The bread has gone. Not eaten — gone the way bread goes in a month, in one night.* | **Alle verderblichen Lebensmittel** sofort verdorben |

---

## A4 · THEFT — etwas fehlt

5 Ereignisse · ab Tag 3 · **höchstens eines pro Nacht**.
Der Spieler merkt manchmal erst später, was fehlt — das ist Absicht.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-T-01** | 4 | *One tin is missing. You counted them last night. You counted them twice.* | **1 Konserve** weg |
| **N-T-02** | 3 | *The hammer is not where you left it.* | Hammer weg — **taucht 1–3 Tage später in einem anderen Raum auf** |
| **N-T-03** | 3 | *The batteries are flat. All of them. You have not used the flashlight since yesterday.* | **Alle Batterien im Lager** verloren |
| **N-T-04** | 3 | *The matches are damp. The box has been sitting in something.* | **1 Schachtel Streichhölzer** weg |
| **N-T-05** | 1 | *A page in your notebook has run. The ink is smeared edge to edge and the paper is damp. You remember writing it. You do not remember what it said.* | **Ein Fragment wird unleserlich** — zählt nicht mehr, ist aber am ursprünglichen Fundort wieder aufsammelbar. Trifft nie das letzte Fragment einer Frage. |

---

## A5 · MARK — du wachst verändert auf

4 Ereignisse · ab Tag 2 · **höchstens eines pro Nacht**.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-M-01** | 4 | *There are four thin scratches along your forearm. They are evenly spaced and they do not hurt yet.* | *Injured* |
| **N-M-02** | 3 | *You are burning up. The room is cold and you are soaked through.* | *Sick* |
| **N-M-03** | 3 | *You wake up already sitting, already shouting, and you do not know at what.* | *Shaken* · **Nacht endet** |
| **N-M-04** | 2 | *Your hand has been bandaged. Neatly, properly, with a knot you do not tie.* | *Injured* wird geheilt **ohne Verbandsmaterial** — dafür *Shaken*. Zieht nur, wenn du *Injured* bist. |

---

## A6 · MOVE — du wachst woanders auf

3 Ereignisse · ab Tag 5 · seltene Kategorie, dafür einprägsam.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-V-01** | 3 | *You wake in the upstairs hall. Your shoes are beside you, set side by side.* | Neuer Raum. Getragene Gegenstände bleiben bei dir. Nacht endet. |
| **N-V-02** | 2 | *You wake in front of the door. Your hand is on the handle. It is still locked.* | Entrance Hall. Nacht endet, **ENERGY morgen: 1**. |
| **N-V-03** | 2 | *You wake in the cellar. There is no light and you do not remember the stairs.* | Cellar bei LIGHT 0. Alle getragenen Gegenstände liegen im alten Raum. Nacht endet. |

---

## A7 · CLUE — das Haus gibt dir etwas

5 Ereignisse · ab Tag 2.

| ID | Gewicht | Text | Folge |
|---|---|---|---|
| **N-C-01** | 4 | *There is writing on the last page of your notebook. It is your handwriting. It is not your sentence.* | **1 Fragment** |
| **N-C-02** | 2 | *You dreamed about a room in this house. You have not been in it yet. You know where the door is.* | Deckt einen noch nicht entdeckten Raum auf der Karte auf |
| **N-C-03** | 3 | *A word has been written in the dust on the floor. It is a name, or half of one.* | **1 Fragment** |
| **N-C-04** | 3 | *You remember something clearly that you know you did not do.* | **1 Fragment** |
| **N-C-05** | 2 | *There is a note under the door. The paper is old. The ink is not.* | **1 Fragment** + das `note_*`-Item bleibt liegen |

---

# TEIL B · TAG-DECK

10 % aller Ereignisse. 4 % Chance pro Raumwechsel. Meist harmlos —
sie halten den Tag unbehaglich, ohne ihn gefährlich zu machen.

## B1 · AMBIENT — folgenlos

6 Ereignisse · Gewicht je 3 · ab Tag 1 · **keine Kosten, keine Folgen.**

| ID | Text |
|---|---|
| **D-A-01** | *The picture in the hall is crooked. You straighten it. Later, it is crooked again.* |
| **D-A-02** | *There are footprints in the dust. Your size. Facing the other way.* |
| **D-A-03** | *The hall clock is running. It was not running yesterday and there is no key for it.* |
| **D-A-04** | *The seat of the armchair is warm.* |
| **D-A-05** | *Every door upstairs is open. You closed them all this morning.* |
| **D-A-06** | *You can hear yourself moving around upstairs.* |

## B2 · SUPPLY — Funde

5 Ereignisse · ab Tag 1 · **Gewicht ×3, wenn FOOD unter 25** (die leise Hilfe).

| ID | Gewicht | Text | Fund |
|---|---|---|---|
| **D-S-01** | 4 | *Something has rolled behind the dresser and been there a long time.* | 1–2 Konserven |
| **D-S-02** | 3 | *There is a box of matches in the coat by the door. The coat is not yours.* | 1 Schachtel Streichhölzer |
| **D-S-03** | 3 | *A toolbox under the workbench, closed with a latch that still works.* | 1 × `nails` + 1 zufälliges Werkzeug |
| **D-S-04** | 3 | *A drawer of candle stubs. Household candles, kept for power cuts.* | 3–4 Kerzen |
| **D-S-05** | 2 | *Somebody kept a bag packed by the back door.* | 1 × `bandage`, 1 Konserve, 1 Batterie |

---

# TEIL C · RADIO UND TELEFON

## C1 · Das Radio — die einzige Vorwarnung auf die Rettung

Im Salon. **1 Handlung** pro Hörvorgang, einmal am Tag möglich.
Die Meldungen tasten sich über die zwanzig Tage heran. **Es wird nie ein Datum genannt.**

| ID | Ab Tag | Meldung |
|---|---|---|
| **R-01** | 1 | *"…scattered showers through the county, clearing towards the weekend…"* — nichts. |
| **R-02** | 3 | *"…police are asking motorists to avoid the old county road following an incident…"* |
| **R-03** | 5 | *"…a vehicle was recovered abandoned near the Ashgrove turning. The owner has not been traced…"* |
| **R-04** | 8 | *"…now being treated as a missing person enquiry…"* |
| **R-05** | 11 | *"…the search has been scaled back after almost two weeks without…"* — dann Rauschen. |
| **R-06** | 14 | *"…following new information, officers will begin searching properties on the estate itself…"* |
| **R-07** | 17 | Kein Wortlaut mehr — man hört einen Hubschrauber. Weit weg, aber echt. |
| **R-08** | 19 | Fahrzeuge auf dem Kiesweg. Motoren, die abgestellt werden. Dann nichts mehr. |
| **R-09** | 20 | Stimmen draußen. Mehrere. Sie rufen. |

**R-05 an Tag 11 ist der wichtigste Eintrag:** Die Suche wird eingestellt. Wer nur
auf die Rettung gesetzt hat, bekommt hier die Nachricht, dass es vorbei ist — und
muss drei Tage weitermachen, bevor R-06 zeigt, dass es doch nicht vorbei war.
Das ist der Tiefpunkt der Kurve, und er ist mit Absicht dort.

**Ab Tag 12** liest das Radio mit 20 % Chance stattdessen **Namen vor** — Vermisste,
sachlich verlesen. Folge: *Shaken*, aber garantiert ein Fragment. Ob einer der Namen
deiner ist, wird nie geklärt; die Figur hat keinen.

## C2 · Das Telefon

Im Arbeitszimmer. Die Leitung ist tot. Das hält es nicht davon ab zu klingeln.

### C-P-01 · The Telephone Rings
**Wake oder Tag** · Gewicht 2 · ab Tag 3

> *The telephone in the study is ringing. The line was cut before you got here.
> You checked.*

| Option | Kosten | Folge |
|---|---|---|
| **Answer it** | tagsüber 1 Handlung, nachts Segment verfällt | 35 % Fragment · 35 % Stille und ein Atmen (*Shaken*) · 30 % ein Freizeichen |
| **Let it ring** | nachts ENERGY −1 | Es klingelt vierzig Mal. Dann nicht mehr. |

### C-P-02 · The Number You Know
**Tag** · Gewicht 1 · ab Tag 8 · nur wenn C-P-01 schon einmal gezogen wurde · Einmal

> *You pick up the receiver and dial a number you have known your whole life.
> Somewhere else in the house, a telephone starts ringing.*

| Option | Kosten | Folge |
|---|---|---|
| **Go and find it** | 1 Handlung | Führt in einen bestimmten Raum. **Garantiertes Fragment.** 30 % *Shaken*. |
| **Put the receiver down** | — | Das Klingeln hört sofort auf. |

---

# TEIL D · ZUSAMMENSTELLUNG

| Deck | Einträge | Anteil an einer Nacht-Ziehung |
|---|---|---|
| Wake | 14 | 25 % |
| Sound | 8 | 25 % |
| Damage | 6 | 15 % |
| Theft | 5 | 10 % |
| Mark | 4 | 10 % |
| Clue | 5 | 10 % |
| Move | 3 | 5 % |
| **Nacht gesamt** | **45** | |
| Ambient (Tag) | 6 | |
| Supply (Tag) | 5 | |
| Radio | 9 | |
| Telefon | 2 | |
| **Gesamt** | **67 Einträge** | |

**Wie viele ein Durchlauf zieht:** 20 Tage × durchschnittlich 2 Segmente × ~35 %
Trefferquote ≈ **14 Nachtereignisse**, dazu ~4 am Tag und die Radio-Staffel.

Mit 45 Nachtereignissen sieht ein Spieler also **etwa ein Drittel** pro Durchlauf.
Beim zweiten Mal ist das meiste noch neu. **Das Deck ist damit groß genug** —
das war bei der alten 50-Tage-Länge nicht der Fall.

Für mehr Abwechslung wäre die nächste Ausbaustufe: **Wake auf 20** und
**Sound auf 12** bringen. Alles andere kann bleiben.

---

# TEIL E · OFFENE FRAGEN

1. **N-W-12 "Tucked In"** — die Option "weiterschlafen" tauscht eine ruhige Nacht
   gegen einen Gegenstand, der später wieder auftaucht. Mechanisch fair, erzählerisch hart.
2. **N-W-04 "The Weight", Option "Reach out"** — 50 % Fragment für 50 % *Shaken*
   ist die beste Quote im ganzen Deck. Zu großzügig?
3. **N-V-02 "You wake in front of the door"** — ENERGY 1 am nächsten Morgen ist
   sehr hart, weil ein Tag praktisch verloren ist. Auf 2 anheben?
4. **Sound-Ereignisse** — aktuell kostet jedes ENERGY −1. Bei drei Segmenten in einer
   Nacht könnten das −3 sein, ohne dass etwas passiert ist. Deckeln bei −1 pro Nacht?
