# Horror Mansion Game (Arbeitstitel: ASHGROVE)

2D-Horror-Survival in einer alten Villa. Godot 4, Raum-für-Raum-Standbilder,
Point & Click. Setting Anfang der 1960er, Spieltexte auf Englisch.

**Du bist nachts vor etwas weggelaufen und in das erstbeste Haus geflüchtet.
Die Tür ist hinter dir zugefallen. Sie geht nicht mehr auf. Und du weißt nicht,
wie lange du hier drin sein wirst.**

## Dokumente

| Datei | Inhalt |
|---|---|
| [`docs/DECISIONS.md`](docs/DECISIONS.md) | **Alle Festlegungen in einer Tabelle zum Abnicken — hier anfangen** |
| [`docs/GAME_DESIGN.md`](docs/GAME_DESIGN.md) | Spielkonzept, Mechaniken, Raumplan, Roadmap |
| [`docs/ITEMS.md`](docs/ITEMS.md) | Alle Gegenstände mit Werten, Fundorten und Mengen |
| [`docs/EVENTS.md`](docs/EVENTS.md) | 45 ausgeschriebene Ereignisse mit Text und Konsequenzen |
| [`docs/ASSET_PLAN.md`](docs/ASSET_PLAN.md) | Asset-Liste mit Größen, Dateinamen und Prioritäten |

## Stand

Konzeptphase, Version 0.4. Noch kein Code.

## Die vier Achsen

Das ganze Spiel hängt an vier Dingen — mehr gibt es nicht:

- **FOOD** — Essen ist endlich und du musst dafür raus aus dem sicheren Raum
- **REST** — du musst schlafen, und im Schlaf passiert alles
- **LIGHT** — Taschenlampe, Kerze oder Deckenlicht; das Haus hat nur drei Sicherungen
- **SAFETY** — Türen, Möbel, Bretter. Barrikaden halten nicht ewig.

## Der Rhythmus

**Tagsüber passiert fast nichts. 90 % aller Ereignisse passieren, während du schläfst** —
und schlafen musst du. Der Tag ist Vorbereitung, die Nacht ist die Prüfung, der Morgen
ist die Rechnung.

Es gibt **kein Monster mit Wegfindung und keine Bedrohungsanzeige.** Kein Ereignis
tötet dich direkt — es gibt dir einen Zustand, und der bringt dich um, wenn du ihn
ignorierst. Tod ist endgültig.

## Zwei Wege raus

- **THE DOOR** — herausfinden, was das Haus verlangt, und selbst gehen. Ab Tag 20
  möglich, ein guter Durchlauf endet um Tag 22–28. Der gedachte Normalweg.
- **RESCUE** — durchhalten bis Tag 50. Der Tag wird dir nie genannt, das Radio ist
  die einzige Vorwarnung. Der Ausdauerweg für die, die es wissen wollen.

Im Haus liegen Vorräte für **elf Tage**. Ab etwa Tag 8 musst du im Wintergarten
anbauen und Fallen stellen, sonst verhungerst du — egal wie gut du sonst spielst.

**Aufgelöst wird nichts.** Du erfährst, *was* zu tun ist, nie *warum*.
