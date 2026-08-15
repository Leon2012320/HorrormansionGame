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

Konzeptphase, Version 0.5. Noch kein Code.

## Sechs Handlungen am Tag

Es gibt **keine Uhr und keine Minuten.** Ein Tag besteht aus einer festen Zahl
Handlungen — meistens sechs. Laufen, ansehen und lesen sind kostenlos; suchen, bauen,
kochen und pflanzen kosten. Wie viele du hast, hängt davon ab, wie du geschlafen hast.

Ein Durchlauf geht über **20 Tage** und dauert **60–80 Minuten**.

## Die vier Achsen

- **ENERGY** — deine Handlungen heute, berechnet aus der letzten Nacht
- **FOOD** — endlich; und arbeiten macht hungrig
- **LIGHT** — Taschenlampe, Kerze oder Deckenlicht; das Haus hat drei Sicherungen
- **SAFETY** — Türen, Möbel, Bretter. Barrikaden halten nicht.

## Der Rhythmus

**Tagsüber passiert fast nichts. 90 % aller Ereignisse passieren, während du schläfst** —
und schlafen musst du, sonst hast du morgen nichts zu tun. Der Tag ist Vorbereitung,
die Nacht ist die Prüfung, der Morgen ist die Rechnung.

Es gibt **kein Monster mit Wegfindung und keine Bedrohungsanzeige.** Kein Ereignis
tötet dich direkt — es gibt dir einen Zustand, und der bringt dich um, wenn du ihn
ignorierst. **Tod ist endgültig, es wird nicht gespeichert.**

## Zwei Wege raus

- **THE DOOR** — herausfinden, was das Haus verlangt, und selbst gehen. Ab Tag 8
  möglich, ein guter Durchlauf endet um Tag 10–14. Der gedachte Normalweg.
- **RESCUE** — durchhalten bis Tag 20. Der Tag wird dir nie genannt, das Radio ist
  die einzige Vorwarnung. Der Ausdauerweg.

Im Haus liegen Vorräte für **zwölf von zwanzig Tagen**. Der Geheimnisweg geht knapp
ohne Anbau auf, der Rettungsweg nicht.

**Aufgelöst wird nichts.** Du erfährst, *was* zu tun ist, nie *warum*.
