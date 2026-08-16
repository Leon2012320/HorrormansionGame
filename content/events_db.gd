extends RefCounted
## Alle Ereignisse als Datentabelle. Siehe docs/EVENTS.md für die Begründungen.
##
## Neues Ereignis anlegen: Eintrag ergänzen, fertig. Kein Code nötig.
##
## Schreibregeln (bitte einhalten):
##   1. Nie ein Wesen benennen — nur Wirkungen.
##   2. Nie erklären.
##   3. Alltäglich, dann falsch.
##   4. Nichts über die Figur behaupten. Sie hat keinen Namen und keine Vergangenheit.
##   5. Keine Option darf offensichtlich die beste sein.
##
## Effekt-Schlüssel: energy · food · condition · heal · damage_safety · cap_safety ·
##                   blow_fuse · steal · steal_item · give · clue · end_night

const NIGHT_WEIGHTS := {
	"sound": 25,
	"wake": 25,
	"damage": 15,
	"theft": 10,
	"mark": 10,
	"clue": 10,
	"move": 5,
}

const EVENTS := [

# ==== WAKE ===================================================================
{"id": "N-W-01", "category": "wake", "weight": 4, "from_day": 2, "max_safety": 2,
 "title": "The Chair",
 "text": "You wake because the room is wrong. The chair from the corner is at the foot of the bed now, turned to face you.",
 "options": [
	{"label": "Put it back", "costs_segment": true, "effects": {}},
	{"label": "Leave it. Don't look at it again.", "costs_segment": false, "effects": {"energy": -1}},
	{"label": "Sit in it", "costs_segment": true, "outcomes": [
		{"weight": 25, "text": "You sit until it gets light. Something comes back to you.", "effects": {"clue": 1}},
		{"weight": 25, "text": "You sit until it gets light.", "effects": {"condition": "shaken"}},
		{"weight": 50, "text": "You sit until it gets light. Nothing happens.", "effects": {}}]}]},

{"id": "N-W-02", "category": "wake", "weight": 5, "from_day": 1, "min_safety": 1,
 "title": "The Door You Locked",
 "text": "The door is open. Not forced — opened. The chair you wedged under the handle has been set neatly against the wall.",
 "options": [
	{"label": "Close it and go back to sleep", "costs_segment": false, "effects": {}},
	{"label": "Barricade it properly", "costs_segment": true, "needs": {"board": 2, "nails": 1},
	 "effects": {}, "sets_safety": 3},
	{"label": "Move to another room", "costs_segment": true, "effects": {}},
	{"label": "Stay awake until morning", "costs_segment": true, "ends_night": true, "effects": {}}]},

{"id": "N-W-03", "category": "wake", "weight": 4, "from_day": 1, "max_light": 1,
 "title": "Breathing",
 "text": "Someone in the room is breathing. Slow, even, patient. When you hold your breath to listen, so do they.",
 "options": [
	{"label": "Turn on the flashlight", "costs_segment": false, "needs": {"battery": 1},
	 "effects": {}, "consumes": {"battery": 1}},
	{"label": "Light a candle", "costs_segment": false, "needs": {"candle": 1, "matches": 1},
	 "effects": {}, "consumes": {"candle": 1}, "places_candle": true},
	{"label": "Lie still and wait", "costs_segment": true, "outcomes": [
		{"weight": 60, "text": "After a long time, it stops.", "effects": {}},
		{"weight": 40, "text": "It does not stop until it is light.", "effects": {"condition": "shaken"}}]}]},

{"id": "N-W-04", "category": "wake", "weight": 3, "from_day": 4, "requires_bed": true,
 "title": "The Weight",
 "text": "The mattress dips beside you. Not much. Just the weight of someone sitting down on the edge, careful not to wake you.",
 "options": [
	{"label": "Don't move", "costs_segment": true, "effects": {}},
	{"label": "Get up", "costs_segment": true, "outcomes": [
		{"weight": 40, "text": "The room is empty. The sheet on that side is warm.", "effects": {"clue": 1}},
		{"weight": 40, "text": "The room is empty.", "effects": {}},
		{"weight": 20, "text": "You do not sleep again.", "effects": {"condition": "shaken"}}]},
	{"label": "Reach out", "costs_segment": false, "outcomes": [
		{"weight": 50, "text": "Something comes back to you, whole and unasked for.", "effects": {"clue": 1}},
		{"weight": 50, "text": "You pull your hand back.", "effects": {"condition": "shaken"}}]}]},

{"id": "N-W-05", "category": "wake", "weight": 4, "from_day": 2, "min_safety": 2,
 "title": "Three Knocks",
 "text": "Three knocks on the boards. Polite. A pause exactly long enough to be an answer. Then three more.",
 "options": [
	{"label": "Knock back", "costs_segment": false, "outcomes": [
		{"weight": 30, "text": "It stops. In the morning there is something written on the other side of the door.", "effects": {"clue": 1}},
		{"weight": 30, "text": "It stops.", "effects": {}},
		{"weight": 40, "text": "It answers. It keeps answering until morning.", "effects": {"energy": -1, "end_night": true}}]},
	{"label": "Say nothing", "costs_segment": true, "effects": {}},
	{"label": "Check the barricade", "costs_segment": true, "effects": {}, "protects_barricade": true}]},

{"id": "N-W-06", "category": "wake", "weight": 3, "from_day": 5,
 "title": "Your Name",
 "text": "Someone downstairs is calling your name. They sound tired. They sound like they have been looking for you for a while.",
 "options": [
	{"label": "Answer", "costs_segment": false, "outcomes": [
		{"weight": 20, "text": "The calling stops. Something else takes its place, briefly, and then that stops too.", "effects": {"clue": 1}},
		{"weight": 30, "text": "It answers you back in your own voice.", "effects": {"condition": "shaken"}},
		{"weight": 50, "text": "Silence, for the rest of the night.", "effects": {}}]},
	{"label": "Go down", "costs_segment": true, "outcomes": [
		{"weight": 40, "text": "There is nobody. There is something on the bottom step.", "effects": {"clue": 1}},
		{"weight": 30, "text": "There is nobody, but the pantry door is open.", "effects": {"give": {"can_beans": 1}}},
		{"weight": 30, "text": "You go down faster than the stairs allow.", "effects": {"condition": "injured"}}]},
	{"label": "Cover your ears", "costs_segment": false, "effects": {"energy": -1}}]},

{"id": "N-W-07", "category": "wake", "weight": 3, "from_day": 1,
 "title": "The Cold",
 "text": "Your breath is showing. The window is shut. It is not that time of year.",
 "options": [
	{"label": "Get the blanket", "costs_segment": true, "needs": {"blanket": 1}, "effects": {}},
	{"label": "Light a fire", "costs_segment": false, "needs": {"board": 1, "matches": 1},
	 "consumes": {"board": 1}, "effects": {}},
	{"label": "Endure it", "costs_segment": true, "outcomes": [
		{"weight": 75, "text": "It passes before morning.", "effects": {}},
		{"weight": 25, "text": "It does not pass.", "effects": {"condition": "sick"}}]}]},

{"id": "N-W-09", "category": "wake", "weight": 3, "from_day": 3,
 "title": "Counting the Stairs",
 "text": "Footsteps on the staircase. You count them without meaning to. The staircase has fourteen steps. You are at twenty-one and they are still coming up.",
 "options": [
	{"label": "Keep counting", "costs_segment": true, "outcomes": [
		{"weight": 35, "text": "At forty it stops. You write the number down without deciding to.", "effects": {"clue": 1}},
		{"weight": 65, "text": "At forty it stops.", "effects": {}}]},
	{"label": "Block the door", "costs_segment": true, "effects": {}, "sets_safety": 2},
	{"label": "Open the door and look", "costs_segment": false, "outcomes": [
		{"weight": 20, "text": "An empty staircase, and something left on the landing.", "effects": {"clue": 1}},
		{"weight": 30, "text": "An empty staircase.", "effects": {"condition": "shaken"}},
		{"weight": 50, "text": "An empty staircase.", "effects": {}}]}]},

{"id": "N-W-10", "category": "wake", "weight": 2, "from_day": 4, "once": true,
 "title": "The Smell of Cooking",
 "text": "Something is cooking. It smells like a proper meal, the kind you have not had in days. The stove has no power.",
 "options": [
	{"label": "Go to the kitchen and eat it", "costs_segment": true,
	 "effects": {"food": 55, "clue": 1, "condition": "shaken"}},
	{"label": "Go and look, but leave it", "costs_segment": true, "effects": {"clue": 1}},
	{"label": "Stay where you are", "costs_segment": false, "effects": {"food": -10}}]},

{"id": "N-W-11", "category": "wake", "weight": 3, "from_day": 2, "requires_window": true,
 "title": "The Window",
 "text": "The window is open. You did not open it. Outside there is no wind, no sound, no insects. It is as if the night is holding still to see what you do.",
 "options": [
	{"label": "Close and latch it", "costs_segment": false, "effects": {}},
	{"label": "Board it up", "costs_segment": true, "needs": {"board": 1, "nails": 1},
	 "consumes": {"board": 1}, "effects": {}, "permanent_safety": 1},
	{"label": "Look out", "costs_segment": false, "outcomes": [
		{"weight": 30, "text": "There is something in the garden that is not a shape you know.", "effects": {"clue": 1}},
		{"weight": 30, "text": "There is nothing, and the nothing goes on a long way.", "effects": {"condition": "shaken"}},
		{"weight": 40, "text": "There is nothing.", "effects": {}}]}]},

{"id": "N-W-12", "category": "wake", "weight": 2, "from_day": 6,
 "title": "Tucked In",
 "text": "The blanket has been pulled up to your chin and folded back. Neatly. The way someone does it for a child.",
 "options": [
	{"label": "Throw it off and get up", "costs_segment": true, "effects": {}},
	{"label": "Go back to sleep", "costs_segment": false, "effects": {"steal": 1}}]},

{"id": "N-W-13", "category": "wake", "weight": 3, "from_day": 5,
 "title": "Something Under the Floor",
 "text": "Under the boards, something shifts its weight. It is not scratching. It is making itself comfortable.",
 "options": [
	{"label": "Pry up a board", "costs_segment": true, "needs": {"crowbar": 1},
	 "effects": {"cap_safety": 2}, "outcomes": [
		{"weight": 35, "text": "There is a space under there, and something in the space.", "effects": {"clue": 1}},
		{"weight": 25, "text": "There is a space under there.", "effects": {"give": {"board": 2}}},
		{"weight": 40, "text": "The board comes up faster than you expected.", "effects": {"condition": "injured"}}]},
	{"label": "Move your bedding", "costs_segment": true, "effects": {}},
	{"label": "Ignore it", "costs_segment": false, "effects": {"energy": -1}}]},

{"id": "N-W-14", "category": "tripline", "weight": 1, "from_day": 1,
 "title": "The Trip Line",
 "text": "The cans go off. Whatever it was, it is on the other side of the door now, and it knows you are awake.",
 "options": [
	{"label": "Hold the door", "costs_segment": true, "effects": {}},
	{"label": "Reinforce it now", "costs_segment": true, "needs": {"board": 2, "nails": 1},
	 "effects": {}, "sets_safety": 3},
	{"label": "Run to another room", "costs_segment": true, "effects": {"steal": 1}}]},

# ==== SOUND ==================================================================
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

# ==== DAMAGE =================================================================
{"id": "N-D-01", "category": "damage", "weight": 4, "from_day": 3, "effects": {"damage_safety": 1},
 "text": "There are marks on the boards. Not deep. Methodical, like someone testing where the wood is thinnest."},
{"id": "N-D-02", "category": "damage", "weight": 3, "from_day": 3, "effects": {"blow_fuse": 1},
 "text": "The fuse has blown. The box is warm."},
{"id": "N-D-03", "category": "damage", "weight": 3, "from_day": 3, "effects": {"steal_item": "preserves"},
 "text": "Two of the jars have burst. The shelf is wet and the cellar smells sweet."},
{"id": "N-D-04", "category": "damage", "weight": 2, "from_day": 3, "effects": {"cap_safety": 2},
 "text": "The window in the next room has cracked from corner to corner. Nothing hit it."},
{"id": "N-D-05", "category": "damage", "weight": 3, "from_day": 3, "effects": {"steal": 1},
 "text": "Water came through the ceiling in the night."},
{"id": "N-D-06", "category": "damage", "weight": 2, "from_day": 3, "effects": {"steal_item": "bread"},
 "text": "The bread has gone. Not eaten — gone the way bread goes in a month, in one night."},

# ==== THEFT ==================================================================
{"id": "N-T-01", "category": "theft", "weight": 4, "from_day": 3, "effects": {"steal_item": "can_beans"},
 "text": "One tin is missing. You counted them last night. You counted them twice."},
{"id": "N-T-02", "category": "theft", "weight": 3, "from_day": 3, "effects": {"steal_item": "hammer"},
 "text": "The hammer is not where you left it."},
{"id": "N-T-03", "category": "theft", "weight": 3, "from_day": 3, "effects": {"steal_item": "battery"},
 "text": "The batteries are flat. All of them. You have not used the flashlight since yesterday."},
{"id": "N-T-04", "category": "theft", "weight": 3, "from_day": 3, "effects": {"steal_item": "matches"},
 "text": "The matches are damp. The box has been sitting in something."},
{"id": "N-T-05", "category": "theft", "weight": 1, "from_day": 6, "effects": {"smudge": 1},
 "text": "A page in your notebook has run. The ink is smeared edge to edge and the paper is damp. You remember writing it. You do not remember what it said."},

# ==== MARK ===================================================================
{"id": "N-M-01", "category": "mark", "weight": 4, "from_day": 2, "effects": {"condition": "injured"},
 "text": "There are four thin scratches along your forearm. They are evenly spaced and they do not hurt yet."},
{"id": "N-M-02", "category": "mark", "weight": 3, "from_day": 2, "effects": {"condition": "sick"},
 "text": "You are burning up. The room is cold and you are soaked through."},
{"id": "N-M-03", "category": "mark", "weight": 3, "from_day": 2, "effects": {"condition": "shaken", "end_night": true},
 "text": "You wake up already sitting, already shouting, and you do not know at what."},
{"id": "N-M-04", "category": "mark", "weight": 2, "from_day": 2, "requires_condition": "injured",
 "effects": {"heal": "injured", "condition": "shaken"},
 "text": "Your hand has been bandaged. Neatly, properly, with a knot you do not tie."},

# ==== MOVE ===================================================================
{"id": "N-V-01", "category": "move", "weight": 3, "from_day": 5, "effects": {"end_night": true, "move_to": "upper_landing"},
 "text": "You wake in the upstairs hall. Your shoes are beside you, set side by side."},
{"id": "N-V-02", "category": "move", "weight": 2, "from_day": 5, "effects": {"end_night": true, "move_to": "entrance", "energy": -1},
 "text": "You wake in front of the door. Your hand is on the handle. It is still locked."},
{"id": "N-V-03", "category": "move", "weight": 2, "from_day": 5, "effects": {"end_night": true, "move_to": "cellar", "drop_carried": true},
 "text": "You wake in the cellar. There is no light and you do not remember the stairs."},

# ==== CLUE ===================================================================
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

# ==== TAG: AMBIENT ===========================================================
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

# ==== TAG: SUPPLY ============================================================
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
## Es wird nie ein Datum genannt.
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
