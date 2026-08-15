# Ereignisse — ASHGROVE

45 ausgeschriebene Ereignisse. Texte sind **Englisch** (Spielsprache), die Erklärungen
drumherum deutsch. Jedes wird später eine `.tres`-Datei unter `content/events/`.

---

## Schreibregeln — bitte bei jedem neuen Ereignis einhalten

1. **Nie ein Wesen benennen.** Kein "it", das ein Körper ist. Keine Gestalt, kein
   Gesicht, kein Name. Nur **Wirkungen**: eine offene Tür, ein warmer Stuhl, ein fehlendes Glas.
2. **Nie erklären.** Kein Ereignis darf eine Ursache nennen. Das Spiel löst nichts auf.
3. **Alltäglich, dann falsch.** Der Schrecken kommt aus der kleinen Abweichung, nicht
   aus dem großen Bild. Ein Stuhl, der umgestellt wurde, wirkt stärker als eine Erscheinung.
4. **Kurz.** Zwei bis drei Sätze. Präsens, zweite Person.
5. **Keine Option darf offensichtlich die beste sein.** Wenn doch, ist das Ereignis kaputt.
6. **Kein Ereignis tötet.** Es gibt Zustände, und Zustände töten, wenn man sie ignoriert.

**Formatlegende:** `weight` = relatives Gewicht im Deck · `day ≥ n` = erst ab Tag n ·
Bedingungen beziehen sich auf den Raum, in dem geschlafen wird.

---

# TEIL A — Nacht-Deck (90 % aller Ereignisse)

## A1 · WAKE — du wachst auf und musst entscheiden

Die wichtigste Kategorie. Hier trifft der Spieler seine echten Entscheidungen.

---

#### N-W-01 · The Chair
`weight 4` · `day ≥ 2` · `SAFETY ≤ 2`

> You wake because the room is wrong. The chair from the corner is at the foot of the
> bed now, turned to face you.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Put it back** | 10 min, REST −5 | Nichts weiter. |
| **Leave it. Don't look at it again.** | — | Kein Schlafbonus mehr diese Nacht (REST-Gewinn halbiert). |
| **Sit in it** | 15 min | 25 % Fragment · 25 % *Shaken* · 50 % nichts |

---

#### N-W-02 · The Door You Locked
`weight 5` · `SAFETY ≥ 1`

> The door is open. Not forced — opened. The chair you wedged under the handle has
> been set neatly against the wall.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Close it and go back to sleep** | 5 min | 50 % das Ereignis wiederholt sich in dieser Nacht |
| **Barricade it properly** | 30 min, 2 boards, 4 nails, hammer | SAFETY 3, Rest der Nacht garantiert ruhig |
| **Sleep in another room** | 20 min | Neuer Raum, neue Werte. Deine Vorräte bleiben hier. |
| **Stay awake until morning** | Rest der Nacht | REST steigt nicht mehr, aber nichts passiert |

---

#### N-W-03 · Breathing
`weight 4` · `LIGHT ≤ 1`

> Someone in the room is breathing. Slow, even, patient. When you hold your breath
> to listen, so do they.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Turn on the flashlight** | 1 battery | Der Raum ist leer. LIGHT 1 für eine Stunde, Ereignischance sinkt. |
| **Light a candle** | 1 candle, 1 match, 5 min | LIGHT 2 für 4 Stunden. Sicherste Antwort — und teuer. |
| **Lie still and wait** | REST −15 | 60 % es hört auf · 40 % *Shaken* |

---

#### N-W-04 · The Weight
`weight 3` · `day ≥ 4` · `Bett im Raum`

> The mattress dips beside you. Not much. Just the weight of someone sitting down
> on the edge, careful not to wake you.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Don't move** | REST −20 | Nach zwanzig Minuten hebt sich die Matratze wieder. Nichts weiter. |
| **Get up** | 10 min | 40 % Fragment · 40 % nichts · 20 % *Shaken* |
| **Reach out** | — | 50 % Fragment · 50 % *Shaken*. Der Text sagt nicht, was du berührst. |

---

#### N-W-05 · Three Knocks
`weight 4` · `SAFETY ≥ 2`

> Three knocks on the boards. Polite. A pause exactly long enough to be an answer.
> Then three more.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Knock back** | — | 30 % Fragment · 30 % nichts · 40 % das Klopfen kommt bis zum Morgen wieder (REST −25) |
| **Say nothing** | REST −10 | Nach vier Runden hört es auf. |
| **Check the barricade** | 15 min | Du siehst den Schaden früh: Barrikade verliert nur 1 Stufe statt 2. |

---

#### N-W-06 · Your Name
`weight 3` · `day ≥ 5`

> Someone downstairs is calling your name. They sound tired. They sound like they
> have been looking for you for a while.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Answer** | — | 20 % Fragment · 30 % *Shaken* · 50 % Stille, für den Rest der Nacht |
| **Go down** | 30 min, LIGHT nötig | 40 % Fragment · 30 % Fund · 30 % *Injured* |
| **Cover your ears** | REST −15 | Es hört irgendwann auf. |

---

#### N-W-07 · The Cold
`weight 3`

> Your breath is showing. The window is shut. It is not that time of year.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Get the blanket** | 10 min | Wenn `blanket` im Lager: Ereignis endet. Sonst: REST −10. |
| **Light the stove / fireplace** | 20 min, 1 match, fuel | Raum bleibt warm bis zum Morgen. Danach FOOD −5 (Anstrengung). |
| **Endure it** | REST −20 | 25 % *Sick* |

---

#### N-W-08 · The Candle
`weight 3` · `Kerze brennt im Raum`

> The candle is out. You put your hand near the wick to feel for heat, and there
> is none. It is long and white and has never been lit.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Light it again** | 1 match | 50 % es geht sofort wieder aus (nochmal ein Streichholz) |
| **Use a different candle** | 1 candle, 1 match | Funktioniert normal. Kostet dich eine Kerze mehr. |
| **Sleep in the dark** | LIGHT 0 für den Rest der Nacht | Ereignischance +12 Punkte pro Stunde |

---

#### N-W-09 · Counting the Stairs
`weight 3` · `day ≥ 3`

> Footsteps on the staircase. You count them without meaning to. The staircase has
> fourteen steps. You are at twenty-one and they are still coming up.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Keep counting** | REST −15 | Bei 40 hört es auf. 35 % Fragment für das Durchhalten. |
| **Block the door** | 15 min | SAFETY +1 für diese Nacht. Die Schritte hören sofort auf. |
| **Open the door and look** | — | 20 % Fragment · 30 % *Shaken* · 50 % ein leeres Treppenhaus |

---

#### N-W-10 · The Smell of Cooking
`weight 2` · `day ≥ 4`

> Something is cooking. It smells like a proper meal, the kind you have not had in
> days. The stove has no power.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Go to the kitchen** | 20 min | 40 %: ein `meal_hot` steht auf dem Tisch. Essen? Eigene Folgefrage. |
| **Stay where you are** | FOOD −10 (der Hunger wird schlimmer) | nichts |

> *Wenn gegessen:* FOOD +55 und ein Fragment. Und *Shaken*.
> *Wenn stehengelassen:* Am nächsten Morgen ist der Teller abgeräumt und abgewaschen.

---

#### N-W-11 · The Window
`weight 3` · `Fenster im Raum`

> The window is open. You did not open it. Outside there is no wind, no sound,
> no insects. It is as if the night is holding still to see what you do.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Close and latch it** | 10 min | Nichts weiter. |
| **Board it up** | 25 min, 1 board, 2 nails | Fenster dauerhaft dicht. SAFETY dieses Raums +1 für immer. |
| **Look out** | — | 30 % Fragment (etwas im Garten) · 30 % *Shaken* · 40 % nichts |

---

#### N-W-12 · Tucked In
`weight 2` · `day ≥ 6`

> The blanket has been pulled up to your chin and folded back. Neatly. The way
> someone does it for a child.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Throw it off and get up** | 15 min, REST −10 | nichts |
| **Go back to sleep** | — | Rest der Nacht garantiert ruhig. **Und am Morgen fehlt ein Gegenstand.** |

---

#### N-W-13 · Something Under the Floor
`weight 3` · `day ≥ 5` · `Erdgeschoss oder Keller`

> Under the boards, something shifts its weight. It is not scratching. It is
> making itself comfortable.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Pry up a board** | 20 min, crowbar | 35 % Fragment · 25 % Fund · 40 % *Injured*. Der Raum verliert 1 SAFETY dauerhaft. |
| **Move your bedding** | 15 min, REST −5 | Ereignis endet. |
| **Ignore it** | REST −15 | 30 % es wiederholt sich jede Nacht in diesem Raum |

---

#### N-W-14 · The Trip Line
`weight —` · **Nur wenn `trip_line` im Raum steht**

> The cans go off. Whatever it was, it is on the other side of the door now,
> and it knows you are awake.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Hold the door** | 20 min, REST −20 | Es gibt auf. Nichts geht verloren, nichts geht kaputt. |
| **Reinforce it now** | 30 min, 2 boards, 4 nails | SAFETY 3, garantiert ruhige Nacht danach. |
| **Run to another room** | 15 min | Sicher — aber alles, was hier liegt, ist am Morgen durchwühlt. |

Die Stolperschnur ist danach zerstört und muss neu gebaut werden.

---

## A2 · SOUND — nur Geräusch, du schläfst weiter

Werden im **Night Report** als Zeile aufgeführt. Kosten immer REST −5, sonst nichts.
Sie sind der Grund, warum das Haus nie leer wirkt.

| ID | Text |
|---|---|
| N-S-01 | *Water running somewhere below. It stops when you notice it.* |
| N-S-02 | *A door closes, two floors down. Then again. Then again, more quietly.* |
| N-S-03 | *Something is dragged across the ceiling, corner to corner, and back.* |
| N-S-04 | *A chair scrapes in the room next to yours. There is no chair in that room.* |
| N-S-05 | *Someone is humming. It is a tune you know, but not from anywhere you can name.* |
| N-S-06 | *The house settles. It settles again. It settles in perfect rhythm, like breathing.* |
| N-S-07 | *A cough. Close. Politely muffled, the way you cough in a room where someone is sleeping.* |
| N-S-08 | *Footsteps on the stairs, going down. They stop halfway and do not continue.* |

---

## A3 · DAMAGE — es kostet dich etwas

`day ≥ 4` · Höchstens eines pro Nacht.

| ID | Text | Folge |
|---|---|---|
| N-D-01 | *There are marks on the boards. Not deep. Methodical, like someone testing where the wood is thinnest.* | Barrikade −1 Stufe |
| N-D-02 | *The fuse has blown. The box is warm.* | 1 Sicherung zerstört, Raum verliert LIGHT 3 |
| N-D-03 | *Two of the jars have burst. The shelf is wet and the cellar smells sweet.* | 2 × `preserves` weg |
| N-D-04 | *The window in the next room has cracked from corner to corner. Nothing hit it.* | Der Raum kann nie über SAFETY 2 hinaus |
| N-D-05 | *Water came through the ceiling in the night.* | Ein zufälliges Item ruiniert (Streichhölzer, Notiz oder Batterie) |
| N-D-06 | *The bread has gone. Not eaten — gone the way bread goes in a month, in one night.* | Alle verderblichen Lebensmittel sofort verdorben |

---

## A4 · THEFT — etwas fehlt

`day ≥ 4` · Der Spieler merkt es manchmal erst später — das ist Absicht.

| ID | Text | Folge |
|---|---|---|
| N-T-01 | *One tin is missing. You counted them last night. You counted them twice.* | 1 Konserve weg |
| N-T-02 | *The hammer is not where you left it.* | Hammer weg — **taucht 1–3 Tage später in einem anderen Raum wieder auf** |
| N-T-03 | *The batteries are flat. All of them. You have not used the flashlight since yesterday.* | Alle Batterien im Lager verloren |
| N-T-04 | *The matches are damp. The box has been sitting in something.* | 1 Schachtel Streichhölzer weg |
| N-T-05 | *A page is missing from your notebook. You remember writing it. You do not remember what it said.* | **Ein bereits gefundenes Fragment wird gelöscht** |

N-T-05 ist das härteste Ereignis im Spiel. Gewicht bewusst niedrig (1), und es kann
nie das letzte Fragment einer Frage treffen.

---

## A5 · MARK — du wachst verändert auf

Höchstens eines pro Nacht.

| ID | Text | Folge |
|---|---|---|
| N-M-01 | *There are four thin scratches along your forearm. They are evenly spaced and they do not hurt yet.* | *Injured* |
| N-M-02 | *You are burning up. The room is cold and you are soaked through.* | *Sick* |
| N-M-03 | *You wake up already sitting, already shouting, and you do not know at what.* | *Shaken*, REST −20 |
| N-M-04 | *Your hand has been bandaged. Neatly, properly, with a knot you do not tie.* | *Injured* geheilt **ohne Verbandsmaterial** — dafür *Shaken* |

---

## A6 · MOVE — du wachst woanders auf

`day ≥ 7` · Selten (Gewicht 1–2), dafür einprägsam.

| ID | Text | Folge |
|---|---|---|
| N-V-01 | *You wake in the upstairs hall. Your shoes are beside you, set side by side.* | Neuer Raum, getragene Items bleiben |
| N-V-02 | *You wake in front of the door. Your hand is on the handle. It is still locked.* | Entrance Hall, REST-Gewinn dieser Nacht gestrichen |
| N-V-03 | *You wake in the cellar. There is no light and you do not remember the stairs.* | Cellar, LIGHT 0, alle getragenen Items liegen im alten Raum |

---

## A7 · CLUE — das Haus gibt dir etwas

| ID | Text | Folge |
|---|---|---|
| N-C-01 | *There is writing on the last page of your notebook. It is your handwriting. It is not your sentence.* | Fragment |
| N-C-02 | *You dreamed about a room in this house. You have not been in it yet. You know where the door is.* | Deckt einen unentdeckten Raum auf der Karte auf |
| N-C-03 | *A word has been written in the dust on the floor. It is a name, or half of one.* | Fragment |
| N-C-04 | *You remember something clearly that you know you did not do.* | Fragment |
| N-C-05 | *There is a note under the door. The paper is old. The ink is not.* | Fragment + `note_*` Item |

---

# TEIL B — Tag-Deck (10 % aller Ereignisse)

Selten, meist harmlos. Sie halten den Tag unbehaglich, ohne ihn gefährlich zu machen.

## B1 · AMBIENT

| ID | Text |
|---|---|
| D-A-01 | *The picture in the hall is crooked. You straighten it. Later, it is crooked again.* |
| D-A-02 | *There are footprints in the dust. Your size. Facing the other way.* |
| D-A-03 | *The hall clock is running. It was not running yesterday and there is no key for it.* |
| D-A-04 | *The seat of the armchair is warm.* |
| D-A-05 | *Every door upstairs is open. You closed them all this morning.* |
| D-A-06 | *You can hear yourself moving around upstairs.* |

## B2 · SUPPLY — Funde

Gewicht **verdreifacht**, wenn FOOD unter 25.

| ID | Text | Fund |
|---|---|---|
| D-S-01 | *Something has rolled behind the dresser and been there a long time.* | 1–2 Konserven |
| D-S-02 | *There is a box of matches in the coat by the door. The coat is not yours.* | 1 Schachtel Streichhölzer |
| D-S-03 | *A toolbox under the workbench, closed with a latch that still works.* | Nägel + 1 Werkzeug |
| D-S-04 | *A drawer of candle stubs. Household candles, kept for power cuts.* | 3–4 Kerzen |
| D-S-05 | *Somebody kept a bag packed by the back door.* | Verbandskasten, 1 Konserve, 1 Batterie |

---

# TEIL C — Radio und Telefon

## C1 · Das Radio — deine einzige Vorwarnung auf die Rettung

Im Salon. Kann einmal pro Tag gehört werden (**20 Minuten**). Die Meldungen werden
mit den Tagen konkreter. **Es wird nie ein Datum genannt** — der Spieler muss selbst
einschätzen, wie nah die Hilfe ist.

| ID | Ab Tag | Meldung |
|---|---|---|
| R-01 | 1 | *"…scattered showers through the county, clearing towards the weekend…"* — nichts. |
| R-02 | 3 | *"…police are asking motorists to avoid the old county road following an incident…"* |
| R-03 | 5 | *"…a vehicle was recovered abandoned near the Ashgrove turning. The owner has not been traced…"* |
| R-04 | 7 | *"…now being treated as a missing person enquiry…"* |
| R-05 | 9 | *"…search teams have been working the woodland at the north end since first light…"* |
| R-06 | 11 | *"…the search has been extended to properties on the estate itself…"* |
| R-07 | 13+ | Kein Wortlaut mehr — man hört einen Hubschrauber, weit weg, aber echt. |
| R-08 | Rettungstag | Stimmen draußen. Mehrere. Sie rufen. |

Ab Tag 10 kann das Radio mit 20 % Chance stattdessen **Namen vorlesen**. Einer davon
ist deiner. Folge: *Shaken*, aber garantiert ein Fragment.

## C2 · Das Telefon (Study)

Die Leitung ist tot. Das hält es nicht davon ab zu klingeln.

#### C-P-01 · The Telephone Rings
`weight 2` · `day ≥ 3` · Tag **oder** Nacht

> The telephone in the study is ringing. The line was cut before you got here.
> You checked.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Answer it** | 5 min | 35 % Fragment · 35 % Stille und ein Atmen (*Shaken*) · 30 % ein Freizeichen |
| **Let it ring** | REST −5 (nachts) | Es klingelt vierzig Mal. Dann nicht mehr. |

#### C-P-02 · The Number You Know
`weight 1` · `day ≥ 8` · Nur wenn das Telefon schon einmal geklingelt hat

> You pick up the receiver and dial a number you have known your whole life.
> Somewhere else in the house, a telephone starts ringing.

| Option | Kosten | Ergebnis |
|---|---|---|
| **Go and find it** | 30 min | Führt in einen bestimmten Raum. Garantiertes Fragment. 30 % *Shaken*. |
| **Put the receiver down** | — | Das Klingeln hört sofort auf. |

---

# TEIL D — Deck-Zusammensetzung

| Deck | Anzahl aktuell | Ziel für Vollversion |
|---|---|---|
| Wake | 14 | 30 |
| Sound | 8 | 20 |
| Damage | 6 | 12 |
| Theft | 5 | 10 |
| Mark | 4 | 8 |
| Move | 3 | 6 |
| Clue (Nacht) | 5 | 12 |
| Ambient (Tag) | 6 | 15 |
| Supply (Tag) | 5 | 12 |
| Radio / Telefon | 10 | 18 |
| **Gesamt** | **66 Einträge / 45 ausgeschriebene Ereignisse** | **~145** |

Für einen Prototyp reichen die hier ausgeschriebenen. Ein Durchlauf von 14 Tagen zieht
etwa 40–50 Ereignisse — mit dieser Menge sieht der Spieler beim ersten Mal fast alles
und beim zweiten Mal zu viel Bekanntes. **Vor der Veröffentlichung muss das Nacht-Deck
auf mindestens 90 Einträge wachsen.** Das ist reine Schreibarbeit, kein Code.

---

# TEIL E · Offene Fragen

1. **N-W-12 "Tucked In"** — die Option "weiterschlafen" ist mechanisch gut
   (ruhige Nacht gegen einen Gegenstand), aber erzählerisch sehr hart. Zu viel?
2. **N-T-05 "The missing page"** — ein gefundenes Fragment zu löschen ist die härteste
   Strafe im Spiel. Drin lassen oder streichen?
3. **N-W-10 "The Smell of Cooking"** — die Mahlzeit zu essen gibt FOOD +55 und ein
   Fragment für *Shaken*. Ist das zu attraktiv? Soll es eine versteckte Langzeitfolge haben?
4. **Radio-Staffel** — soll der Hubschrauber ab Tag 13 auch dann kommen, wenn der
   gewürfelte Rettungstag Tag 18 ist? Aktuell ja, was die Wartezeit besonders zermürbend macht.
