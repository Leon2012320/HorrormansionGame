# Horror Mansion Game (Arbeitstitel: ASHGROVE)

2D-Horror-Survival in einer alten Villa. Godot 4, Raum-für-Raum-Standbilder,
Point & Click. Setting Anfang der 1960er, Spieltexte auf Englisch.

**Du bist nachts vor etwas weggelaufen und in das erstbeste Haus geflüchtet.
Die Tür ist hinter dir zugefallen. Sie geht nicht mehr auf. Und du weißt nicht,
wie lange du hier drin sein wirst.**

## Dokumente

| Datei | Inhalt |
|---|---|
| [`docs/GAME_DESIGN.md`](docs/GAME_DESIGN.md) | Spielkonzept, Mechaniken, Raumplan, Roadmap |
| [`docs/ASSET_PLAN.md`](docs/ASSET_PLAN.md) | Asset-Liste mit Größen, Dateinamen und Prioritäten |

## Stand

Konzeptphase, Version 0.2. Noch kein Code.

## Die vier Achsen

Das ganze Spiel hängt an vier Dingen — mehr gibt es nicht:

- **FOOD** — Essen ist endlich und du musst dafür raus aus dem sicheren Raum
- **REST** — du musst schlafen, aber im Schlaf kannst du nicht reagieren
- **LIGHT** — Taschenlampe, Kerze oder Deckenlicht; das Haus hat nur drei Sicherungen
- **SAFETY** — Türen, Möbel, Bretter. Barrikaden halten nicht ewig.

Es gibt **kein Monster mit Wegfindung und keine Bedrohungsanzeige.** Alles, was dir
zustößt, kommt aus dem Ereignis-System — meistens als Entscheidung ohne gute Antwort.

Kein Ereignis tötet dich direkt. Es gibt dir einen Zustand, und der bringt dich um,
wenn du ihn ignorierst. Tod ist endgültig.

Ziel ist nicht Durchhalten, sondern **Rauskommen** — und die Tür geht erst auf,
wenn du verstanden hast, warum sie zu ist.
