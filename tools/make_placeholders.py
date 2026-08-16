#!/usr/bin/env python3
"""Erzeugt Platzhalter-Grafiken für Ashgrove.

Die Raumbilder zeigen die Hotspot-Rechtecke an ihren echten Positionen —
sie sind damit gleichzeitig Malvorlage. Die Rechtecke werden direkt aus
content/rooms_db.gd gelesen, bleiben also automatisch synchron.

    python3 tools/make_placeholders.py

Echte Grafiken einfach über die Platzhalter legen: gleicher Pfad, gleicher
Name, gleiche Größe. Am Code ändert sich nichts.
"""

import re
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parent.parent
ROOMS_DB = ROOT / "content" / "rooms_db.gd"
ITEMS_DB = ROOT / "content" / "items_db.gd"

ROOM_SIZE = (640, 360)
ITEM_SIZE = (32, 32)

# Palette aus docs/ASSET_PLAN.md: kein reines Schwarz, kein reines Weiß.
INK = (11, 14, 16)
PANEL = (21, 25, 28)
EDGE = (42, 49, 54)
TEXT = (200, 196, 184)
DIM = (111, 119, 115)
WARM = (216, 162, 74)


def parse_rooms():
    """Liest Raumnamen und Hotspot-Rechtecke aus der GDScript-Tabelle."""
    source = ROOMS_DB.read_text(encoding="utf-8")
    rooms = {}
    # Jeder Raum beginnt mit  "id": {  auf Spaltenanfang.
    for match in re.finditer(r'^"(\w+)":\s*\{', source, re.MULTILINE):
        room_id = match.group(1)
        start = match.end()
        depth = 1
        i = start
        while i < len(source) and depth > 0:
            if source[i] == "{":
                depth += 1
            elif source[i] == "}":
                depth -= 1
            i += 1
        block = source[start:i]
        name_match = re.search(r'"name":\s*"([^"]+)"', block)
        spots = []
        for spot in re.finditer(
            r'"id":\s*"(\w+)".*?"name":\s*"([^"]*)".*?"rect":\s*\[([\d\s,]+)\]',
            block,
            re.DOTALL,
        ):
            numbers = [int(n) for n in spot.group(3).split(",")]
            spots.append((spot.group(1), spot.group(2), numbers))
        rooms[room_id] = {
            "name": name_match.group(1) if name_match else room_id,
            "hotspots": spots,
        }
    return rooms


def parse_items():
    source = ITEMS_DB.read_text(encoding="utf-8")
    items = {}
    for match in re.finditer(r'^\t"(\w+)":\s*\{"name":\s*"([^"]+)"', source, re.MULTILINE):
        items[match.group(1)] = match.group(2)
    return items


def make_room(room_id, room, out_dir):
    image = Image.new("RGBA", ROOM_SIZE, INK + (255,))
    draw = ImageDraw.Draw(image)

    # Andeutung von Boden und Wand, damit die Perspektive erkennbar ist.
    draw.rectangle([0, 250, 639, 359], fill=PANEL + (255,))
    draw.line([0, 250, 639, 250], fill=EDGE + (255,))
    for x in range(0, 640, 80):
        draw.line([x, 250, x, 359], fill=(30, 35, 39, 255))

    draw.text((10, 8), room["name"].upper(), fill=TEXT)
    draw.text((10, 22), f"assets/rooms/room_{room_id}.png  ·  640x360", fill=DIM)
    draw.text((10, 340), "PLACEHOLDER — draw evenly lit, no shadows", fill=DIM)

    for spot_id, spot_name, rect in room["hotspots"]:
        x, y, w, h = rect
        draw.rectangle([x, y, x + w, y + h], outline=WARM + (255,))
        draw.text((x + 3, y + 3), spot_name or spot_id, fill=WARM)
        draw.text((x + 3, y + 14), f"{w}x{h}", fill=DIM)

    path = out_dir / f"room_{room_id}.png"
    image.save(path)
    return path


def make_item(item_id, name, out_dir):
    image = Image.new("RGBA", ITEM_SIZE, (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.rectangle([1, 1, 30, 30], fill=PANEL + (255,), outline=EDGE + (255,))
    # Zwei Buchstaben als Kürzel — genug, um Items im Inventar zu unterscheiden.
    initials = "".join(part[0] for part in re.split(r"[ _]", name)[:2]).upper()
    draw.text((10, 12), initials, fill=TEXT)
    path = out_dir / f"{item_id}.png"
    image.save(path)
    return path


def make_ui(out_dir):
    made = []
    for name, size, color in [
        ("ui_slot", (36, 36), PANEL),
        ("ui_panel", (48, 48), PANEL),
        ("ui_pip_energy", (14, 14), WARM),
        ("ui_pip_light", (10, 10), TEXT),
        ("ui_pip_safety", (10, 10), TEXT),
        ("ui_cursor", (16, 16), TEXT),
    ]:
        image = Image.new("RGBA", size, (0, 0, 0, 0))
        draw = ImageDraw.Draw(image)
        draw.rectangle([0, 0, size[0] - 1, size[1] - 1], fill=PANEL + (255,), outline=color + (255,))
        path = out_dir / f"{name}.png"
        image.save(path)
        made.append(path)

    # Lichtmasken: weicher radialer Verlauf, als Graustufen.
    for name, size in [("fx_light_flashlight", 256), ("fx_light_candle", 128), ("fx_light_bulb", 320)]:
        image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        pixels = image.load()
        centre = size / 2
        for y in range(size):
            for x in range(size):
                distance = ((x - centre) ** 2 + (y - centre) ** 2) ** 0.5 / centre
                value = max(0.0, 1.0 - distance)
                alpha = int((value**2) * 255)
                pixels[x, y] = (255, 255, 255, alpha)
        path = out_dir / f"{name}.png"
        image.save(path)
        made.append(path)
    return made


def main():
    rooms_dir = ROOT / "assets" / "rooms"
    items_dir = ROOT / "assets" / "items"
    ui_dir = ROOT / "assets" / "ui"
    for directory in (rooms_dir, items_dir, ui_dir):
        directory.mkdir(parents=True, exist_ok=True)

    rooms = parse_rooms()
    for room_id, room in rooms.items():
        make_room(room_id, room, rooms_dir)
    print(f"{len(rooms)} room placeholders")

    items = parse_items()
    for item_id, name in items.items():
        make_item(item_id, name, items_dir)
    print(f"{len(items)} item placeholders")

    ui = make_ui(ui_dir)
    print(f"{len(ui)} ui and fx placeholders")


if __name__ == "__main__":
    main()
