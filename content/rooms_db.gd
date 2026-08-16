extends RefCounted
## Alle Räume mit Verbindungen und Hotspots.
##
## Neuen Raum anlegen: hier einen Eintrag ergänzen, ein 640x360-PNG unter
## assets/rooms/room_<id>.png ablegen und ihn in die exits eines Nachbarn eintragen.
##
## Hotspot-rect ist [x, y, breite, höhe] im 640x360-Raster.
## Aktionstypen: search · block · barricade · dismantle · cook · radio ·
##               telephone · fuse_box · plant · water · harvest · front_door · window

const ROOMS := {
"entrance": {
	"name": "Entrance Hall",
	"exits": ["parlor", "dining", "upper_landing"],
	"has_window": false,
	"hotspots": [
		{"id": "front_door", "name": "The front door", "rect": [270, 90, 100, 170],
		 "look": "It is shut. It was shut before you touched it.",
		 "actions": [{"type": "front_door", "label": "Try the door", "cost": 0}]},
		{"id": "coat_stand", "name": "Coat stand", "rect": [40, 120, 70, 140],
		 "look": "Three coats. None of them fit anyone who lived here.",
		 "actions": [{"type": "search", "label": "Search the coats", "cost": 1,
			"loot": [{"item": "matches", "chance": 0.5}, {"item": "key_cellar", "chance": 0.3},
					 {"item": "note_ledger", "chance": 0.2}]}]},
		{"id": "hall_table", "name": "Hall table", "rect": [470, 170, 110, 80],
		 "look": "A visitors' book, closed. Dust on everything but the cover.",
		 "actions": [{"type": "search", "label": "Search the table", "cost": 1,
			"loot": [{"item": "candle", "chance": 0.5, "min": 1, "max": 2}, {"item": "chocolate", "chance": 0.3},
					 {"item": "note_letter_a", "chance": 0.25}]}]}
	]
},
"parlor": {
	"name": "Parlor",
	"exits": ["entrance", "library"],
	"has_window": true,
	"hotspots": [
		{"id": "radio", "name": "Radio set", "rect": [60, 150, 110, 90],
		 "look": "A valve radio. The dial glows if you give it a moment.",
		 "actions": [{"type": "radio", "label": "Listen to the radio", "cost": 1}]},
		{"id": "sofa", "name": "Heavy sofa", "rect": [220, 200, 180, 90],
		 "look": "Horsehair and dust. Heavy enough to be useful.",
		 "actions": [
			{"type": "search", "label": "Search the sofa", "cost": 1,
			 "loot": [{"item": "can_beans", "chance": 0.5}, {"item": "chocolate", "chance": 0.3},
					  {"item": "photo_family", "chance": 0.3}, {"item": "pocket_watch", "chance": 0.15}]},
			{"type": "dismantle", "label": "Break it up for boards", "cost": 2, "boards": 3}]},
		{"id": "cabinet", "name": "Display cabinet", "rect": [450, 120, 120, 140],
		 "look": "Glass, and behind it things nobody looked at twice.",
		 "actions": [{"type": "search", "label": "Search the cabinet", "cost": 1,
			"loot": [{"item": "whiskey", "chance": 0.4}, {"item": "locket", "chance": 0.2},
					 {"item": "candle", "chance": 0.4}]}]}
	]
},
"library": {
	"name": "Library",
	"exits": ["parlor"],
	"has_window": true,
	"hotspots": [
		{"id": "shelves", "name": "Bookshelves", "rect": [30, 60, 200, 230],
		 "look": "More shelf than book. The gaps are not alphabetical.",
		 "actions": [
			{"type": "search", "label": "Search the shelves", "cost": 1,
			 "loot": [{"item": "book_page", "chance": 0.45}, {"item": "note_damp", "chance": 0.3},
					  {"item": "matches", "chance": 0.3}]},
			{"type": "dismantle", "label": "Pull down a shelf", "cost": 2, "boards": 3}]},
		{"id": "desk", "name": "Reading desk", "rect": [280, 190, 150, 90],
		 "look": "Someone read here recently enough that the chair is not square to the desk.",
		 "actions": [{"type": "search", "label": "Search the desk", "cost": 1,
			"loot": [{"item": "note_floorplan", "chance": 0.4}, {"item": "candle", "chance": 0.4},
					 {"item": "key_attic", "chance": 0.2}]}]}
	]
},
"dining": {
	"name": "Dining Room",
	"exits": ["entrance", "kitchen"],
	"has_window": true,
	"hotspots": [
		{"id": "sideboard", "name": "Sideboard", "rect": [40, 140, 160, 120],
		 "look": "Candlesticks, and the silver nobody came back for.",
		 "actions": [{"type": "search", "label": "Search the sideboard", "cost": 1,
			"loot": [{"item": "candle", "chance": 0.7, "min": 1, "max": 3}, {"item": "matches", "chance": 0.4},
					 {"item": "preserves", "chance": 0.5}, {"item": "chocolate", "chance": 0.3}]}]},
		{"id": "table", "name": "Long table", "rect": [240, 190, 260, 90],
		 "look": "Laid for six. The places have been set for a while.",
		 "actions": [{"type": "dismantle", "label": "Break up a chair", "cost": 2, "boards": 2}]}
	]
},
"kitchen": {
	"name": "Kitchen",
	"exits": ["dining", "conservatory", "cellar"],
	"has_window": true,
	"hotspots": [
		# Die Speisekammer ist die wichtigste einzelne Nahrungsquelle im Haus.
		# Sie allein deckt rund vier Tage.
		{"id": "pantry", "name": "Pantry", "rect": [30, 90, 110, 190],
		 "look": "Tins, mostly. The labels have gone soft.",
		 "actions": [{"type": "search", "label": "Search the pantry", "cost": 1,
			"loot": [{"item": "can_beans", "chance": 0.9, "min": 1, "max": 3},
					 {"item": "can_soup", "chance": 0.7, "min": 1, "max": 2},
					 {"item": "bread", "chance": 0.5},
					 {"item": "can_meat", "chance": 0.6, "min": 1, "max": 2}]}]},
		{"id": "stove", "name": "Stove", "rect": [200, 150, 130, 110],
		 "look": "Electric. It needs a fuse in the box downstairs to do anything.",
		 "actions": [{"type": "cook", "label": "Cook a meal", "cost": 1}]},
		{"id": "sink", "name": "Sink and drawers", "rect": [400, 160, 160, 100],
		 "look": "The tap runs brown for a while, then clear.",
		 "actions": [{"type": "search", "label": "Search the drawers", "cost": 1,
			"loot": [{"item": "screwdriver", "chance": 0.4}, {"item": "note_receipt", "chance": 0.3},
					 {"item": "bandage", "chance": 0.4}, {"item": "water_bottle", "chance": 0.7, "min": 1, "max": 2},
					 {"item": "can_soup", "chance": 0.4}]}]}
	]
},
"conservatory": {
	"name": "Conservatory",
	"exits": ["kitchen"],
	"has_window": true,
	"hotspots": [
		{"id": "beds", "name": "Planting beds", "rect": [40, 180, 250, 110],
		 "look": "Two raised beds under the glass. The soil is still good.",
		 "actions": [
			{"type": "plant", "label": "Plant seeds", "cost": 1},
			{"type": "water", "label": "Water the beds", "cost": 1},
			{"type": "harvest", "label": "Harvest", "cost": 1}]},
		{"id": "glass", "name": "The glass front", "rect": [340, 40, 260, 230],
		 "look": "You can see the garden. You should stop looking at the garden.",
		 "actions": [{"type": "window", "label": "Break the glass and run", "cost": 0}]},
		{"id": "potting", "name": "Potting bench", "rect": [40, 90, 140, 80],
		 "look": "Seed packets, a watering can, a trowel with a broken handle.",
		 "actions": [{"type": "search", "label": "Search the bench", "cost": 1,
			"loot": [{"item": "seeds", "chance": 0.8, "min": 1, "max": 2}, {"item": "watering_can", "chance": 0.9},
					 {"item": "apples", "chance": 0.6, "min": 1, "max": 2}, {"item": "note_marker", "chance": 0.2}]}]}
	]
},
"upper_landing": {
	"name": "Upper Landing",
	"exits": ["entrance", "bedroom", "study", "bathroom", "nursery", "attic"],
	"has_window": true,
	"hotspots": [
		{"id": "chest", "name": "Linen chest", "rect": [240, 200, 160, 80],
		 "look": "Sheets, folded by someone who cared about folding sheets.",
		 "actions": [{"type": "search", "label": "Search the chest", "cost": 1,
			"loot": [{"item": "blanket", "chance": 0.5}, {"item": "rag", "chance": 0.5, "max": 2}]}]}
	]
},
"bedroom": {
	"name": "Bedroom",
	"exits": ["upper_landing"],
	"has_bed": true,
	"has_window": true,
	"hotspots": [
		{"id": "bed", "name": "The bed", "rect": [60, 160, 220, 120],
		 "look": "Made. Turned down on one side.",
		 "actions": [{"type": "search", "label": "Look under the mattress", "cost": 1,
			"loot": [{"item": "locket", "chance": 0.35}, {"item": "note_letter_a", "chance": 0.3},
					 {"item": "pills", "chance": 0.3}]}]},
		{"id": "wardrobe", "name": "Wardrobe", "rect": [400, 80, 130, 190],
		 "look": "Deep enough to stand in, which is a thing you have now thought about.",
		 "actions": [{"type": "search", "label": "Search the wardrobe", "cost": 1,
			"loot": [{"item": "key_study", "chance": 0.35}, {"item": "blanket", "chance": 0.4},
					 {"item": "candle", "chance": 0.3}]}]}
	]
},
"study": {
	"name": "Study",
	"exits": ["upper_landing"],
	"has_window": true,
	"hotspots": [
		{"id": "telephone", "name": "Telephone", "rect": [420, 160, 90, 70],
		 "look": "The line was cut before you got here. You checked.",
		 "actions": [{"type": "telephone", "label": "Pick up the receiver", "cost": 1}]},
		{"id": "desk", "name": "Writing desk", "rect": [180, 170, 200, 110],
		 "look": "Locked drawer. Small keyhole.",
		 "actions": [{"type": "search", "label": "Search the desk", "cost": 1,
			"loot": [{"item": "note_deed", "chance": 0.4}, {"item": "nails", "chance": 0.4},
					 {"item": "note_inventory", "chance": 0.25}]}]},
		{"id": "safe", "name": "Wall safe", "rect": [50, 90, 100, 90],
		 "look": "Three dials. Somebody wrote the number down somewhere, they always do.",
		 "actions": [{"type": "search", "label": "Work on the safe", "cost": 2,
			"loot": [{"item": "note_deed", "chance": 0.5}, {"item": "ring", "chance": 0.3},
					 {"item": "fuse", "chance": 0.4}]}]}
	]
},
"bathroom": {
	"name": "Bathroom",
	"exits": ["upper_landing"],
	"has_window": true,
	"hotspots": [
		{"id": "cabinet", "name": "Mirror cabinet", "rect": [200, 70, 130, 110],
		 "look": "The mirror is fine. It is a mirror. It is fine.",
		 "actions": [{"type": "search", "label": "Search the cabinet", "cost": 1,
			"loot": [{"item": "bandage", "chance": 0.6}, {"item": "pills", "chance": 0.45}]}]},
		{"id": "bath", "name": "Bath", "rect": [340, 170, 220, 110],
		 "look": "Dry. There is something in the drain.",
		 "actions": [{"type": "search", "label": "Reach into the drain", "cost": 1,
			"loot": [{"item": "ring", "chance": 0.4}, {"item": "note_marks", "chance": 0.3}]}]}
	]
},
"nursery": {
	"name": "Nursery",
	"exits": ["upper_landing"],
	"available_from_day": 7,
	"has_bed": true,
	"has_window": true,
	"hotspots": [
		{"id": "cot", "name": "The cot", "rect": [60, 170, 180, 110],
		 "look": "Small. Made up. Recently, by the look of the corners.",
		 "actions": [{"type": "search", "label": "Search the cot", "cost": 1,
			"loot": [{"item": "doll", "chance": 0.5}, {"item": "photo_wrong", "chance": 0.4}]}]},
		{"id": "toybox", "name": "Toy box", "rect": [380, 200, 160, 80],
		 "look": "Everything in it is arranged by size.",
		 "actions": [{"type": "search", "label": "Search the toy box", "cost": 1,
			"loot": [{"item": "photo_wrong", "chance": 0.35}, {"item": "book_page", "chance": 0.35}]}]}
	]
},
"attic": {
	"name": "Attic",
	"exits": ["upper_landing"],
	"available_from_day": 7,
	"hotspots": [
		{"id": "bench", "name": "Workbench", "rect": [50, 150, 200, 120],
		 "look": "Tools hung on a board, each with its outline painted behind it. Two outlines are empty.",
		 "actions": [{"type": "search", "label": "Search the bench", "cost": 1,
			"loot": [{"item": "hammer", "chance": 0.6}, {"item": "nails", "chance": 0.6, "max": 2},
					 {"item": "wire", "chance": 0.5}, {"item": "crowbar", "chance": 0.3}]}]},
		{"id": "timber", "name": "Stack of boards", "rect": [300, 180, 160, 100],
		 "look": "Offcuts, kept because you never know.",
		 "actions": [{"type": "search", "label": "Take some boards", "cost": 1,
			"loot": [{"item": "board", "chance": 0.9, "max": 3}, {"item": "rope", "chance": 0.4}]}]},
		{"id": "cases", "name": "Suitcases", "rect": [490, 170, 120, 100],
		 "look": "Packed. Never went anywhere.",
		 "actions": [{"type": "search", "label": "Open a case", "cost": 1,
			"loot": [{"item": "note_inventory", "chance": 0.4}, {"item": "seeds", "chance": 0.3},
					 {"item": "can_meat", "chance": 0.5}, {"item": "lantern", "chance": 0.25}]}]}
	]
},
"cellar": {
	"name": "Cellar",
	"exits": ["kitchen"],
	"hotspots": [
		{"id": "fuse_box", "name": "Fuse box", "rect": [60, 80, 110, 120],
		 "look": "Three fuses in it. Six ways out of it. Somebody made choices here too.",
		 "actions": [{"type": "fuse_box", "label": "Move a fuse", "cost": 1}]},
		{"id": "preserve_shelf", "name": "Preserve shelves", "rect": [240, 130, 170, 150],
		 "look": "Jars, hand-labelled, no year on any of them.",
		 "actions": [{"type": "search", "label": "Search the shelves", "cost": 1,
			"loot": [{"item": "preserves", "chance": 0.9, "min": 1, "max": 3},
					 {"item": "apples", "chance": 0.4}, {"item": "lamp_oil", "chance": 0.3}]}]},
		{"id": "coal", "name": "Coal store", "rect": [450, 160, 150, 120],
		 "look": "Mostly empty. The floor under it is not level.",
		 "actions": [{"type": "search", "label": "Dig through the coal", "cost": 1,
			"loot": [{"item": "note_marker", "chance": 0.35}, {"item": "fuse", "chance": 0.4},
					 {"item": "wire", "chance": 0.4}, {"item": "crowbar", "chance": 0.25}]}]}
	]
},
}
