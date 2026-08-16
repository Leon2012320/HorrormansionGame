# Texturliste — ASHGROVE

**Version 0.7** — was der Code tatsächlich lädt, in der Reihenfolge, in der es
sich lohnt zu zeichnen.

> **Wichtig:** Das Spiel ist nicht wegen fehlender Texturen dunkel gewesen, sondern
> wegen zweier Fehler (Raumansicht ohne Größe, zu starke Abdunklung). Beides ist
> behoben. Die Platzhalter sind alle vorhanden und funktionieren — du kannst sie
> Stück für Stück ersetzen, das Spiel läuft dazwischen jederzeit.

---

## Technische Vorgaben

| Punkt | Vorgabe |
|---|---|
| **Format** | PNG mit Transparenz (RGBA) |
| **Pixel-Art-Regel** | **Kein Anti-Aliasing**, keine weichen Kanten, keine halbtransparenten Ränder |
| **Benennung** | Exakt wie in den Tabellen. Der Code sucht genau diese Dateinamen. |
| **Räume: gleichmäßig ausleuchten** | **Keine Schatten, kein Kerzenschein, keine dunklen Ecken einbauen.** Das Spiel dimmt das Bild je nach Lichtstufe selbst — eingebaute Schatten passen dann nicht zur Taschenlampe. |
| **Räume: nicht zu dunkel malen** | Das Bild wird bei Dunkelheit auf 42 % heruntergerechnet. Male so hell wie ein normal beleuchteter Raum, nicht wie eine Horrorszene. |
| **Freihalten** | Oben 40 px (HUD) und unten 45 px (Leisten) bleiben überdeckt. |

### Palette

- **Basis/Schatten:** dunkles Blaugrün und Braun, **nie reines Schwarz**
- **Mitteltöne:** entsättigtes Holzbraun, Staubgrau, verblasstes Tapetengrün
- **Genau zwei Akzente:** warmes Glühbirnengelb (Sicherheit) und stumpfes Rot (Gefahr)
- Alles andere entsättigt. Wenn Farbe auftaucht, soll sie etwas bedeuten.

---

# Stufe 1 · Die 13 Raumbilder

**Das ist mit Abstand das Wichtigste.** Ein Raumbild füllt den ganzen Bildschirm,
die Icons sind 32 Pixel groß. Wenn du nur eine Sache zeichnest, dann diese.

**Pfad:** `assets/rooms/room_<id>.png` · **Größe:** `640 × 360` · jeweils **eine** Datei

| # | Datei | Raum | Was drauf muss |
|---|---|---|---|
| 1 | `room_entrance.png` | Entrance Hall | Haustür (Mitte), Garderobe (links), Beistelltisch (rechts), Treppe |
| 2 | `room_kitchen.png` | Kitchen | Speisekammertür (links), Herd (Mitte), Spüle mit Schubladen (rechts), Kellertür |
| 3 | `room_bedroom.png` | Bedroom | Bett (links), Kleiderschrank (rechts), Fenster |
| 4 | `room_library.png` | Library | Große Bücherwand (links), Lesepult (Mitte), Fenster |
| 5 | `room_cellar.png` | Cellar | **Sicherungskasten** (links oben), Einmachregale (Mitte), Kohlenlager (rechts) |
| 6 | `room_parlor.png` | Parlor | Radio (links), schweres Sofa (Mitte), Vitrine (rechts) |
| 7 | `room_dining.png` | Dining Room | Anrichte mit Kerzen (links), langer Tisch (Mitte) |
| 8 | `room_conservatory.png` | Conservatory | Zwei Beete (links unten), große Glasfront (rechts), Pflanztisch |
| 9 | `room_upper_landing.png` | Upper Landing | Vier Türen, Wäschetruhe (Mitte), Geländer |
| 10 | `room_study.png` | Study | Wandsafe (links), Schreibtisch (Mitte), **Telefon** (rechts) |
| 11 | `room_bathroom.png` | Bathroom | Spiegelschrank (Mitte oben), Wanne (rechts) |
| 12 | `room_attic.png` | Attic | Werkbank (links), Bretterstapel (Mitte), Koffer (rechts) |
| 13 | `room_nursery.png` | Nursery | Kinderbett (links), Spielzeugkiste (rechts) |

**Die Platzhalter sind deine Vorlage.** In jedem steht der Raumname, die Dateigröße
und — das Wichtigste — die **Hotspot-Rechtecke an ihren echten Positionen**, mit Namen
und Maßen beschriftet. Male die Möbel genau dorthin, dann sitzen die Klickflächen richtig.

Willst du ein Möbelstück woanders haben: die Rechtecke stehen in
`content/rooms_db.gd` unter `"rect": [x, y, breite, höhe]`. Sag mir Bescheid oder
ändere sie selbst, dann passe ich die Platzhalter an.

**Wenn du klein anfangen willst:** Zeichne zuerst `room_kitchen.png`. Daran sehe
ich Palette, Perspektive und Detailtiefe und kann alles Weitere danach ausrichten.

---

# Stufe 2 · Die 20 wichtigsten Gegenstände

**Pfad:** `assets/items/<id>.png` · **Größe:** `32 × 32`

Werden in der Inventarleiste unten rechts angezeigt. Sortiert danach, wie oft sie
im Spiel vorkommen — die oberen siehst du in jedem Durchlauf, die unteren selten.

| Datei | Gegenstand | Warum wichtig |
|---|---|---|
| `board.png` | Wooden board | **Das häufigste Item im Spiel.** Löst sechs von sechzehn Problemen. |
| `candle.png` | Candle | Zweitwichtigste Ressource, Licht in jedem Raum |
| `hammer.png` | Hammer | Werkzeug für alles Vernageln |
| `matches.png` | Box of matches | Zu jeder Kerze gehört eins |
| `crowbar.png` | Crowbar | Löst vier Probleme, öffnet Türen |
| `nails.png` | Box of nails | Gehört zu jeder Barrikade |
| `whiskey.png` | Bottle of whiskey | Löst drei Probleme |
| `fuse.png` | Fuse | Der Sicherungskasten |
| `trap.png` | Snare | Selbstgebaute Falle |
| `trip_line.png` | Trip line | Dosen an einer Schnur |
| `can_beans.png` | Tin of beans | Häufigste Nahrung |
| `can_meat.png` | Tin of meat | |
| `preserves.png` | Jar of preserves | Einmachglas |
| `bandage.png` | First aid tin | Blechdose mit Verbandszeug |
| `pills.png` | Bottle of pills | Tablettenröhrchen |
| `blanket.png` | Wool blanket | Wolldecke |
| `rag.png` | Oily rag | Öliger Lappen |
| `battery.png` | Battery | 1960er-Rundzelle |
| `flashlight.png` | Flashlight | Deine Taschenlampe, Startausrüstung |
| `lamp_oil.png` | Can of lamp oil | Ölkanne |

---

# Stufe 3 · Die restlichen Gegenstände

Kommen seltener vor. Bis dahin zeigt die Leiste ein Kürzel — spielbar bleibt alles.

| Gruppe | Dateien |
|---|---|
| Licht | `lantern.png` · `bulb.png` · `torch.png` |
| Werkzeug | `screwdriver.png` · `rope.png` · `wire.png` · `can_empty.png` |
| Essen | `can_soup.png` · `bread.png` · `apples.png` · `chocolate.png` · `water_bottle.png` · `meal_hot.png` · `crop_ripe.png` · `catch_raw.png` · `food_spoiled.png` |
| Anbau | `seeds.png` · `watering_can.png` |
| Schlüssel | `key_cellar.png` · `key_study.png` · `key_attic.png` |
| Rückgabe-Gegenstände | `ring.png` · `doll.png` · `locket.png` · `pocket_watch.png` |
| Hinweise (12 Stück) | `note_ledger.png` · `note_letter_a.png` · `note_marks.png` · `note_receipt.png` · `note_floorplan.png` · `note_damp.png` · `photo_family.png` · `photo_wrong.png` · `note_inventory.png` · `note_deed.png` · `note_marker.png` · `book_page.png` |

**Zu den Hinweisen:** Die zwölf reichen als **drei Sorten** — ein gefaltetes Blatt,
ein Foto, ein Buchausschnitt. Für alle zwölf eigene Grafiken zu zeichnen lohnt
sich erst spät, weil sie keinen Inventarplatz belegen und nur kurz aufblitzen.

---

# Was du NICHT zeichnen musst

Das spart dir mehr Arbeit als alles andere:

| | Warum nicht |
|---|---|
| **UI-Rahmen, Knöpfe, Leisten, Anzeigen** | Alles im Code gezeichnet. Braucht keine Grafik. |
| **Schrift** | Godots eingebaute Schrift. Ein Pixel-Font wäre schöner, ist aber optional. |
| **Lichtmasken, Vignette, Filmkorn** | Werden aktuell nicht verwendet — Licht läuft über eine Farbtönung des ganzen Bildes. |
| **Monster, Erscheinungen, Silhouetten** | Es gibt keine. Die Bedrohung ist Text, nie ein Bild. |
| **Hell- und Dunkelvarianten der Räume** | Eine Datei pro Raum genügt, das Dimmen macht die Engine. |
| **Sonder-Item-Icons** | Sie belegen keinen Inventarplatz und erscheinen nur im Menü als Text. |
| **Die 16 Sonder-Items als Bilder** | Später mal schön, jetzt unsichtbar. |

---

# Zusammenfassung

| Stufe | Anzahl | Größe | Aufwand |
|---|---|---|---|
| **1 · Räume** | **13** | 640 × 360 | Der eigentliche Look des Spiels |
| **2 · Häufige Gegenstände** | **20** | 32 × 32 | Kleine Icons, schnell gemacht |
| **3 · Restliche Gegenstände** | ~35 | 32 × 32 | Kann warten |

**Minimum für ein Spiel, das gut aussieht: die 13 Raumbilder.**

---

# Austauschen

1. Zeichne die Datei in der angegebenen Größe.
2. Lege sie über den Platzhalter — gleicher Pfad, gleicher Name.
3. Godot importiert sie beim nächsten Start automatisch.

Am Code ändert sich nichts. Platzhalter neu erzeugen (falls du sie überschrieben
hast und die Vorlage zurückwillst):

```bash
python3 tools/make_placeholders.py
```

Das Skript liest die Hotspot-Positionen direkt aus `content/rooms_db.gd` und
bleibt damit automatisch synchron.

## Ton

Kommt später — bisher spielt das Spiel keinen Ton ab. Wenn es soweit ist,
ist Ton bei diesem Konzept wichtiger als Grafik, weil die ganze Bedrohung
unsichtbar ist. Die Liste dafür mache ich, sobald die Wiedergabe eingebaut ist.
