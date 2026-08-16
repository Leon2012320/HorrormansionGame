extends RefCounted
## Die 16 einmaligen Fundstücke. Siehe docs/SPECIAL_ITEMS.md.
##
## Pro Durchlauf erscheinen nur PICKS davon, gewichtet gezogen und zufällig
## auf ihre zulässigen Fundorte verteilt. Mindestens eines aus Gruppe A ist
## immer dabei — sonst besteht ein Durchlauf nur aus Glücksspiel und Notausgängen.
##
## Ein Sonder-Item gibt nie einfach mehr Ressourcen. Es ändert eine Regel.

const PICKS := 5

## use: "passive" wirkt, solange man es hat · "place" wird irgendwo angebracht ·
##      "consume" wird einmal benutzt und ist weg
const SPECIALS := {
# --- Gruppe A: ändern eine Regel dauerhaft ----------------------------------
"padlock_chain": {
	"name": "Padlock and chain", "group": "A", "weight": 4, "use": "place",
	"rooms": ["cellar", "attic", "entrance"],
	"found": "A chain and a padlock, both heavier than they need to be. The key is in the lock and turns easily, which is somehow worse.",
	"prompt": "Which door? It will never come off again.",
	"done": "The chain goes on. This door is finished being a door."},
"camp_stove": {
	"name": "Paraffin stove", "group": "A", "weight": 3, "use": "passive",
	"rooms": ["kitchen", "cellar", "attic"],
	"found": "A little two-burner stove, the kind you take camping. There is still fuel in it.",
	"note": "You can cook anywhere now, as long as there is oil."},
"car_battery": {
	"name": "Car battery", "group": "A", "weight": 2, "use": "place", "days": 6,
	"rooms": ["cellar", "attic"],
	"found": "A car battery on the workbench, wired to nothing. The terminals are clean. Someone was maintaining it.",
	"prompt": "Which room? It will hold for about six days.",
	"done": "It takes the light. Nobody is counting the days but you."},
"lockpicks": {
	"name": "Set of picks", "group": "A", "weight": 3, "use": "passive",
	"rooms": ["study", "bedroom", "parlor"],
	"found": "Rolled in a strip of felt, worn smooth at the handles. Not a professional set. Someone taught themselves.",
	"note": "Doors open without breaking them now."},
"alarm_clock": {
	"name": "Alarm clock", "group": "A", "weight": 3, "use": "passive",
	"rooms": ["bedroom", "study", "nursery"],
	"found": "A wind-up alarm clock. It has been keeping time. You did not wind it.",
	"note": "You will not wake up anywhere you did not lie down. But it is loud."},

# --- Gruppe B: Einmalverbrauch mit hartem Tausch -----------------------------
"sleeping_pills": {
	"name": "Sleeping pills", "group": "B", "weight": 4, "use": "consume",
	"rooms": ["bathroom", "bedroom"],
	"found": "Prescribed to someone whose name has been scratched off the label.",
	"note": "One night without waking. Everything else still happens."},
"smelling_salts": {
	"name": "Smelling salts", "group": "B", "weight": 3, "use": "consume",
	"rooms": ["bathroom", "study"],
	"found": "A small glass tube in a metal case. Military issue, from a war that was over before this house was empty.",
	"note": "Two more actions today. Two fewer tomorrow."},
"morphine": {
	"name": "Ampoule", "group": "B", "weight": 2, "use": "consume",
	"rooms": ["bathroom", "cellar"],
	"found": "One ampoule left in a tin made for six.",
	"note": "It will take away anything. For two days you will pay for it."},
"flare": {
	"name": "Signal flare", "group": "B", "weight": 2, "use": "consume",
	"rooms": ["cellar", "attic", "conservatory"],
	"found": "A signal flare in a waxed paper tube. The instructions are printed in three languages, none of them helpful.",
	"note": "Somebody has to be looking for it to work."},
"jar_unlabelled": {
	"name": "Unlabelled jar", "group": "B", "weight": 3, "use": "consume",
	"rooms": ["cellar", "kitchen"],
	"found": "Sealed, heavy, and the contents do not move when you tilt it.",
	"note": "Opening it is eating it."},

# --- Gruppe C: tragen Geschichte ---------------------------------------------
"visitors_book": {
	"name": "Visitors' book", "group": "C", "weight": 3, "use": "consume",
	"rooms": ["entrance", "library"],
	"found": "Names and dates in a dozen different hands, going back forty years. The last entry is today's date. The handwriting is yours."},
"covered_mirror": {
	"name": "Covered mirror", "group": "C", "weight": 3, "use": "consume",
	"rooms": ["bathroom", "bedroom", "parlor"],
	"found": "A mirror with a sheet over it, tied at the back. Someone did this deliberately, and they took the time to do it properly.",
	"note": "Two fragments under the sheet. The room will never feel closed again."},
"second_flashlight": {
	"name": "The other flashlight", "group": "C", "weight": 2, "use": "passive",
	"rooms": ["entrance", "parlor", "library", "kitchen", "bedroom", "cellar"],
	"found": "A flashlight, the same make as yours, the same scratch across the lens. Yours is still in your hand.",
	"note": "It does not need batteries. Nothing else about it is explained."},
"childs_drawing": {
	"name": "Child's drawing", "group": "C", "weight": 2, "use": "consume",
	"rooms": ["nursery", "library", "attic"],
	"found": "A room drawn from above, the way children draw rooms — all four walls folded flat. There is a cross in one corner. The proportions are exactly right."},
"warm_key": {
	"name": "A key that is warm", "group": "C", "weight": 2, "use": "consume",
	"rooms": ["entrance", "parlor", "study", "bedroom", "cellar"],
	"found": "An ordinary door key, worn at the edges. It is warm, and it stays warm, and it is warmer than your hand."},
"photograph_now": {
	"name": "Photograph", "group": "C", "weight": 2, "use": "consume",
	"rooms": ["entrance", "parlor", "library", "dining", "study", "bedroom"],
	"found": "A photograph of the room you are standing in, taken from exactly where you are standing. The room in the photograph is empty."},
}
