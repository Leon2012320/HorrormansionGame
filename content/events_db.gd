extends RefCounted

const ItemsDB := preload("res://content/items_db.gd")

## Alle Ereignisse als Datentabelle. Begründungen in docs/EVENTS.md.
##
## GRUNDPRINZIP: Problem-Ereignisse werden mit GEGENSTÄNDEN gelöst, nicht mit
## Entscheidungen. Das Spiel fragt nicht, was du tun willst — es fragt, was du
## dabei hast. Die Entscheidung fiel am Tag, beim Packen der sechs Slots.
##
## Aufbau eines Problem-Ereignisses:
##   "solutions": [ {"needs": {...}, "tool": "...", "text": "...", "effects": {...}} ]
##       needs  — wird VERBRAUCHT
##       tool   — muss dabei sein, bleibt aber erhalten
##       Beides muss vorhanden sein, damit die Lösung angeboten wird.
##   "unsolved": {"text": "...", "effects": {...}}
##       Was passiert, wenn nichts davon dabei ist.
##
## Schreibregeln:
##   1. Nie ein Wesen benennen — nur Wirkungen.
##   2. Nie erklären.
##   3. Alltäglich, dann falsch.
##   4. Nichts über die Figur behaupten.
##   5. Die Lösung muss die sein, auf die man von selbst kommt.
##
## Effekt-Schlüssel: energy · food · condition · heal · damage_safety · set_safety ·
##   permanent_safety · cap_safety · blow_fuse · steal · steal_item · steal_food ·
##   give · clue · end_night · lose_segment · light · spoil_perishables · move_to

const NIGHT_WEIGHTS := {
	"problem": 40,
	"sound": 25,
	"damage": 10,
	"theft": 10,
	"clue": 10,
	"move": 5,
}

const EVENTS := [

# ============================================================================
# PROBLEM — mit Gegenständen lösbar
# ============================================================================

{"id": "N-P-01", "category": "problem", "weight": 5, "from_day": 3, "min_safety": 2,
 "title": "The Boards",
 "text": "Something is working at the boards across the door. Not forcing them. Testing where the wood is thinnest.",
 "solutions": [
	{"needs": {"board": 1}, "tool": "hammer",
	 "text": "You nail it back while it is still on the other side. It stops.", "effects": {}},
	{"tool": "crowbar",
	 "text": "You jam the bar under the handle. It holds until morning.", "effects": {}}],
 "unsolved": {"text": "By morning two of the boards are on the floor.",
	"effects": {"damage_safety": 2, "lose_segment": true}}},

{"id": "N-P-02", "category": "problem", "weight": 5, "from_day": 1, "min_safety": 1,
 "title": "The Door Standing Open",
 "text": "The door is open. Not forced — opened. Whatever you wedged under the handle has been set neatly against the wall.",
 "solutions": [
	{"needs": {"board": 2, "nails": 1}, "tool": "hammer",
	 "text": "You board it properly this time. Nothing else happens.", "effects": {"set_safety": 3}},
	{"tool": "padlock_chain",
	 "text": "The chain goes on. This door is finished being a door.", "effects": {"set_safety": 3}},
	{"tool": "trip_line",
	 "text": "You string the cans across it. If it comes back you will hear it.", "effects": {}}],
 "unsolved": {"text": "You close it again and lie awake. In the morning something is missing.",
	"effects": {"energy": -1, "steal": 1}}},

{"id": "N-P-03", "category": "problem", "weight": 5, "from_day": 1, "max_light": 1,
 "title": "Breathing in the Dark",
 "text": "Someone in the room is breathing. Slow, even, patient. When you hold your breath to listen, so do they.",
 "solutions": [
	{"needs": {"candle": 1}, "tool": "matches",
	 "text": "The room is empty. The candle burns down beside you.", "effects": {"light": 2}},
	{"needs": {"battery": 1}, "tool": "flashlight",
	 "text": "The room is empty. You leave the beam on the ceiling.", "effects": {"light": 1}},
	{"needs": {"lamp_oil": 1}, "tool": "lantern",
	 "text": "The room is empty, and it stays lit until morning.", "effects": {"light": 2}}],
 "unsolved": {"text": "It keeps time with you until it is light.",
	"effects": {"condition": "shaken", "lose_segment": true}}},

{"id": "N-P-04", "category": "problem", "weight": 4, "from_day": 2,
 "title": "The Cold",
 "text": "Your breath is showing. The window is shut. It is not that time of year.",
 "solutions": [
	{"tool": "blanket", "text": "You pull the blanket over your head and sleep through it.", "effects": {}},
	{"needs": {"board": 1}, "tool": "matches",
	 "text": "A small fire. The room is warm by morning.", "effects": {}},
	{"needs": {"whiskey": 1},
	 "text": "It helps with the cold. It does not help with the morning.",
	 "effects": {"energy": -1}}],
 "unsolved": {"text": "You shiver until it is light.",
	"effects": {"condition": "sick", "lose_segment": true}}},

{"id": "N-P-05", "category": "problem", "weight": 4, "from_day": 2,
 "title": "The Cut",
 "text": "You wake up bleeding. Four thin lines along the forearm, evenly spaced. They did not hurt until you looked at them.",
 "solutions": [
	{"needs": {"bandage": 1}, "text": "Cleaned and wrapped. It will hold.", "effects": {}},
	{"needs": {"whiskey": 1},
	 "text": "You wash it out with what you have. It will scar.",
	 "effects": {"condition": "injured"}}],
 "unsolved": {"text": "You have nothing to put on it.",
	"effects": {"condition": "injured"}}},

{"id": "N-P-06", "category": "problem", "weight": 3, "from_day": 4, "requires_fuse": true,
 "title": "The Fuse",
 "text": "Everything electric goes out at once. The box in the cellar is warm to the touch.",
 "solutions": [
	{"needs": {"fuse": 1}, "tool": "screwdriver",
	 "text": "Replaced. The light comes back on and stays on.", "effects": {}},
	{"needs": {"fuse": 1},
	 "text": "You get it in without the screwdriver, and open your hand doing it.",
	 "effects": {"condition": "injured"}}],
 "unsolved": {"text": "It stays dark.", "effects": {"blow_fuse": 1}}},

{"id": "N-P-07", "category": "problem", "weight": 4, "from_day": 2, "requires_window": true,
 "title": "The Window",
 "text": "The window is open. You did not open it. Outside there is no wind, no sound, no insects — as if the night is holding still to see what you do.",
 "solutions": [
	{"needs": {"board": 1, "nails": 1}, "tool": "hammer",
	 "text": "Boarded over. That window is done.", "effects": {"permanent_safety": 1}},
	{"tool": "crowbar",
	 "text": "You wedge it shut. It will do for tonight.", "effects": {}}],
 "unsolved": {"text": "It will not latch, and the room does not get warm again.",
	"effects": {"energy": -1}}},

{"id": "N-P-08", "category": "problem", "weight": 4, "from_day": 5, "ground_or_cellar": true,
 "title": "Something Under the Floor",
 "text": "Under the boards, something shifts its weight. It is not scratching. It is making itself comfortable.",
 "solutions": [
	{"tool": "crowbar",
	 "text": "You lift a board. There is a space under there, and something in the space.",
	 "effects": {"clue": 1}},
	{"needs": {"trap": 1},
	 "text": "You set the snare over the gap. In the morning it has gone off.",
	 "effects": {"food": 25}}],
 "unsolved": {"text": "It settles in for the night, and so do you, and only one of you sleeps.",
	"effects": {"energy": -1, "lose_segment": true}}},

{"id": "N-P-09", "category": "problem", "weight": 4, "from_day": 4, "requires_food_stock": true,
 "title": "In the Stores",
 "text": "Something is in the stores. You can hear the tins moving against each other, unhurried, one at a time.",
 "solutions": [
	{"needs": {"trap": 1},
	 "text": "The snare goes off before you are properly awake. Nothing is missing.",
	 "effects": {"food": 25}},
	{"tool": "trip_line", "consumes_tool": true,
	 "text": "The cans come down. Whatever it was, it does not come back.", "effects": {}}],
 "unsolved": {"text": "In the morning the count is short.",
	"effects": {"steal_food": 2}}},

{"id": "N-P-10", "category": "problem", "weight": 3, "from_day": 6,
 "title": "The Lock",
 "text": "The door you came through will not open from this side. It has no lock. It has never had a lock.",
 "solutions": [
	{"tool": "crowbar",
	 "text": "It comes open with the frame attached.", "effects": {"cap_safety": 1}},
	{"tool": "lockpicks",
	 "text": "There is nothing to pick, and it opens anyway.", "effects": {}},
	{"needs": {"board": 1}, "tool": "hammer",
	 "text": "You go through the panelling beside it. Loud, but it works.", "effects": {}}],
 "unsolved": {"text": "You sit against the wall until it is light, and then it opens.",
	"effects": {"end_night": true, "energy": -2}}},

{"id": "N-P-11", "category": "problem", "weight": 3, "from_day": 5,
 "title": "The Damp",
 "text": "Water is coming through the ceiling, exactly and only above the place where you keep your things.",
 "solutions": [
	{"needs": {"rag": 1}, "text": "Caught and covered. Everything stays dry.", "effects": {}},
	{"tool": "blanket",
	 "text": "You throw the blanket over your things and go cold yourself.",
	 "effects": {"energy": -1}}],
 "unsolved": {"text": "By morning something has been sitting in water for hours.",
	"effects": {"steal": 1}}},

{"id": "N-P-12", "category": "problem", "weight": 3, "from_day": 6, "requires_perishables": true,
 "title": "Rot",
 "text": "There is a smell. Everything soft you own has turned overnight, and it has turned further than one night allows.",
 "solutions": [
	{"needs": {"preserves": 1},
	 "text": "You sort it out in time. One jar goes, the rest holds.", "effects": {}},
	{"kitchen_powered": true,
	 "text": "What was standing in the cold pantry has kept.", "effects": {}}],
 "unsolved": {"text": "All of it is gone.", "effects": {"spoil_perishables": true}}},

{"id": "N-P-13", "category": "problem", "weight": 3, "from_day": 4, "requires_condition": "sick",
 "title": "The Fever",
 "text": "You are burning up. The room is cold and you are soaked through, and you cannot tell which of those two things is the wrong one.",
 "solutions": [
	{"needs": {"pills": 1}, "text": "It breaks before morning.", "effects": {"heal": "sick"}},
	{"needs": {"morphine": 1}, "text": "Everything goes quiet, including the fever.",
	 "effects": {"heal": "sick", "energy": -1}}],
 "unsolved": {"text": "It does not break.",
	"effects": {"heal": "sick", "condition": "fevered"}}},

{"id": "N-P-14", "category": "problem", "weight": 4, "from_day": 3,
 "title": "Scratching at the Cellar Door",
 "text": "Something is at the cellar door. Not knocking. Testing.",
 "solutions": [
	{"needs": {"board": 2, "nails": 1}, "tool": "hammer",
	 "text": "You nail the cellar door shut. Whatever is down there stays down there.", "effects": {}},
	{"tool": "trip_line", "consumes_tool": true,
	 "text": "The cans come down and it goes away.", "effects": {}},
	{"needs": {"candle": 1}, "tool": "matches",
	 "text": "You put a light in the hall. It stops.", "effects": {}}],
 "unsolved": {"text": "It works at it most of the night.",
	"effects": {"damage_safety": 1, "energy": -1}}},

{"id": "N-P-15", "category": "problem", "weight": 3, "from_day": 6, "requires_bed": true,
 "title": "The Weight",
 "text": "The mattress dips beside you. Not much. Just the weight of someone sitting down on the edge, careful not to wake you.",
 "solutions": [
	{"needs": {"candle": 1}, "tool": "matches",
	 "text": "There is nobody. That side of the bed is warm, and you write down why that matters.",
	 "effects": {"clue": 1}},
	{"needs": {"whiskey": 1}, "text": "You drink until it does not matter.",
	 "effects": {"energy": -1}}],
 "unsolved": {"text": "It sits there until it is light.",
	"effects": {"condition": "shaken", "end_night": true}}},

{"id": "N-P-16", "category": "problem", "weight": 2, "from_day": 5, "once": true,
 "title": "The Smell of Cooking",
 "text": "Something is cooking. It smells like a proper meal, the kind you have not had in days. The stove has no power.",
 "solutions": [
	{"needs": {"can_beans": 1}, "text": "You eat your own, cold, in the dark, and do not go and look.",
	 "effects": {"food": 35}},
	{"needs": {"can_meat": 1}, "text": "You eat your own, cold, in the dark, and do not go and look.",
	 "effects": {"food": 40}}],
 "unsolved": {"text": "You go down and eat what is on the table. It is very good.",
	"effects": {"food": 55, "clue": 1, "condition": "shaken"}}},

# ============================================================================
# SOUND — nicht lösbar, folgenlos
# ============================================================================

{"id": "N-S-01", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "Water running somewhere below. It stops when you notice it."},
{"id": "N-S-02", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "A door closes, two floors down. Then again. Then again, more quietly."},
{"id": "N-S-03", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "Something is dragged across the ceiling, corner to corner, and back."},
{"id": "N-S-04", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "A chair scrapes in the room next to yours. There is no chair in that room."},
{"id": "N-S-05", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "Someone is humming. It is a tune you know, but not from anywhere you can name."},
{"id": "N-S-06", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "The house settles. It settles again. It settles in perfect rhythm, like breathing."},
{"id": "N-S-07", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "A cough. Close. Politely muffled, the way you cough in a room where someone is sleeping."},
{"id": "N-S-08", "category": "sound", "weight": 3, "from_day": 2, "effects": {"energy": -1},
 "text": "Footsteps on the stairs, going down. They stop halfway and do not continue."},

# ============================================================================
# DAMAGE / THEFT / MOVE / CLUE — nicht lösbar
# ============================================================================

{"id": "N-D-01", "category": "damage", "weight": 3, "from_day": 4, "effects": {"steal_item": "preserves"},
 "text": "Two of the jars have burst. The shelf is wet and the cellar smells sweet."},
{"id": "N-D-02", "category": "damage", "weight": 2, "from_day": 4, "effects": {"cap_safety": 2},
 "text": "The window in the next room has cracked from corner to corner. Nothing hit it."},
{"id": "N-D-03", "category": "damage", "weight": 3, "from_day": 4, "effects": {"damage_safety": 1},
 "text": "The boards have come away at one corner. The nails are on the floor, in a row."},

{"id": "N-T-01", "category": "theft", "weight": 4, "from_day": 4, "effects": {"steal_food": 1},
 "text": "One tin is missing. You counted them last night. You counted them twice."},
{"id": "N-T-02", "category": "theft", "weight": 3, "from_day": 4, "effects": {"steal_item": "hammer"},
 "text": "The hammer is not where you left it."},
{"id": "N-T-03", "category": "theft", "weight": 3, "from_day": 4, "effects": {"steal_item": "battery"},
 "text": "The batteries are flat. All of them. You have not used the flashlight since yesterday."},
{"id": "N-T-04", "category": "theft", "weight": 3, "from_day": 4, "effects": {"steal_item": "matches"},
 "text": "The matches are damp. The box has been sitting in something."},
{"id": "N-T-05", "category": "theft", "weight": 1, "from_day": 6, "effects": {"smudge": 1},
 "text": "A page in your notebook has run. The ink is smeared edge to edge and the paper is damp. You remember writing it. You do not remember what it said."},

{"id": "N-V-01", "category": "move", "weight": 3, "from_day": 5, "effects": {"end_night": true, "move_to": "upper_landing"},
 "text": "You wake in the upstairs hall. Your shoes are beside you, set side by side."},
{"id": "N-V-02", "category": "move", "weight": 2, "from_day": 5, "effects": {"end_night": true, "move_to": "entrance", "energy": -1},
 "text": "You wake in front of the door. Your hand is on the handle. It is still locked."},
{"id": "N-V-03", "category": "move", "weight": 2, "from_day": 5, "effects": {"end_night": true, "move_to": "cellar", "drop_carried": true},
 "text": "You wake in the cellar. There is no light and you do not remember the stairs."},

{"id": "N-C-01", "category": "clue", "weight": 4, "from_day": 2, "effects": {"clue": 1},
 "text": "There is writing on the last page of your notebook. It is your handwriting. It is not your sentence."},
{"id": "N-C-02", "category": "clue", "weight": 2, "from_day": 2, "effects": {"reveal_room": 1},
 "text": "You dreamed about a room in this house. You have not been in it yet. You know where the door is."},
{"id": "N-C-03", "category": "clue", "weight": 3, "from_day": 2, "effects": {"clue": 1},
 "text": "A word has been written in the dust on the floor. It is a name, or half of one."},
{"id": "N-C-04", "category": "clue", "weight": 3, "from_day": 2, "effects": {"clue": 1},
 "text": "You remember something clearly that you know you did not do."},
{"id": "N-C-05", "category": "clue", "weight": 2, "from_day": 2, "effects": {"clue": 1},
 "text": "There is a note under the door. The paper is old. The ink is not."},

# ============================================================================
# TAG
# ============================================================================

{"id": "D-A-01", "category": "ambient", "weight": 3, "from_day": 1, "effects": {},
 "text": "The picture in the hall is crooked. You straighten it. Later, it is crooked again."},
{"id": "D-A-02", "category": "ambient", "weight": 3, "from_day": 1, "effects": {},
 "text": "There are footprints in the dust. Your size. Facing the other way."},
{"id": "D-A-03", "category": "ambient", "weight": 3, "from_day": 1, "effects": {},
 "text": "The hall clock is running. It was not running yesterday and there is no key for it."},
{"id": "D-A-04", "category": "ambient", "weight": 3, "from_day": 1, "effects": {},
 "text": "The seat of the armchair is warm."},
{"id": "D-A-05", "category": "ambient", "weight": 3, "from_day": 1, "effects": {},
 "text": "Every door upstairs is open. You closed them all this morning."},
{"id": "D-A-06", "category": "ambient", "weight": 3, "from_day": 1, "effects": {},
 "text": "You can hear yourself moving around upstairs."},

{"id": "D-S-01", "category": "supply", "weight": 4, "from_day": 1, "effects": {"give": {"can_beans": 1}},
 "text": "Something has rolled behind the dresser and been there a long time."},
{"id": "D-S-02", "category": "supply", "weight": 3, "from_day": 1, "effects": {"give": {"matches": 1}},
 "text": "There is a box of matches in the coat by the door. The coat is not yours."},
{"id": "D-S-03", "category": "supply", "weight": 3, "from_day": 1, "effects": {"give": {"nails": 1, "wire": 1}},
 "text": "A toolbox under the workbench, closed with a latch that still works."},
{"id": "D-S-04", "category": "supply", "weight": 3, "from_day": 1, "effects": {"give": {"candle": 3}},
 "text": "A drawer of candle stubs. Household candles, kept for power cuts."},
{"id": "D-S-05", "category": "supply", "weight": 2, "from_day": 1, "effects": {"give": {"bandage": 1, "can_meat": 1, "battery": 1}},
 "text": "Somebody kept a bag packed by the back door."},
]


## Die Radio-Staffel: die einzige Vorwarnung auf die Rettung an Tag 20.
const RADIO := [
	{"from_day": 1, "text": "\"...scattered showers through the county, clearing towards the weekend...\""},
	{"from_day": 3, "text": "\"...police are asking motorists to avoid the old county road following an incident...\""},
	{"from_day": 5, "text": "\"...a vehicle was recovered abandoned near the Ashgrove turning. The owner has not been traced...\""},
	{"from_day": 8, "text": "\"...now being treated as a missing person enquiry...\""},
	{"from_day": 11, "text": "\"...the search has been scaled back after almost two weeks without...\" Then static."},
	{"from_day": 14, "text": "\"...following new information, officers will begin searching properties on the estate itself...\""},
	{"from_day": 17, "text": "No words. A helicopter, a long way off, but real."},
	{"from_day": 19, "text": "Vehicles on the gravel. Engines being switched off. Then nothing."},
	{"from_day": 20, "text": "Voices outside. Several. They are calling."},
]
