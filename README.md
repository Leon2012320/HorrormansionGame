# Horror Mansion Game (Arbeitstitel: ASHGROVE)

2D-Horror-Survival in einer alten Villa. **Godot 4**, ein festes Bild pro Raum,
Point & Click. Setting Anfang der 1960er, Spieltexte auf Englisch.

**Du bist nachts vor etwas weggelaufen und in das erstbeste Haus geflüchtet.
Die Tür ist hinter dir zugefallen. Sie geht nicht mehr auf.**

---

## Starten

Godot 4.3 oder neuer, Projektordner öffnen, F5.

```bash
godot --path .                          # spielen
godot --headless tools/smoke_test.tscn  # 40 Durchläufe automatisch durchspielen
python3 tools/make_placeholders.py      # Platzhalter-Grafiken neu erzeugen
```

## Aufbau

```
src/autoload/     Spiellogik — game_state · rooms · inventory · notebook
                  garden · event_deck · day_cycle
src/ui/           Oberfläche, im Code gebaut
src/scenes/       main.tscn ist der Einstieg
content/          DIE INHALTE: rooms_db · items_db · events_db
assets/           Grafik (Platzhalter, zum Übermalen)
tools/            Platzhalter-Generator und Smoke-Test
docs/             Konzept
```

**Inhalte anlegen geht ohne Code.** Ein neuer Raum ist ein Eintrag in
`content/rooms_db.gd` plus ein 640×360-PNG. Ein neues Ereignis ist ein Eintrag
in `content/events_db.gd`. Mehr nicht.

## Grafiken austauschen

Die Platzhalter zeigen die Hotspot-Rechtecke an ihren echten Positionen — sie sind
also gleichzeitig Malvorlage. Echte Grafik einfach drüberlegen: gleicher Pfad,
gleicher Name, gleiche Größe. Am Code ändert sich nichts.

**Räume bitte gleichmäßig ausgeleuchtet zeichnen, ohne Schatten** — Dunkelheit und
Lampenschein legt die Engine als Tönung darüber. Details in
[`docs/ASSET_PLAN.md`](docs/ASSET_PLAN.md).

---

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
und schlafen musst du, sonst hast du morgen nichts zu tun.

Es gibt **kein Monster mit Wegfindung und keine Bedrohungsanzeige.** Kein Ereignis
tötet dich direkt — es gibt dir einen Zustand, und der bringt dich um, wenn du ihn
ignorierst. **Tod ist endgültig, es wird nicht gespeichert.**

## Zwei Wege raus

- **THE DOOR** — herausfinden, was das Haus verlangt, und selbst gehen. Ab Tag 8
  möglich, ein guter Durchlauf endet um Tag 10–14. Der gedachte Normalweg.
- **RESCUE** — durchhalten bis Tag 20. Das Radio ist die einzige Vorwarnung.

**Aufgelöst wird nichts.** Du erfährst, *was* zu tun ist, nie *warum*.

---

## Dokumente

| Datei | Inhalt |
|---|---|
| [`docs/DECISIONS.md`](docs/DECISIONS.md) | **Alle Festlegungen in einer Tabelle — hier anfangen** |
| [`docs/GAME_DESIGN.md`](docs/GAME_DESIGN.md) | Spielkonzept, Mechaniken, Raumplan, Roadmap |
| [`docs/ITEMS.md`](docs/ITEMS.md) | Gegenstände mit Werten, Fundorten und Mengen |
| [`docs/SPECIAL_ITEMS.md`](docs/SPECIAL_ITEMS.md) | 16 einmalige Fundstücke, fünf pro Durchlauf |
| [`docs/EVENTS.md`](docs/EVENTS.md) | Jedes Ereignis vollständig ausgeschrieben |
| [`docs/ASSET_PLAN.md`](docs/ASSET_PLAN.md) | Grafik- und Tonliste mit Größen und Dateinamen |

## Stand

Spielbares Gerüst: 13 Räume, Tagesablauf, Schlafsystem mit Ereignissen, Notizbuch,
Sicherungskasten, Anbau, alle fünf Enden. Grafik durchgehend Platzhalter.

Der Smoke-Test spielt 40 Durchläufe headless durch: Schnitt 17 Tage, 27 erreichen
die Rettung. Die Balancing-Zahlen im Konzept sind damit gemessen, nicht geschätzt.
