extends Node
## Das Notizbuch: Fragmente sammeln, vier Fragen beantworten, Ende bestimmen.
##
## Die Fragen fragen nach REGELN, nie nach Identität — siehe GAME_DESIGN 6.
## Die richtige Kombination wird pro Durchlauf neu gewürfelt.

signal fragment_added(question: int, total: int)
signal answer_set(question: int, answer: String)
## Feuert, wenn ein Fragment eine Antwort ausschließt — dafür gibt es den Text
## "Whatever it is, it is not X." im Spiel.
signal answer_excluded(question: int, answer: String)

const FRAGMENTS_PER_QUESTION := 3

const QUESTIONS := [
	"What does it take from you?",
	"Which room is the wrong one?",
	"What has to go back?",
	"Where does it have to go?",
]

## Antwortmöglichkeiten je Frage. Eine davon ist pro Durchlauf richtig.
const ANSWERS := [
	["Time", "Warmth", "What you were carrying", "The way back"],
	["The nursery", "The cellar", "The study", "The room you sleep in"],
	["A wedding ring", "A cloth doll", "A locket", "A stopped watch"],
	["The cellar floor", "The conservatory ground", "The nursery hearth", "Behind the front door"],
]

var fragments := [0, 0, 0, 0]
var answers := ["", "", "", ""]
var solution := [0, 0, 0, 0]
## Pro Frage die Antworten, die durch Fragmente ausgeschlossen wurden.
## Drei Fragmente schließen drei von vier Möglichkeiten aus — wer alle
## findet, weiß die Antwort. Wer zwei hat, steht vor einer Münze.
var excluded: Array = [[], [], [], []]


func _ready() -> void:
	reset()


func reset() -> void:
	fragments = [0, 0, 0, 0]
	answers = ["", "", "", ""]
	solution = []
	excluded = []
	for i in QUESTIONS.size():
		var options: Array = ANSWERS[i]
		solution.append(randi() % options.size())
		excluded.append([])


## Fügt ein Fragment hinzu. Ohne Argument geht es an die Frage, die
## am wenigsten hat — so läuft der Spieler nie in eine Sackgasse.
func add_fragment(question: int = -1) -> int:
	var target := question
	if target < 0 or target >= fragments.size():
		target = 0
		for i in fragments.size():
			if fragments[i] < fragments[target]:
				target = i
	if fragments[target] >= FRAGMENTS_PER_QUESTION:
		for i in fragments.size():
			if fragments[i] < FRAGMENTS_PER_QUESTION:
				target = i
				break
	fragments[target] = mini(fragments[target] + 1, FRAGMENTS_PER_QUESTION)
	_exclude_one(target)
	fragment_added.emit(target, total_fragments())
	return target


## Streicht eine falsche Antwort. Nie die richtige — ein Fragment nimmt
## dir immer etwas weg, nie die Lösung selbst.
func _exclude_one(question: int) -> void:
	var options: Array = ANSWERS[question]
	var candidates: Array[int] = []
	for i in options.size():
		if i != int(solution[question]) and not i in excluded[question]:
			candidates.append(i)
	if candidates.is_empty():
		return
	var picked: int = candidates[randi() % candidates.size()]
	excluded[question].append(picked)
	answer_excluded.emit(question, str(options[picked]))


func is_excluded(question: int, index: int) -> bool:
	return index in excluded[question]


## Welche Antworten sind für diese Frage noch im Rennen?
func remaining_answers(question: int) -> Array[int]:
	var result: Array[int] = []
	var options: Array = ANSWERS[question]
	for i in options.size():
		if not is_excluded(question, i):
			result.append(i)
	return result


## Macht ein Fragment unleserlich (Ereignis N-T-05). Trifft nie das letzte
## Fragment einer Frage — der Spieler soll nie eine fertige Antwort verlieren.
func smudge_fragment() -> bool:
	for i in fragments.size():
		if fragments[i] > 0 and fragments[i] < FRAGMENTS_PER_QUESTION:
			fragments[i] -= 1
			return true
	return false


func total_fragments() -> int:
	var sum := 0
	for f in fragments:
		sum += int(f)
	return sum


func can_answer(question: int) -> bool:
	return fragments[question] >= FRAGMENTS_PER_QUESTION


func set_answer(question: int, index: int) -> void:
	if not can_answer(question):
		return
	answers[question] = ANSWERS[question][index]
	answer_set.emit(question, answers[question])


func all_answered() -> bool:
	for a in answers:
		if str(a) == "":
			return false
	return true


## Deckt eine Antwort direkt auf — das Sonder-Item `childs_drawing`.
func reveal_answer(question: int) -> void:
	fragments[question] = FRAGMENTS_PER_QUESTION
	set_answer(question, solution[question])


func correct_count() -> int:
	var correct := 0
	for i in answers.size():
		if str(answers[i]) != "" and answers[i] == ANSWERS[i][solution[i]]:
			correct += 1
	return correct


## Der Versuch an der Haustür. Erst ab Tag 8 möglich.
func attempt_door() -> String:
	if not GameState.mystery_unlocked():
		return "TOO_EARLY"
	if not all_answered():
		return "INCOMPLETE"
	var correct := correct_count()
	if correct == 4:
		return "THE_DOOR"
	if correct >= 2:
		return "THE_THRESHOLD"
	return "FAILED"
