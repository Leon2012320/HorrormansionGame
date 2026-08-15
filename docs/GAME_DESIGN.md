# ASHGROVE — Game Design Dokument

> Arbeitstitel. 2D-Horror-Survival, Godot 4, Raum-für-Raum-Standbilder.
> **Version 0.2** — kompletter Umbau nach Feedback: keine festen Nächte,
> keine direkte Monster-Bedrohung, weniger Systeme.
> Spieltexte auf Englisch, Setting Anfang der 1960er.

---

## 1. Der Pitch

Du bist nachts vor *etwas* weggelaufen und in das erstbeste Haus geflüchtet.
Die Tür ist hinter dir zugefallen. Sie geht nicht mehr auf.

Du weißt nicht, wie lange du hier drin sein wirst. Es gibt keine Frist, keinen
Countdown, kein "überlebe sieben Nächte". Es gibt nur die Vorräte, die noch da sind,
und die Frage, wie du an mehr kommst.

Tagsüber passiert fast nichts. **Alles passiert, während du schläfst** — und schlafen
musst du.

**Kernfantasie:** Nicht Flucht vor einem Monster, sondern das langsame Rechnen:
*"Zwei Dosen übrig. Ich bin seit 19 Stunden wach. Ich könnte den Keller noch
absuchen — oder die Zeit nutzen, um die Schlafzimmertür zuzunageln. Beides geht nicht."*

Der nächste Verwandte im Regal ist **This War of Mine** — nur dass der Krieg
draußen durch ein Haus ersetzt ist, das nicht will, dass du gehst.

### Wer du bist

**Niemand.** Kein Name, kein Alter, kein Geschlecht, keine Vorgeschichte, kein Beruf.
Die Figur wird nie beschrieben und nie gezeigt — auch nicht in Spiegeln.

Das ist eine harte Regel für alle Texte: **kein Ereignis darf etwas über die Figur
behaupten.** Keine Erinnerungen an eine Kindheit, keine Familie, kein "du hattest
schon immer Angst vor…". Wenn ein Ereignis etwas Persönliches braucht, bezieht es
sich auf **das, was der Spieler im Spiel getan hat** — welchen Raum er zum Lager
gemacht hat, was er aufgebrochen, wen er nicht gerufen hat.

Wenn das Radio ab Tag 26 Namen vorliest, ist genau deshalb nie klar, ob einer davon
deiner ist. Das funktioniert nur, solange die Figur leer bleibt.

---

## 2. Die vier Achsen

Alles im Spiel hängt an genau vier Dingen. Mehr gibt es nicht.

**Zwei davon gehören dir** und werden als Leiste angezeigt:

| Achse | Anzeige | Was passiert, wenn sie fällt |
|---|---|---|
| **FOOD** (Essen) | 0–100 | Unter 30: alles dauert länger. Unter 10: Zustand *Starving*. |
| **REST** (Schlaf) | 0–100 | Unter 40: du übersiehst Dinge. Unter 20: du siehst Dinge, die nicht da sind. |

**Zwei davon gehören dem Raum**, in dem du gerade stehst:

| Achse | Stufen | Wirkung |
|---|---|---|
| **LIGHT** (Licht) | 0–3 | Bestimmt, wie schnell du suchst und wie schlimm Ereignisse ausfallen |
| **SAFETY** (Sicherheit) | 0–3 | Bestimmt, ob ein Ereignis dich erreicht oder an der Tür hängen bleibt |

Das ist der ganze Kern. Keine Angst-Leiste, keine Bedrohungsstufe, kein Monster-Zähler.
Wenn du dich fragst "warum ist das gerade schwierig?", ist die Antwort immer eine
dieser vier Achsen.

### 2.1 FOOD — Essen

- Sinkt um **3 pro wacher Stunde** und **1 pro Schlafstunde** → ein Tag kostet
  etwa **56 Punkte**, also zwei Konserven oder eine warme Mahlzeit plus Kleinigkeit.
- Nahrung gibt es in zwei Sorten:
  - **Konserven** — halten ewig, geben 30–40. Die Währung des Spiels.
  - **Verderbliches** — Brot, Obst, Eingemachtes. Gibt mehr (bis 50), aber wird nach
    2–3 Tagen schlecht. Schlechtes Essen essen → Zustand *Sick*.
- Fundorte: Küche, Speisekammer, Weinkeller — und Zufallsereignisse.
- **Wasser lasse ich bewusst weg.** Eine zweite Verbrauchsleiste würde nur die
  gleiche Entscheidung doppelt stellen.

#### Der wichtigste Punkt: die Vorräte reichen nicht

Im ganzen Haus liegen zu Beginn etwa **620 FOOD-Punkte — genug für elf Tage.**
Ein Durchlauf geht bis zu fünfzig. Diese Lücke ist kein Balancing-Fehler, sondern
die zentrale Aufgabe: **ab etwa Tag 8 musst du anfangen, Nahrung selbst zu erzeugen.**

Es gibt zwei Wege, und beide brauchen Vorlauf:

**Der Wintergarten — Anbau.** Vier Beete. Samen einpflanzen (15 min), täglich gießen
(10 min), nach **10 Tagen** ernten: 3–5 Nahrungseinheiten, etwa 150 Punkte pro Beet.
Braucht Wasser (Regentonne) und Licht — ein Beet unter elektrischem Licht wächst in
7 statt 10 Tagen. **Damit bindet der Anbau eine deiner drei Sicherungen.**
Ereignisse können eine Ernte kurz vor der Reife vernichten.

**Fallen — schnell und ekelhaft.** Eine Falle aus Brett und Draht, aufgestellt in
Keller oder Dachboden. Alle 2–3 Tage fängt sie etwas: +25 FOOD, aber **20 % *Sick***,
wenn nicht durchgegart — und Garen braucht wieder den Herd, also wieder Strom.

Der Anbau ist die Investition, die über Tag 20 hinaus trägt. Wer erst an Tag 15
damit anfängt, kommt nicht bis Tag 50. Wer an Tag 3 damit anfängt, hat drei Tage
lang nicht nach Hinweisen gesucht.

### 2.2 REST — Schlaf

**Das ist die wichtigste Achse des ganzen Spiels**, weil im Schlaf 90 % von allem passiert,
was dir zustößt. Siehe Abschnitt 3.

- Sinkt um **5 pro wacher Stunde**. Nach etwa 20 Stunden bist du am Ende.
- Schlafen gibt **+15 pro Stunde**. Im Bett **+20**. Auf dem Boden nur **+8**.
- Unter REST 40: du übersiehst beim Durchsuchen Dinge (Fundchance −30 %).
- Unter REST 20: **Halluzinationen** — Hotspots, die nicht existieren, Hinweise,
  die falsch sind, Geräusche ohne Ursache. Der Spieler kann nicht mehr unterscheiden,
  was echt ist. Das ist der Horror, nicht ein Gesicht im Fenster.
- Bei REST 0 **brichst du zusammen, wo du gerade stehst.** Sechs Stunden Schlaf an
  einem ungesicherten, dunklen Ort, ohne dass du die Dauer wählen durftest.
  Das ist fast immer die schlechteste Nacht des Durchlaufs.

Du kannst dich nicht drücken. Wachbleiben ist keine Strategie, es ist nur ein Aufschub —
und es endet damit, dass du an einem Ort umfällst, den du dir nicht ausgesucht hast.

→ Die Kernfrage jedes Tages: *Wo schlafe ich, wie lange, und wie viel Zeit
investiere ich vorher noch in diesen Raum?*

### 2.3 LIGHT — Licht im Raum

| Stufe | Quelle | Kosten | Wirkung |
|---|---|---|---|
| **0** Dark | — | — | Suchen dauert **doppelt** so lange, Ereignisse eine Stufe schlimmer |
| **1** Handheld | Taschenlampe | 1 Batterie / Stunde | Du siehst nur den Kegel, aber es reicht |
| **2** Placed | Kerze, Petroleumlampe | brennt 4 Std. ab | Der ganze Raum ist hell, bleibt auch ohne dich an |
| **3** Electric | Deckenlicht | 1 Sicherung, dauerhaft | Beste Sicht, kostet laufend nichts — aber siehe unten |

**Der Sicherungskasten** (Keller): Das Haus hat Strom, aber nur **drei intakte Sicherungen**.
Du entscheidest, welche drei Räume Licht bekommen, und kannst sie jederzeit umstecken
(kostet 20 Minuten und den Weg in den Keller).

Der Haken: **Elektrisches Licht verändert, was für Ereignisse gezogen werden.**
Nicht "das Monster kommt" — sondern das Haus wird *wach*. Sicherungen brennen durch,
Lampen platzen, in beleuchteten Räumen passieren andere, seltsamere Dinge als in dunklen.
Licht ist nicht einfach besser. Es ist anders.

### 2.4 SAFETY — Sicherheit im Raum

| Stufe | Zustand | Kosten |
|---|---|---|
| **0** Open | Tür offen | — |
| **1** Closed | Tür zu | 1 min |
| **2** Blocked | Möbel davor geschoben | 15 min |
| **3** Barricaded | Bretter vernagelt | 30 min + 2 Bretter + Nägel + Hammer |

- SAFETY entscheidet, ob ein Bedrohungs-Ereignis **dich** trifft oder nur **die Tür**.
  Bei Stufe 3 wird aus "etwas steht in deinem Zimmer" ein "etwas kratzt draußen".
- **Barrikaden halten nicht.** Ereignisse beschädigen sie (Stufe 3 → 2 → 1).
  Reparieren kostet wieder Material. Das ist der Grund, warum du raus musst.
- Material (Bretter, Nägel) findest du in Werkstatt, Dachboden, Keller —
  oder du **zerlegst Möbel**, was laut ist und den Raum dauerhaft verändert.

### 2.5 Dein Lager

Du bekommst keinen sicheren Raum zugewiesen — **du wählst ihn selbst.**
Wo du deine Vorräte hinlegst und schläfst, ist deine wichtigste Entscheidung
im ganzen Spiel, und du kannst sie später bereuen.

| Kandidat | Dafür | Dagegen |
|---|---|---|
| Schlafzimmer | Bett (+20 Schlaf), Schrank zum Verstecken | Weit weg von Küche und Keller |
| Küche | Direkt am Essen, zwei Fluchtwege | Kellertür lässt sich schlecht sichern |
| Bibliothek | Viele Regale = viel Barrikadenmaterial | Kein Bett, kein Wasser |
| Eingangshalle | Zentral, kurze Wege überall hin | Die Haustür ist hier. Und sie ist nicht still. |

Vorräte, die du im Lager stapelst, sind **nicht automatisch sicher** — manche
Ereignisse nehmen dir etwas weg. Alles auf einen Haufen legen ist bequem und riskant.

---

## 3. Die Bedrohung: Ereignisse — und fast alle im Schlaf

**Es gibt keine Kreatur mit Wegfindung, keinen Verfolger, keine Bedrohungsanzeige.**
Alles, was dir zustößt, kommt aus dem Ereignis-System.

Und die entscheidende Regel: **90 % aller Ereignisse passieren, während du schläfst.**

Daraus folgt der ganze Rhythmus des Spiels:

```
   TAG                          NACHT                        MORGEN
   ─────────────────────        ──────────────────────       ─────────────────
   Erkunden, sammeln,     →     Du schläfst.            →    NIGHT REPORT
   bauen, barrikadieren,        Pro Stunde würfelt           Was ist passiert,
   Kerzen setzen,               das Haus.                    was fehlt, was ist
   Vorräte einteilen            Manches weckt dich.          kaputt, was ist neu.
   ─────────────────────        ──────────────────────       ─────────────────
   sicher, aber die Uhr         hier passiert alles          hier zahlst du
   läuft                                                     die Rechnung
```

Der Tag ist Vorbereitung. Die Nacht ist die Prüfung. Alles, was du tagsüber tust,
ist im Grunde eine Wette darauf, wie die kommende Nacht ausgeht.

### 3.1 Wann gezogen wird

| Situation | Chance |
|---|---|
| **Pro Schlafstunde** | **35 %** — bei ~8 Stunden also etwa 3 Ereignisse pro Nacht |
| Wach, pro Raumwechsel | 4 % — und dann fast nur Ambient oder ein Fund |
| Wach, nach langer Aktion | 3 % |

Die Wachwelt ist bewusst ruhig. Nicht, weil nichts los ist — sondern damit die
Stille tagsüber unangenehm wird und der Spieler die ganze Zeit an die Nacht denkt.

### 3.2 Der Schlaf-Ablauf

1. Der Spieler wählt **Raum** und **Dauer** (1–10 Stunden).
2. Ein Dialog zeigt vorher die Einschätzung — **in Worten, nicht als Prozentzahl**:
   - *"Dark. Open. You should not sleep here."*
   - *"Boarded up. A candle burning. This is as good as it gets."*
3. Bildschirm wird dunkel, die Uhr läuft stundenweise.
4. Jede Stunde eine Ziehung. Zwei mögliche Verläufe:
   - **Durchgeschlafen** → die Folgen siehst du erst im Night Report
   - **Aufgewacht** → ein Choice-Ereignis mitten in der Nacht, halb wach,
     mit Optionen. Danach: weiterschlafen (weniger Erholung) oder aufbleiben.
5. Morgens: **Night Report** — eine Seite, die auflistet, was in der Nacht geschah.

### 3.3 Was den Schlaf sicherer macht

| Maßnahme | Wirkung |
|---|---|
| SAFETY 3 (verbarrikadiert) | Ereignischance −15 Punkte, schwere Ergebnisse gesperrt |
| SAFETY 2 (Möbel davor) | −8 Punkte |
| LIGHT ≥ 2 (Kerze brennt) | −7 Punkte, und die "es war neben dir"-Ereignisse fallen weg |
| Stolperschnur mit Dosen | Wandelt schwere Ereignisse in "du wachst rechtzeitig auf" |
| Bett statt Boden | Bessere Erholung, keine Wirkung auf Ereignisse |
| FOOD über 60 | Keine Hunger-Albträume |

Ein voll ausgebauter Schlafplatz kommt auf etwa **8 % pro Stunde** — also eine
ruhige Nacht in vier. Vollständige Sicherheit gibt es nie, und sie kostet
jeden Tag aufs Neue Material und Zeit.

### 3.4 Die Kategorien im Schlaf-Deck

| Kategorie | Anteil | Was es tut |
|---|---|---|
| **Sound** | 25 % | Nur ein Geräusch. Du schläfst weiter, REST −5. Folgenlos. |
| **Wake** | 25 % | Du wachst auf → Choice-Ereignis mit echten Optionen |
| **Damage** | 15 % | Barrikade beschädigt, Sicherung durch, Vorräte verdorben |
| **Theft** | 10 % | Etwas ist weg. Nicht immer merkst du sofort, was. |
| **Mark** | 10 % | Du wachst mit einem Zustand auf. Kratzer, Fieber, Erschütterung. |
| **Clue** | 10 % | Ein Traum, eine Stimme, eine Zeile in deiner eigenen Handschrift |
| **Move** | 5 % | Du wachst in einem anderen Raum auf. Deine Sachen nicht unbedingt mit dir. |

### 3.5 Choice-Ereignisse — hier lebt das Spiel

Der Spieler bekommt **Situationen ohne gute Antwort.** Beispiel:

> *You wake up. The room is wrong. The chair from the corner is at the foot of the
> bed now, turned to face you.*
>
> **[Put it back]** — 10 min, REST −5, nichts weiter
> **[Leave it. Don't look at it again.]** — kein Schlafbonus mehr diese Nacht
> **[Sit in it]** — 25 % ein Hinweis, 25 % Zustand *Shaken*, 50 % nichts

Regel für jedes Choice-Ereignis: **keine Option ist eindeutig richtig, und mindestens
eine kostet eine der vier Achsen.** Wenn eine Option offensichtlich die beste ist,
ist das Ereignis kaputt und muss überarbeitet werden.

### 3.6 Fairness-Regeln

- Nie zwei Damage-Ereignisse in derselben Nacht
- Höchstens ein Mark-Ereignis pro Nacht
- FOOD unter 25 → Fund-Ereignisse werden verdreifacht (das Spiel hilft leise)
- Jedes Ereignis nur einmal pro Tag
- **Die erste Nacht ist immer ruhig.** Der Spieler soll einmal aufwachen und denken,
  es sei alles in Ordnung, bevor es losgeht.
- Nach einer sehr schlechten Nacht ist die nächste garantiert milder

---

## 4. Zustände und Tod

Ein schlecht ausgegangenes Ereignis tötet dich **nie direkt**. Es gibt dir einen Zustand.

| Zustand | Wirkung | Behandlung | Wenn unbehandelt |
|---|---|---|---|
| **Injured** | Alle Aktionen +50 % Zeit | Verbandskasten | Nach 12 Std. → *Bleeding* |
| **Sick** | FOOD sinkt doppelt so schnell | Medikamente + 8 Std. Schlaf | Nach 24 Std. → *Fevered* |
| **Shaken** | Du kannst 4 Stunden nicht schlafen | Zeit, warme Mahlzeit | vergeht von selbst |
| **Starving** | REST sinkt doppelt, Aktionen misslingen | Essen | zieht Lebenspunkte |

**Tod tritt nur ein durch:**
1. Einen Zustand der zweiten Stufe (*Bleeding*, *Fevered*), der weitere 12 Stunden unbehandelt bleibt
2. FOOD auf 0 über mehr als 24 Stunden
3. Ganz seltene Ereignisse, bei denen du eine klare Warnung ignoriert hast

Es gibt also immer eine Vorwarnung und immer einen Weg zurück — aber der kostet.

**Tod ist endgültig.** Kein Laden, kein Zurücksetzen des Tages. Der Durchlauf ist vorbei,
du siehst eine Zusammenfassung (wie viele Tage, was du herausgefunden hast, was du
nie erfahren hast) und fängst neu an. Was du behältst, ist dein Wissen über das Haus.

---

## 5. Zeit

- Uhr läuft **aktionsbasiert**, nicht in Echtzeit. Sie tickt nur, wenn du etwas tust.
  Nachdenken ist kostenlos.
- **Tag (08:00–20:00):** Milde Ereignisse, weniger Ziehungen. Zeit zum Erkunden.
- **Nacht (20:00–08:00):** Ereignisse häufiger und eine Stufe schlimmer. Zeit zum Schlafen —
  wenn du dich traust.
- Tage werden gezählt (**Day 1, Day 2, …**), aber es gibt **kein Ziel-Datum.**
  Der Spieler weiß nie, ob noch drei Tage kommen oder dreißig.

**Eskalation ohne Countdown** — alle 3 Tage wird ein neues Ereignis-Deck freigeschaltet:

**Ein voller Durchlauf geht bis Tag 50.** Das ist bewusst lang: die Rettung ist der
Ausdauerweg für Könner, nicht der Normalfall. Die meisten Durchläufe enden früher
über das Geheimnis.

| Phase | Tage | Charakter |
|---|---|---|
| **Ankommen** | 1–5 | Das Haus ist nur ein leeres Haus. Grundvorräte, erste Barrikade, erste ruhige Nacht. |
| **Aufbau** | 6–15 | Damage und Theft aktiv. Du musst anfangen, Nahrung selbst zu produzieren. |
| **Die Wende** | 16–25 | Die Hausvorräte sind alle. Das Geheimnis wird lösbar. Räume tauschen Verbindungen. |
| **Zermürbung** | 26–40 | Du lebst nur noch von dem, was du selbst anbaust. Ereignisse werden persönlich. |
| **Endspiel** | 41–50 | Das Radio kündigt die Suche an. Jede Nacht kostet mehr, als sie einbringt. |

| Ab | Was neu dazukommt |
|---|---|
| Tag 1 | Grunddeck. Die erste Nacht ist immer ruhig. |
| Tag 4 | Damage- und Theft-Ereignisse |
| Tag 8 | Move-Ereignisse. Vorratsfunde werden deutlich seltener. |
| Tag 16 | Das Haus verändert sich: Räume tauschen Verbindungen, ein Raum wird unbetretbar. |
| Tag 20 | **Ab hier ist das Geheimnis lösbar** — vorher fehlen zwangsläufig Fragmente. |
| Tag 26 | Ereignisse werden persönlich: sie beziehen sich auf das, was du getan hast. |
| Tag 34 | Ein zweiter Raum wird unbetretbar. Der Sicherungskasten wird unzuverlässig. |
| Tag 50 | **Die Rettung.** Fester Tag, kein Würfeln. Das Radio führt über Wochen darauf hin. |

---

## 6. Zwei Wege hinaus

Es gibt **zwei Arten zu gewinnen**, und sie ziehen in entgegengesetzte Richtungen.
Das ist die strategische Hauptentscheidung des Spiels.

### Weg 1 — RESCUE: bis Tag 50 durchhalten

Irgendwann kommt Hilfe. An **Tag 50**, fest, ohne Würfeln.

- Der Spieler erfährt das Datum nie direkt. Das **Radio im Salon** ist die einzige
  Informationsquelle, und es tastet sich über Wochen heran: erst Wetter, dann ein
  gefundenes Fahrzeug, dann eine Vermisstenmeldung, ein Suchgebiet, ein Hubschrauber.
  Wer das Radio ignoriert, weiß nie, ob er noch drei Tage oder noch dreißig vor sich hat.
- Das ist der **Ausdauerweg und ausdrücklich der schwerere**: fünfzig Nächte,
  und die Hausvorräte reichen für elf davon. Ohne eigene Nahrungsproduktion
  (siehe 2.1) ist er nicht zu schaffen.
- Er ist **nicht der Normalfall.** Die meisten Durchläufe sollen über Weg 2 enden.
  Weg 1 ist für die, die es wissen wollen.

### Weg 2 — THE DOOR: verstehen

Die Haustür geht auf, wenn du herausgefunden hast, was das Haus verlangt.

Ein **Notizbuch** mit vier Fragen — sie fragen alle nach **Regeln**, nie nach Identität:

1. **What does it take from you?**
2. **Which room is the wrong one?**
3. **What has to go back?**
4. **Where does it have to go?**

Jede Frage braucht 3 gefundene Fragmente, dann wählst du eine Antwort aus mehreren
Möglichkeiten. Der Versuch an der Haustür ist möglich, sobald alle vier beantwortet sind.

**Frühestens an Tag 20** — vorher sind zwangsläufig nicht alle zwölf Fragmente
erreichbar, weil drei davon in Räumen liegen, die sich erst ab Tag 16 öffnen.
Ein sehr guter Durchlauf endet um **Tag 22–28**. Das ist der gedachte Normalweg.

| Ergebnis | Was passiert |
|---|---|
| 4 von 4 richtig | Die Tür geht auf. Du gehst hinaus. |
| 2–3 richtig | Die Tür geht auf, aber sie schließt sich nicht hinter dir. |
| 0–1 richtig | Fehlschlag: du verlierst die verwendeten Gegenstände und einen Tag. |

Die richtige Kombination wird **pro Durchlauf neu gewürfelt**. Du kannst die Lösung
nicht auswendig lernen, nur die Methode, sie zu finden.

Das ist der **schnelle, aber riskante Weg**: Fragmente liegen in den Räumen, in die
man am wenigsten will, und du schläfst öfter an schlechten Orten.

### Der dritte Ausgang — THE WINDOW

Ein Fenster einzuschlagen ist **jederzeit möglich**, vom ersten Tag an. Es funktioniert
sogar: du kommst raus. Der Wintergarten zeigt dir vorher, warum das keine gute Idee ist.

Es ist kein Scheitern-Knopf, sondern ein echtes Ende mit eigener Schlusskarte —
und es ist immer da, als leise Versuchung, wenn eine Nacht besonders schlecht lief.

### Was du nie erfährst

**Es wird nicht aufgelöst.** Nicht in einem der Enden.

Du erfährst, *was* das Haus verlangt, nie *warum*. Die Fragmente passen nicht restlos
zusammen — zwei Notizen widersprechen sich, ein Datum ergibt keinen Sinn, auf dem
Foto ist eine Person zu viel. Das ist Absicht und wird nicht repariert.

Auch das, wovor du zu Beginn weggelaufen bist, bleibt ungeklärt. Es kommt nicht wieder
vor, außer als das, was der Wintergarten zeigt. Ob es dasselbe ist wie das im Haus,
sagt niemand.

**Wichtig für die Umsetzung:** Alle Ereignistexte müssen diese Zurückhaltung durchhalten.
Nie ein Name für die Sache, nie eine Erklärung, nie ein Wesen, das sich zeigt.
Nur Wirkungen: eine offene Tür, ein fehlendes Glas, ein warmer Stuhl.

### Übersicht der Enden

| Ende | Wie | Frühestens | Ton |
|---|---|---|---|
| **THE DOOR** | Alle vier Fragen richtig | Tag 20 | Du gehst selbst. Ruhig. Der gedachte Normalweg. |
| **THE THRESHOLD** | 2–3 Fragen richtig | Tag 20 | Du kommst raus, aber nicht allein |
| **RESCUE** | Bis Tag 50 durchhalten | Tag 50 | Der Ausdauerweg. Erleichterung — und du erklärst nie, was war. |
| **THE WINDOW** | Fenster einschlagen | Tag 1 | Immer verfügbar. Schlecht. |
| **DEATH** | Zustand oder Verhungern | — | Endgültig, Zusammenfassung, Neustart |

## 6.1 Ein Wort zu Permadeath bei fünfzig Tagen

Ein Durchlauf über 50 Tage sind grob **6–10 Stunden Spielzeit**. Ein endgültiger Tod
an Tag 38 ist ein sehr harter Schlag — härter als bei den ursprünglich geplanten
zwei Wochen. Damit das trotzdem fair bleibt, drei Regeln:

1. **Kein Tod ohne 24 Stunden Vorwarnung.** Zustände eskalieren sichtbar,
   FOOD-Warnungen kommen deutlich, das Spiel sagt dir, dass du gerade stirbst.
2. **Zwischen den Tagen wird automatisch gespeichert** — ein Speicherstand, der
   beim Tod gelöscht wird. Das schützt vor Abstürzen und Stromausfall, nicht vor Fehlern.
3. **Kartenwissen bleibt.** Beim Neustart ist der Grundriss bereits bekannt und
   Räume müssen nicht neu entdeckt werden. Vorräte, Fragmente und die Lösung werden
   neu gewürfelt. Du beginnst schneller, aber nicht leichter.

Wenn sich das im Test trotzdem zu bitter anfühlt, ist die naheliegende Stellschraube
ein **freiwilliger Modus mit Speicherpunkten**, nicht eine Aufweichung des Todes.

---

## 7. Die Villa

13 Räume. Jeder ist an mindestens eine der vier Achsen gebunden — kein Raum ist Dekoration.

```
  ATTIC                    [12] Attic
                                │
  UPPER          [8]──[7 Upper Landing]──[9]     [10] Bathroom
              Bedroom      │      │    Nursery      │
                           │      └──[11] Study ────┘
                           │
  GROUND    [3]──[2]──[1 ENTRANCE HALL]──[4]──[5]──[6]
          Library Parlor      ▲ AUSGANG  Dining Kitchen Conservatory
                              │
  CELLAR                [13] Cellar ── [Fuse box]
```

| # | Raum | Achse | Rolle |
|---|---|---|---|
| 1 | Entrance Hall | — | Die Haustür. Der Ausgang. Sie geht nicht auf. |
| 2 | Parlor | SAFETY | Schwere Möbel zum Verbarrikadieren, Radio |
| 3 | Library | Geheimnis | Hauptquelle für Notiz-Fragmente, Bretter aus Regalen |
| 4 | Dining Room | LIGHT | Kerzen, Kerzenleuchter, Silber |
| 5 | Kitchen | FOOD | Speisekammer, Konserven, Herd (warme Mahlzeit) |
| 6 | Conservatory | — | Der einzige Blick nach draußen. Man sollte nicht hinsehen. |
| 7 | Upper Landing | — | Drehscheibe. Ab Tag 7 stimmen die Türen nicht mehr. |
| 8 | Bedroom | REST | Bett (+20/Std.), Schrank, Kleidung |
| 9 | Nursery | Geheimnis | Der emotionale Kern. Und ein sehr gutes Versteck. |
| 10 | Bathroom | Zustände | Medikamente, Verbandskasten, Spiegel |
| 11 | Study | Geheimnis | Telefon, Schreibtisch, Safe mit Zahlenschloss |
| 12 | Attic | SAFETY | Werkzeug, Bretter, Nägel, Koffer |
| 13 | Cellar | LIGHT | **Sicherungskasten.** Eingemachtes. Ganz dunkel. |

**Für einen ersten Prototyp reichen 5:** Entrance Hall, Kitchen, Bedroom, Library, Cellar —
damit sind alle vier Achsen abgedeckt.

### Warum du nicht rausgehst

Die Haustür ist zu und lässt sich nicht öffnen — das ist die harte Grenze.
Die Fenster sind eine weichere: sie sind **nicht** vernagelt. Du könntest eines einschlagen.
Aber der Wintergarten zeigt dir, was draußen steht und wartet, und ab dann versuchst du es nicht mehr.

Ein Fenster einzuschlagen ist im Spiel möglich. Es ist keine Lösung. Es ist ein Ende.

---

## 8. Bedienung und Bildschirm

```
┌──────────────────────────────────────────────────────────┐
│ DAY 3  ·  02:40      FOOD ▓▓▓▓░░░░    REST ▓▓░░░░░░      │
│ KITCHEN         light ●●○   safety ●●●        [Injured]  │
├──────────────────────────────────────────────────────────┤
│                                                          │
│                  RAUMBILD (Standbild)                    │
│         Hotspots leuchten schwach beim Hovern            │
│                                                          │
├──────────────────────────────────────────────────────────┤
│ [🔦][🥫][🔨][🪵][ ][ ]        [Notebook] [Map] [Sleep]   │
└──────────────────────────────────────────────────────────┘
```

- **Linksklick auf Hotspot** → Aktionsmenü. Die Kosten stehen **immer vorher** dran:
  `Search the pantry — 10 min` · `Pry open the crate — 20 min, needs crowbar`
- **Rechtsklick** → ansehen, kostenlos, gibt Atmosphäre-Text
- **Tab** Notebook · **M** Map · **F** Taschenlampe · **S** Schlafen (öffnet Schlaf-Dialog
  mit Anzeige, wie sicher der Raum gerade ist — der Spieler soll wissen, was er riskiert)
- Traglimit **6 Slots**. Der Rest liegt in deinem Lager.

---

## 9. Technische Struktur (Godot 4, GDScript)

Datengetrieben: Räume, Gegenstände, Ereignisse und Hinweise sind `Resource`-Dateien (`.tres`).
Inhalte kann man im Editor anlegen, ohne Code anzufassen.

```
res://
├── src/
│   ├── autoload/
│   │   ├── game_state.gd     # Tag, Uhr, FOOD, REST, Zustände, Flags
│   │   ├── clock.gd          # Zeit vorspulen, Tag/Nacht-Signale
│   │   ├── event_deck.gd     # Gewichtetes Ziehen, Fairness-Regeln
│   │   ├── rooms.gd          # LIGHT/SAFETY je Raum, Barrikaden-Zustand
│   │   ├── power.gd          # Sicherungskasten, 3 Sicherungen
│   │   ├── inventory.gd      # 6 Slots + Lagerbestand
│   │   ├── notebook.gd       # Fragmente, Fragen, Antworten, Enden
│   │   └── save_system.gd    # Ein Speicherstand, wird bei Tod gelöscht
│   ├── data/                 # Resource-Schemas
│   ├── scenes/               # main · room_view · hotspot · sleep · event_popup
│   └── ui/                   # hud · inventory · notebook · map · action_menu
├── content/                  # rooms/ items/ events/ clues/ als .tres
├── assets/                   # siehe ASSET_PLAN.md
└── audio/
```

- Auflösung **640 × 360**, Stretch `viewport`, Aspect `keep` → saubere Pixel in jeder Größe
- Textur-Import: Filter **Nearest**
- Licht per `CanvasModulate` + `PointLight2D` → **ein Bild pro Raum reicht**,
  die vier LIGHT-Stufen entstehen im Shader
- **Ein einziger Speicherstand**, automatisch, wird bei Tod gelöscht (Permadeath)

---

## 10. Roadmap

| Meilenstein | Inhalt |
|---|---|
| **M0** | Godot-Projekt, Ordner, Platzhalter, ein Raum ist sichtbar |
| **M1** | Bewegung zwischen 5 Räumen, Hotspots, Uhr, Aktionen mit Zeitkosten |
| **M2** | FOOD und REST, Essen, Schlafen, Zustände |
| **M3** | LIGHT und SAFETY: Taschenlampe, Kerzen, Sicherungskasten, Barrikaden |
| **M4** | Ereignis-System mit allen fünf Kategorien, ~40 Ereignisse |
| **M5** | Notizbuch, Fragmente, die vier Fragen, die Enden |
| **M6** | Alle 13 Räume, ~100 Ereignisse, Eskalationsdecks |
| **M7** | Deine Sprites rein, Ton, Balancing |

---

## 11. Weiterführende Dokumente

| Datei | Inhalt |
|---|---|
| [`ITEMS.md`](ITEMS.md) | Alle Gegenstände mit Werten, Fundorten und Häufigkeiten |
| [`EVENTS.md`](EVENTS.md) | Ausgeschriebene Ereignisse mit englischem Text und Konsequenzen |
| [`ASSET_PLAN.md`](ASSET_PLAN.md) | Grafik- und Tonliste mit Größen und Dateinamen |

## 12. Offene Punkte

1. **Titel** — "Ashgrove" ist ein Platzhalter.
2. **Umfang von Version 1** — noch offen, du wolltest das später entscheiden.
3. **Balancing-Zahlen** — alle Werte sind erste Schätzungen zum Draufhauen.
