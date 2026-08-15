# Asset-Plan — ASHGROVE

**Version 0.2** — angepasst an das überarbeitete Konzept (vier Achsen, keine
Monster-Sprites, 1960er-Setting, englische Texte).

**Du zeichnest die echten Sprites, ich baue nur simple Platzhalter in exakt denselben
Maßen und mit denselben Dateinamen.** Dadurch kannst du jederzeit eine Datei
austauschen, ohne dass am Code etwas geändert werden muss.

---

## 1. Technische Vorgaben

| Punkt | Vorgabe |
|---|---|
| **Basis-Auflösung** | 640 × 360 Pixel (16:9), skaliert sauber auf 1280×720 und 1920×1080 |
| **Format** | PNG mit Transparenz (RGBA), kein JPG |
| **Pixel-Art-Regel** | **Kein Anti-Aliasing**, keine weichen Kanten, keine halbtransparenten Ränder |
| **Palette** | Frei, aber gemeinsam für alles. Max. ~32 Farben hält den Look zusammen. |
| **Benennung** | exakt wie unten, klein_mit_unterstrichen |
| **Animation** | Horizontaler Sprite-Sheet-Streifen, alle Frames gleich groß |
| **Kein Licht einbauen** | Räume **gleichmäßig ausgeleuchtet** zeichnen. Die vier LIGHT-Stufen macht die Engine per Shader darüber. Sonst passt das Licht nicht zur Taschenlampe. |
| **Untere 40 Pixel freihalten** | Da liegt die Inventarleiste. |

### Palette — Vorschlag

- **Basis/Schatten:** sehr dunkles Blaugrün und Braun, **nie reines Schwarz**
- **Mitteltöne:** entsättigtes Holzbraun, Staubgrau, verblasstes Tapetengrün
- **Genau zwei Akzente:** warmes Glühbirnengelb (= Sicherheit) und ein stumpfes Rot (= Gefahr)
- Alles andere entsättigt. Wenn Farbe auftaucht, soll sie etwas bedeuten.

### Prioritäten

| Stufe | Bedeutung |
|---|---|
| **P0** | Erster spielbarer Prototyp — 5 Räume, alle vier Achsen |
| **P1** | Vollständiger Spieldurchlauf |
| **P2** | Politur und Vollversion |

---

## 2. Raum-Hintergründe · `assets/rooms/` — **640 × 360**

Je Raum **eine** Datei. Keine Hell/Dunkel-Varianten nötig.

| Datei | Raum | Was drin sein muss | Prio |
|---|---|---|---|
| `room_entrance.png` | Entrance Hall | Haustür (der Ausgang), Treppe, Garderobe | **P0** |
| `room_kitchen.png` | Kitchen | Herd, Speisekammertür, Spüle, Kellertür | **P0** |
| `room_bedroom.png` | Bedroom | Bett, Kleiderschrank, Nachttisch, Fenster | **P0** |
| `room_library.png` | Library | Regale (Bretter!), Lesepult, Kamin | **P0** |
| `room_cellar.png` | Cellar | **Sicherungskasten**, Einmachregale, Treppe | **P0** |
| `room_parlor.png` | Parlor | Schweres Sofa, Radio, Vitrine | P1 |
| `room_upper_landing.png` | Upper Landing | Vier Türen, Fenster, Geländer | P1 |
| `room_study.png` | Study | Schreibtisch, **Telefon**, Safe | P1 |
| `room_attic.png` | Attic | Werkbank, Bretterstapel, Koffer | P1 |
| `room_dining.png` | Dining Room | Langer Tisch, Kerzenleuchter, Anrichte | P1 |
| `room_bathroom.png` | Bathroom | Spiegelschrank, Wanne | P2 |
| `room_nursery.png` | Nursery | Kinderbett, Spielzeug, Schrank | P2 |
| `room_conservatory.png` | Conservatory | Große Glasfront, Blick nach draußen | P2 |

### Überlagerungen · `_ovl_` — dieselbe Größe, transparent

| Datei | Zweck | Prio |
|---|---|---|
| `room_*_ovl_barricade_2.png` | Möbel vor der Tür (SAFETY 2) | **P0** — mind. für die 5 P0-Räume |
| `room_*_ovl_barricade_3.png` | Bretter vernagelt (SAFETY 3) | **P0** — dito |
| `room_*_ovl_stash.png` | Dein Vorratsstapel, wenn hier dein Lager ist | P1 |
| `room_*_ovl_open.png` | Geöffnete Schranktür / Schublade, nur wo nötig | P1 |
| `room_*_ovl_wrong.png` | Ab Tag 7: der Raum stimmt nicht mehr | P2 |
| `room_entrance_ovl_door.png` | Die Haustür in mehreren Zuständen, 3 Frames | P1 |

---

## 3. Gegenstände · `assets/items/` — **32 × 32**

### Licht

| Datei | Prio |
|---|---|
| `item_flashlight.png` — Taschenlampe, 1960er-Form | **P0** |
| `item_battery.png` — Batterie | **P0** |
| `item_candle.png` — Kerze | **P0** |
| `item_matches.png` — Streichholzschachtel | **P0** |
| `item_fuse.png` — Schmelzsicherung | **P0** |
| `item_lantern.png` — Petroleumlampe | P1 |

### Essen

| Datei | Prio |
|---|---|
| `item_can.png` — Konservendose | **P0** |
| `item_can_open.png` — geöffnete Dose | **P0** |
| `item_bread.png` — Brot (verderblich) | **P0** |
| `item_preserves.png` — Einmachglas | P1 |
| `item_meal_hot.png` — warme Mahlzeit vom Herd | P1 |
| `item_food_spoiled.png` — verdorben (graue Variante) | P1 |

### Bauen und Werkzeug

| Datei | Prio |
|---|---|
| `item_board.png` — Brett | **P0** |
| `item_nails.png` — Nagelschachtel | **P0** |
| `item_hammer.png` — Hammer | **P0** |
| `item_crowbar.png` — Brecheisen | P1 |
| `item_screwdriver.png` — Schraubendreher | P1 |
| `item_key.png` — Schlüssel | P1 |

### Gesundheit

| Datei | Prio |
|---|---|
| `item_bandage.png` — Verbandskasten | **P0** |
| `item_pills.png` — Tablettenröhrchen | P1 |
| `item_blanket.png` — Decke (besserer Schlaf) | P2 |

### Geheimnis

| Datei | Prio |
|---|---|
| `item_note.png` — gefaltete Notiz | **P0** |
| `item_photo.png` — vergilbtes Foto | P1 |
| `item_diary.png` — Tagebuch | P1 |
| `item_letter.png` — Brief | P1 |
| `item_ring.png` · `item_doll.png` · `item_locket.png` · `item_bone.png` | die vier möglichen "Rückgabe"-Gegenstände | P2 |

---

## 4. Bedienoberfläche · `assets/ui/`

| Datei | Größe | Zweck | Prio |
|---|---|---|---|
| `ui_bar_top.png` | 640 × 28 | Kopfleiste, 9-Slice | **P0** |
| `ui_bar_bottom.png` | 640 × 44 | Inventarleiste, 9-Slice | **P0** |
| `ui_slot.png` | 36 × 36 | Inventarplatz, 3 Frames (leer/hover/belegt) | **P0** |
| `ui_meter.png` | 72 × 10 | Leiste für FOOD und REST, 2 Frames (Rahmen/Füllung) | **P0** |
| `ui_pip_light.png` | 10 × 10 | LIGHT-Punkt, 2 Frames (aus/an) | **P0** |
| `ui_pip_safety.png` | 10 × 10 | SAFETY-Punkt, 2 Frames | **P0** |
| `ui_button.png` | 72 × 22 | Knopf, 3 Frames (normal/hover/gedrückt) | **P0** |
| `ui_panel.png` | 240 × 140 | Dialoghintergrund, 9-Slice | **P0** |
| `ui_cursor.png` | 16 × 16 | Mauszeiger, 3 Frames (normal/hand/gesperrt) | **P0** |
| `ui_event_frame.png` | 400 × 220 | **Rahmen für Ereignis-Popups.** Wichtigstes UI-Element im Spiel. | **P0** |
| `ui_icon_status.png` | 16 × 16 | Zustandssymbole, 6 Frames: Injured · Bleeding · Sick · Fevered · Shaken · Starving | **P0** |
| `ui_sleep_dialog.png` | 300 × 180 | Schlaf-Dialog mit Risikoanzeige | **P0** |
| `ui_notebook_bg.png` | 640 × 360 | Aufgeschlagenes Notizbuch, vier Fragen | P1 |
| `ui_clue_card.png` | 100 × 70 | Hinweis-Kärtchen, 2 Frames (offen/verdeckt) | P1 |
| `ui_map.png` | 640 × 360 | Grundriss, Räume einzeln ein-/ausblendbar | P1 |
| `ui_fusebox.png` | 320 × 220 | Sicherungskasten-Bildschirm, 3 Steckplätze | P1 |
| `ui_title_logo.png` | 400 × 120 | Titelschriftzug | P2 |
| `ui_death_card.png` | 640 × 360 | Zusammenfassung nach dem Tod | P2 |

**Schrift** → `assets/fonts/` — Pixel-Font, zwei Größen (8 px HUD, 16 px Titel/Notizbuch).
Da die Spieltexte englisch sind, brauchst du **keine Umlaute**. Gute kostenlose
Empfehlungen: *m5x7*, *m6x11*, *Pixel Operator*.

---

## 5. Effekte · `assets/fx/`

Es gibt **keine Monster-Sprites** mehr. Die Bedrohung ist Text, Ton und Licht.
Was hier steht, ist alles, was du an "Übernatürlichem" zeichnen musst.

| Datei | Größe | Zweck | Prio |
|---|---|---|---|
| `fx_light_flashlight.png` | 256 × 256 | Kegelförmige Lichtmaske, Graustufen weich | **P0** |
| `fx_light_candle.png` | 128 × 128 | Runde, warme Maske | **P0** |
| `fx_light_bulb.png` | 320 × 320 | Große Maske für Deckenlicht | **P0** |
| `fx_vignette.png` | 640 × 360 | Dunkler Bildrand, Stärke abhängig von REST | **P0** |
| `fx_dust.png` | 8 × 8 | Staubkorn, 3 Varianten | P1 |
| `fx_grain.png` | 640 × 360 | Filmkorn, 4 Frames | P1 |
| `fx_shadow_figure.png` | 40 × 88 | **Eine** Silhouette, nur als Andeutung am Bildrand. Sparsam einsetzen. | P1 |
| `fx_handwriting.png` | 200 × 120 | Die Schrift aus dem Schlaf-Ereignis | P2 |
| `fx_hallucination.png` | 640 × 360 | Verzerrung bei REST unter 20 | P2 |

---

## 6. Ton · `audio/`

Bei diesem Konzept trägt der Ton **mehr als die Grafik** — die ganze Bedrohung ist
unsichtbar. Wenn Zeit knapp wird: lieber weniger Sprites, besserer Ton.

### Umgebung (`audio/ambient/`) — 60–120 s, nahtlos loopend

| Datei | Prio |
|---|---|
| `amb_house_day.ogg` — Wind, Holz, entfernte Vögel | **P0** |
| `amb_house_night.ogg` — dasselbe, aber leerer und tiefer | **P0** |
| `amb_cellar.ogg` — Tropfen, Enge, Brummen des Sicherungskastens | P1 |
| `amb_attic.ogg` — Regen aufs Dach | P2 |

### Effekte (`audio/sfx/`)

| Gruppe | Dateien | Prio |
|---|---|---|
| Schritte | `sfx_step_wood_1..4.ogg`, `sfx_step_stone_1..4.ogg` | **P0** |
| Türen | `sfx_door_open.ogg`, `sfx_door_close.ogg`, `sfx_door_locked.ogg` | **P0** |
| Suchen | `sfx_search_drawer.ogg`, `sfx_search_cloth.ogg`, `sfx_search_paper.ogg` | **P0** |
| Licht | `sfx_flashlight_click.ogg`, `sfx_match_strike.ogg`, `sfx_bulb_on.ogg`, `sfx_bulb_burst.ogg` | **P0** |
| Strom | `sfx_fuse_insert.ogg`, `sfx_fuse_blow.ogg`, `sfx_power_hum.ogg` (loop) | **P0** |
| Bauen | `sfx_hammer_1..3.ogg`, `sfx_furniture_drag.ogg`, `sfx_wood_break.ogg` | **P0** |
| Essen/Schlaf | `sfx_can_open.ogg`, `sfx_eat.ogg`, `sfx_bed_creak.ogg`, `sfx_wake.ogg` | **P0** |
| Bedienung | `sfx_ui_click.ogg`, `sfx_ui_hover.ogg`, `sfx_event_appear.ogg`, `sfx_clue_found.ogg` | **P0** |
| Ereignisse | `sfx_scratch_door.ogg`, `sfx_steps_above.ogg`, `sfx_whisper.ogg`, `sfx_thud_distant.ogg`, `sfx_breathing.ogg` | **P0** |
| 60er-Technik | `sfx_radio_static.ogg`, `sfx_radio_voice.ogg`, `sfx_phone_ring.ogg`, `sfx_phone_pickup.ogg` | P1 |
| Zustände | `sfx_heartbeat.ogg`, `sfx_cough.ogg`, `sfx_stomach.ogg` | P1 |

### Musik (`audio/music/`)

| Datei | Zweck | Prio |
|---|---|---|
| `mus_title.ogg` | Hauptmenü | P1 |
| `mus_death.ogg` | Zusammenfassung nach dem Tod | P1 |
| `mus_ending.ogg` | Wenn die Tür aufgeht | P2 |

**Während des Spiels läuft keine Musik.** Nur Umgebungston. Musik nimmt der Stille
die Wirkung, und die Stille ist hier das Hauptinstrument.

---

## 7. Mengengerüst

| Kategorie | P0 | P1 | P2 | Gesamt |
|---|---|---|---|---|
| Raum-Hintergründe | 5 | 5 | 3 | **13** |
| Raum-Überlagerungen | 10 | ~10 | ~13 | **~33** |
| Gegenstände | 12 | 11 | 5 | **28** |
| Bedienoberfläche | 12 | 4 | 2 | **18** |
| Effekte | 4 | 3 | 2 | **9** |
| Tondateien | ~40 | ~15 | ~3 | **~58** |

**Für den Prototyp: 43 Grafiken.** Davon sind 5 aufwendige Raumbilder und
10 Barrikaden-Überlagerungen — der Rest sind kleine Icons von 16 bis 36 Pixeln.

Wenn du klein anfangen willst: **Zeichne zuerst `room_kitchen.png`.** Daran sehe
ich deine Palette, deine Perspektive und deine Detailtiefe und kann alle Platzhalter
danach ausrichten.

---

## 8. Ablauf beim Austauschen

1. Ich lege für jede Datei oben einen **Platzhalter in exakt derselben Größe** an.
2. Du zeichnest die echte Version.
3. Du legst sie über den Platzhalter — gleicher Pfad, gleicher Name.
4. Godot lädt sie beim nächsten Start. **Keine Code-Änderung nötig.**

Willst du eine Grafik in einer anderen Größe machen als hier angegeben:
sag vorher Bescheid, dann passe ich die Vorgabe an, **bevor** du malst.
