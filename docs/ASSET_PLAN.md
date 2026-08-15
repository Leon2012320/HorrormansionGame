# Asset-Plan — ASHGROVE

Alles, was an Grafik und Ton gebraucht wird. **Du zeichnest die echten Sprites,
ich baue nur simple Platzhalter in denselben Maßen** — dadurch kannst du jederzeit
eine Datei austauschen, ohne dass am Code etwas geändert werden muss.

---

## 1. Technische Vorgaben (bitte einhalten, dann passt alles sofort)

| Punkt | Vorgabe |
|---|---|
| **Basis-Auflösung** | 640 × 360 Pixel (16:9). Das Spiel skaliert auf 1280×720 / 1920×1080 hoch. |
| **Format** | PNG mit Transparenz (RGBA), kein JPG |
| **Pixel-Art-Regel** | **Kein Anti-Aliasing**, keine weichen Kanten, keine Halbtransparenz an Rändern |
| **Farbtiefe** | Frei, aber eine gemeinsame Palette (max. ~32 Farben) hält den Look zusammen |
| **Benennung** | klein_mit_unterstrichen, siehe Tabellen unten. Genau so, sonst findet der Code sie nicht. |
| **Animation** | Als horizontaler Sprite-Sheet-Streifen, alle Frames gleich groß |
| **Kein Licht einbauen** | Räume bitte **gleichmäßig ausgeleuchtet** zeichnen. Dunkelheit, Lampenschein und Schatten macht die Engine per Shader darüber. Sonst passt das Licht nicht zur Lampe. |

### Farbpalette — Vorschlag

Ein Horror-Look lebt von Zurückhaltung. Vorschlag als Ausgangspunkt:

- **Schatten/Basis:** sehr dunkles Blaugrün und Braun (nicht reines Schwarz)
- **Mitteltöne:** entsättigtes Holzbraun, Staubgrau, verblasstes Grün
- **Akzente:** genau zwei — warmes Kerzengelb (Sicherheit) und ein kaltes Rot (Gefahr)
- Alles andere entsättigt. Wenn Farbe auftaucht, soll sie etwas bedeuten.

---

## 2. Prioritäten

| Stufe | Bedeutung |
|---|---|
| **P0** | Für den ersten spielbaren Prototyp. Ohne das läuft nichts. |
| **P1** | Für eine vollständige spielbare Nacht. |
| **P2** | Für die Vollversion. |

---

## 3. Raum-Hintergründe · `assets/rooms/`

**Je Raum genau eine Datei, 640 × 360.** Keine Hell/Dunkel-Varianten nötig.

| Datei | Raum | Prio |
|---|---|---|
| `room_hall.png` | Eingangshalle (Kamin, Treppe, Haustür) | P0 |
| `room_parlor.png` | Salon (Sofa, Klavier, Vitrine) | P0 |
| `room_library.png` | Bibliothek (Regale, Lesepult, Kamin) | P0 |
| `room_kitchen.png` | Küche (Herd, Speisekammer, Kellertür) | P0 |
| `room_upper_hall.png` | Oberer Flur (vier Türen, Fenster) | P0 |
| `room_dining.png` | Speisezimmer | P1 |
| `room_bedroom.png` | Schlafzimmer (Bett, Schrank) | P1 |
| `room_study.png` | Arbeitszimmer (Schreibtisch, Safe) | P1 |
| `room_cellar.png` | Weinkeller | P1 |
| `room_nursery.png` | Kinderzimmer | P2 |
| `room_bath.png` | Bad (großer Spiegel) | P2 |
| `room_conservatory.png` | Wintergarten | P2 |
| `room_attic.png` | Dachboden | P2 |
| `room_chamber.png` | Verborgene Kammer | P2 |

**Optional pro Raum — Überlagerungen** (`_ovl_` = wird über das Raumbild gelegt):

| Datei | Zweck | Prio |
|---|---|---|
| `room_hall_ovl_fire.png` | Brennender Kamin, 4 Frames | P1 |
| `room_*_ovl_open.png` | Geöffnete Schranktür / Schublade, nur wo nötig | P1 |
| `room_*_ovl_corrupt.png` | "Verdorbene" Variante ab Nacht 4 (Blut, Risse, falsche Geometrie) | P2 |

**Zeichenhinweise für Räume:**
- Die untersten ~40 Pixel bleiben frei von wichtigen Details → dort liegt die Inventarleiste.
- Interaktive Möbel klar lesbar und **voneinander getrennt** platzieren (Hotspots brauchen Platz).
- Fluchtpunkt-Perspektive, leicht von oben — man soll den Raum "betreten" können.

---

## 4. Gegenstände · `assets/items/` — **32 × 32**

Werden als Inventar-Icon und im Fundbildschirm benutzt.

| Datei | Gegenstand | Prio |
|---|---|---|
| `item_lamp.png` | Öllampe | P0 |
| `item_oil.png` | Ölkanne | P0 |
| `item_matches.png` | Streichholzschachtel | P0 |
| `item_candle.png` | Kerze | P0 |
| `item_crowbar.png` | Brecheisen | P0 |
| `item_lockpick.png` | Dietrich | P1 |
| `item_key_brass.png` | Messingschlüssel | P1 |
| `item_key_iron.png` | Eisenschlüssel | P1 |
| `item_note.png` | Zusammengefaltete Notiz | P0 |
| `item_diary.png` | Tagebuch | P1 |
| `item_photo.png` | Vergilbtes Foto | P1 |
| `item_laudanum.png` | Laudanum-Fläschchen | P1 |
| `item_silver_cross.png` | Silberkreuz (Ritual) | P2 |
| `item_doll.png` | Puppe (Ritual) | P2 |
| `item_ring.png` | Ehering (Ritual) | P2 |
| `item_bone.png` | Knochen (Ritual) | P2 |
| `item_mirror_shard.png` | Spiegelscherbe (Ritual) | P2 |
| `item_ledger.png` | Hauptbuch | P2 |

---

## 5. Bedienoberfläche · `assets/ui/`

| Datei | Größe | Zweck | Prio |
|---|---|---|---|
| `ui_frame_hud.png` | 640 × 24 | Leiste oben (9-Slice-fähig) | P0 |
| `ui_frame_inventory.png` | 640 × 40 | Leiste unten | P0 |
| `ui_slot.png` | 36 × 36 | Leerer Inventarplatz | P0 |
| `ui_slot_hover.png` | 36 × 36 | Platz unter dem Mauszeiger | P0 |
| `ui_clock.png` | 48 × 24 | Uhr-Rahmen | P0 |
| `ui_oil_bar.png` | 64 × 8 | Ölanzeige, leer + voll als 2 Frames | P0 |
| `ui_fear_bar.png` | 64 × 8 | Angstanzeige | P0 |
| `ui_presence_pip.png` | 10 × 10 | Präsenz-Punkt, 2 Frames (aus/an) | P0 |
| `ui_button.png` | 64 × 20 | Knopf, 3 Frames (normal/hover/gedrückt) | P0 |
| `ui_panel.png` | 200 × 120 | Dialog-/Menühintergrund, 9-Slice | P0 |
| `ui_notebook_bg.png` | 640 × 360 | Aufgeschlagenes Notizbuch | P1 |
| `ui_clue_card.png` | 96 × 64 | Hinweis-Kärtchen | P1 |
| `ui_map.png` | 640 × 360 | Grundriss der Villa, Räume einzeln ein-/ausblendbar | P1 |
| `ui_cursor.png` | 16 × 16 | Mauszeiger, 3 Frames (normal/hand/verboten) | P0 |
| `ui_title_logo.png` | 400 × 120 | Titelschriftzug | P2 |

**Schrift:** Ein Pixel-Font mit deutschen Umlauten (ä ö ü ß!) — nach `assets/fonts/`.
Zwei Größen: klein (HUD, 8 px) und groß (Titel/Notizbuch, 16 px).
Kostenlose Empfehlungen mit Umlaut-Unterstützung: *m5x7*, *m6x11*, *Pixel Operator*.

---

## 6. Die Präsenz & Effekte · `assets/entities/` und `assets/fx/`

Bewusst **wenig zeigen**. Das Meiste sind Andeutungen, keine Kreatur in voller Größe.

| Datei | Größe | Zweck | Prio |
|---|---|---|---|
| `fx_vignette.png` | 640 × 360 | Dunkler Bildrand, wird nach Angst eingeblendet | P0 |
| `fx_light_cone.png` | 256 × 256 | Weiche Lichtmaske für die Lampe (Graustufen) | P0 |
| `fx_light_candle.png` | 128 × 128 | Kleinere, wärmere Maske für Kerzen | P0 |
| `fx_dust.png` | 8 × 8 | Staubkorn für Partikel, 3 Varianten | P1 |
| `fx_scratch.png` | 640 × 360 | Filmkorn/Kratzer-Überlagerung, 4 Frames | P1 |
| `entity_shadow_door.png` | 64 × 96 | Silhouette im Türrahmen | P1 |
| `entity_shadow_hall.png` | 48 × 80 | Gestalt am Ende des Flurs | P1 |
| `entity_hands.png` | 640 × 360 | Hände am Bildrand (Heimsuchung) | P2 |
| `entity_face.png` | 128 × 128 | Gesicht — der einzige echte Jumpscare, sehr sparsam | P2 |
| `entity_mirror.png` | 96 × 128 | Spiegelbild, das nicht deins ist | P2 |

---

## 7. Ton · `audio/`

Ton trägt bei diesem Spiel mehr als die Grafik. Wenn Zeit knapp ist: **lieber weniger Sprites, besserer Ton.**

### Umgebung (`audio/ambient/`) — je 60–120 s, nahtlos loopend

| Datei | Prio |
|---|---|
| `amb_house_calm.ogg` — Grundton: Wind, knarrendes Holz | P0 |
| `amb_house_tense.ogg` — dasselbe, aber falsch (ab Präsenz 3) | P1 |
| `amb_cellar.ogg` — Tropfen, Enge | P1 |
| `amb_attic.ogg` — Regen aufs Dach, Flügelschlag | P2 |

### Effekte (`audio/sfx/`)

| Gruppe | Dateien | Prio |
|---|---|---|
| Schritte | `sfx_step_wood_1..4.ogg`, `sfx_step_stone_1..4.ogg` | P0 |
| Türen | `sfx_door_open.ogg`, `sfx_door_close.ogg`, `sfx_door_locked.ogg` | P0 |
| Durchsuchen | `sfx_search_drawer.ogg`, `sfx_search_cloth.ogg`, `sfx_search_paper.ogg` | P0 |
| Licht | `sfx_match_strike.ogg`, `sfx_lamp_out.ogg`, `sfx_candle_place.ogg` | P0 |
| Bedienung | `sfx_ui_click.ogg`, `sfx_ui_hover.ogg`, `sfx_clue_found.ogg` | P0 |
| Werkzeug | `sfx_crowbar_pry.ogg` (laut!), `sfx_lockpick.ogg` (leise) | P1 |
| Bedrohung | `sfx_presence_1..5.ogg` — je Stufe ein Signal, das lauter/näher wird | P1 |
| Heimsuchung | `sfx_haunt_begin.ogg`, `sfx_haunt_pass.ogg`, `sfx_haunt_fail.ogg`, `sfx_heartbeat.ogg` | P1 |
| Uhr | `sfx_clock_tick.ogg`, `sfx_clock_chime.ogg` (zu jeder vollen Stunde) | P1 |

### Musik (`audio/music/`)

| Datei | Zweck | Prio |
|---|---|---|
| `mus_title.ogg` | Hauptmenü | P1 |
| `mus_interlude.ogg` | Zwischen den Nächten | P1 |
| `mus_finale.ogg` | Nacht 7 / Ritual | P2 |

Während der Nacht läuft **keine Musik** — nur Umgebungston. Musik nimmt der Stille die Wirkung.

---

## 8. Mengengerüst

| Kategorie | P0 | P1 | P2 | Gesamt |
|---|---|---|---|---|
| Raum-Hintergründe | 5 | 4 | 5 | **14** |
| Raum-Überlagerungen | 0 | ~8 | ~14 | **~22** |
| Gegenstände | 7 | 6 | 6 | **19** |
| Bedienoberfläche | 11 | 3 | 1 | **15** |
| Effekte / Präsenz | 3 | 4 | 3 | **10** |
| Tondateien | ~20 | ~20 | ~6 | **~46** |

**Für den ersten spielbaren Prototyp brauchst du also 26 Grafiken.**
Davon sind 5 die aufwendigen Raumbilder — der Rest sind kleine Icons.

---

## 9. Ablauf beim Austauschen

1. Ich lege für jede Datei oben einen **Platzhalter in exakt derselben Größe und mit demselben Namen** an.
2. Du zeichnest die echte Version.
3. Du legst sie einfach über den Platzhalter (gleicher Pfad, gleicher Name).
4. Godot lädt sie beim nächsten Start automatisch. **Keine Code-Änderung nötig.**

Wenn du eine Grafik in einer *anderen* Größe machen willst als hier angegeben:
sag vorher Bescheid, dann passe ich die Vorgabe an, bevor du malst.
