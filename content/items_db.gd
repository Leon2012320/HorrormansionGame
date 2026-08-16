extends RefCounted
## Alle Gegenstände als reine Datentabelle.
##
## Neuen Gegenstand anlegen: hier einen Eintrag ergänzen und ein 32x32-PNG
## unter assets/items/<id>.png ablegen. Kein Code nötig.
## Werte stammen aus docs/ITEMS.md.

const ITEMS := {
	# --- Essen ---------------------------------------------------------------
	"can_beans": {"name": "Tin of beans", "category": "food", "food": 35, "stack": 4, "leaves_empty_tin": true},
	"can_meat": {"name": "Tin of meat", "category": "food", "food": 40, "stack": 4, "leaves_empty_tin": true},
	"can_soup": {"name": "Tin of soup", "category": "food", "food": 30, "stack": 4, "leaves_empty_tin": true, "cooks_to": "meal_hot"},
	"preserves": {"name": "Jar of preserves", "category": "food", "food": 30, "stack": 3, "fragile": true},
	"bread": {"name": "Stale bread", "category": "food", "food": 25, "stack": 2, "spoils_after": 2},
	"apples": {"name": "Withered apples", "category": "food", "food": 20, "stack": 3, "spoils_after": 3},
	"chocolate": {"name": "Bar of chocolate", "category": "food", "food": 15, "stack": 3, "energy": 1},
	"meal_hot": {"name": "Hot meal", "category": "food", "food": 55, "stack": 1, "hot": true},
	"water_bottle": {"name": "Bottle of water", "category": "food", "food": 10, "stack": 3},
	"food_spoiled": {"name": "Spoiled food", "category": "food", "food": 10, "stack": 3, "sick_chance": 0.6},
	"crop_ripe": {"name": "Crop", "category": "food", "food": 50, "stack": 3},
	"catch_raw": {"name": "Raw catch", "category": "food", "food": 25, "stack": 2, "sick_chance": 0.2, "cooks_to": "meal_hot"},

	# --- Licht ---------------------------------------------------------------
	"flashlight": {"name": "Flashlight", "category": "light", "stack": 1},
	"battery": {"name": "Battery", "category": "light", "stack": 6},
	"candle": {"name": "Candle", "category": "light", "stack": 5},
	"matches": {"name": "Box of matches", "category": "light", "stack": 3, "uses": 8},
	"lantern": {"name": "Oil lantern", "category": "light", "stack": 1},
	"lamp_oil": {"name": "Can of lamp oil", "category": "light", "stack": 2},
	"fuse": {"name": "Fuse", "category": "light", "stack": 5},
	"bulb": {"name": "Light bulb", "category": "light", "stack": 4},

	# --- Bauen ---------------------------------------------------------------
	"hammer": {"name": "Hammer", "category": "build", "stack": 1},
	"board": {"name": "Wooden board", "category": "build", "stack": 6},
	"nails": {"name": "Box of nails", "category": "build", "stack": 3},
	"crowbar": {"name": "Crowbar", "category": "build", "stack": 1},
	"screwdriver": {"name": "Screwdriver", "category": "build", "stack": 1},
	"rope": {"name": "Length of rope", "category": "build", "stack": 2},
	"can_empty": {"name": "Empty tin", "category": "build", "stack": 6},
	"rag": {"name": "Oily rag", "category": "build", "stack": 3},
	"wire": {"name": "Coil of wire", "category": "build", "stack": 3},
	"trip_line": {"name": "Trip line", "category": "build", "stack": 2},

	# --- Anbau ---------------------------------------------------------------
	"seeds": {"name": "Packet of seeds", "category": "farm", "stack": 4},
	"watering_can": {"name": "Watering can", "category": "farm", "stack": 1},

	# --- Gesundheit ----------------------------------------------------------
	"bandage": {"name": "First aid tin", "category": "medical", "stack": 3, "heals": ["injured", "bleeding"]},
	"pills": {"name": "Bottle of pills", "category": "medical", "stack": 3, "heals": ["sick", "fevered"]},
	"whiskey": {"name": "Bottle of whiskey", "category": "medical", "stack": 2, "heals": ["shaken"], "energy_next_day": -1},
	"blanket": {"name": "Wool blanket", "category": "medical", "stack": 1},

	# --- Schlüssel -----------------------------------------------------------
	"key_cellar": {"name": "Cellar key", "category": "key", "stack": 1},
	"key_study": {"name": "Small brass key", "category": "key", "stack": 1},
	"key_attic": {"name": "Attic key", "category": "key", "stack": 1},

	# --- Hinweise (belegen keinen Slot) --------------------------------------
	"note_ledger": {"name": "Household ledger", "category": "clue", "question": 0},
	"note_letter_a": {"name": "Unsent letter", "category": "clue", "question": 0},
	"note_marks": {"name": "Tally on a doorframe", "category": "clue", "question": 0},
	"note_receipt": {"name": "Repair receipt", "category": "clue", "question": 1},
	"note_floorplan": {"name": "Floor plan, amended", "category": "clue", "question": 1},
	"note_damp": {"name": "Surveyor's note", "category": "clue", "question": 1},
	"photo_family": {"name": "Family photograph", "category": "clue", "question": 2},
	"photo_wrong": {"name": "The same photograph, later", "category": "clue", "question": 2},
	"note_inventory": {"name": "List of belongings", "category": "clue", "question": 2},
	"note_deed": {"name": "Deed to the house", "category": "clue", "question": 3},
	"note_marker": {"name": "Rubbing from a marker", "category": "clue", "question": 3},
	"book_page": {"name": "Torn page", "category": "clue", "question": 3},

	# --- Rückgabe-Gegenstände ------------------------------------------------
	"ring": {"name": "Wedding ring", "category": "token", "stack": 1},
	"doll": {"name": "Cloth doll", "category": "token", "stack": 1},
	"locket": {"name": "Locket with a picture", "category": "token", "stack": 1},
	"pocket_watch": {"name": "Pocket watch, stopped", "category": "token", "stack": 1},
}


## Die vier Bau-Rezepte. Mehr Crafting gibt es nicht.
const RECIPES := {
	"barricade": {"name": "Board up the door", "cost": 2, "needs": {"board": 2, "nails": 1}, "tool": "hammer"},
	"trip_line": {"name": "Build a trip line", "cost": 1, "needs": {"rope": 1, "can_empty": 2}, "gives": "trip_line"},
	"snare": {"name": "Build a snare", "cost": 1, "needs": {"board": 1, "wire": 1}, "gives": "trap"},
	"torch": {"name": "Make a torch", "cost": 1, "needs": {"board": 1, "rag": 1, "matches": 1}, "gives": "torch"},
}
