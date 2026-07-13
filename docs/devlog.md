
# Roguelike Tower Defense Game.

Neues Projekt gestartet: name weiß ich noch net


## 2026-04-03

- Angefangen ein Autoload Script zu erstellen.
- Die ersten "Test" Tiles erstellt.
- 4 Maps erstellt mit Pfaden und Bauzonen.
- Beim Start wird eine Random Map geladen.
- Den Sprite für den ersten Base Tower erstellt.


## 2026-04-05

- die ersten gegner erstellt.
- noch mehr tower erstellt
- gegner laufen jetzt 2 - 3 pfade ab.
- die erste fähigkeit erstellt


## 2026-05-20

- lebensbalken bei dem gegner eingefügt.
- der fähigkeit "giftwolke" tickschaden gegeben und eine dauer.
- fähigkeit macht jetzt schaden am gegner und verschwindet nach 10 sek.


## 2026-05-21

- bug gefunden beim bauen der tower. problem höchstwarscheinlich erkannt aber noch nicht umgesetzt.
- angefangen das UI für die karten auswahl zu bauen.


## 2026-05-22

- UI für die karten fertig getstellt.


## 2026-05-23

- 2 neue Türme mit ihren Geschossen erstellt und ins Spiel eingefügt.
- den Geschossen aller Türme eine Reichweite gegeben wann diese verschwinden.


## 2026-05-24

- 2 fähigkeiten ( artillery, kochsalzlösung) ins spiel gebracht.
- einen slowcounter bei den gegner eingefügt.
- einen neuen tower erstellt und reingebracht.


## 2026-05-26

- symbol bilder für die karten erstellt von den towern und fähigkeiten
- dictionarys und arrays erstellt und getestet ob die bilder richtig laden und angezeigt werden
- das system ausarbeiten wie was verwaltet wird im singleton
- ein neuen boss gegner erstellt und eingefügt
- angefangen das runden system zu bearbeiten


## 2026-05-28

- Dictionarys und Arrays erstellt für die Kartenauswahl.
- Runden Anzahl und Endphase angepasst.
- Karten erscheinen jetzt je nach vorgebebenen Level und zeigen dann entsprechende Karten.
- Zustände angepasst und gefixt wann gebaut werden kann, wann karten erscheinen, wann gegner kommen und wann diese tot sind.
- angefangen die richtigen bilder bei der kartenauswahl zu laden pro karte.


## 2026-05-30

- kartensystem bearbeitet das keine karte doppel kommt und leere karten disabled werden.


## 2026-05-31

- upgrades erstellt und bilder dafür erstellt und eingefügt.
- fehler und typos entdeckt beim kartensystem und diese behoben.
- reihenfolge festgelegt wann welche upgrades kommen.


## 2026-06-04

- kartensystem weiter bearbeitet
- konzept verworfen wie map und tower placement und neues konzept entworfen
- design geändert


## 2026-06-05

- in gimp neue Tilesets erstellt
- neue map hinzugefügt mit tilemaplayer
- alte maps entfernt und das bausystem umgearbeitet
- bauareas und pfade der tower gelöscht oder geändert
- dictionarys angepasst
- tower placement für tilemaps angepasst
- angefangen ghost tower bearbeitet und symbole eingefügt damit man sieht welche felder bebaut werden


## 2026-06-07

- basetower angepasst und altes placement system entfernt.
- towergröße angepasst
- angefangen das placement system neu zu machen das tower nun mithilfe von ewinem grid system gebaut werden
- den ghosttower angepasst der dem spieler zeigen soll wann gebaut werden kann und wann nicht. 


## 2026-06-11

- ein array und ein dictionary angelegt im singelton um gebaute türme zu sammeln und belegte tiles zu überprüfen, wo schon ein tower steht.
- dann den ghosttower bearbeitet das er auch rot wird wenn andere tower im weg sind.


## 2026-06-13

- resourcen für alle tower, abilitys und upgrades erstellt.
- kartensystem nimmt jetzt die resourcen für bilder und text.
- spezial wahl bearbeitet wo der spieler ziwschen tower oder fähgkeit entscheiden kann.
- tower inventar angefangen.
- hud überarbeitet und weitere platzhalter texturen eingefügt.


## 2026-06-14

- tower inventar fertig gestellt.
- slots halten jetzt die karten resource


## 2026-06-17

- spezialwahl von der ability geändert das es jetzt upgrades sind und keine ability


## 2026-06-18

- die karten gleichen jetzt mit dem slot ab ob der gleiche tower schon im inventar ist und wenn ja wird nun die anzahl erhöht.


## 2026-06-28

- das Tower Inventar bearbeitet.
- Die slots im inventar überarbeitet und die slotgröße für die tower entfernt.
- Die Toweranzahl wird jetzt über das Singleton Dictionary geregelt.
- Das inventar wird jetzt über Signale geupdatet wenn ein Tower gebaut wurde oder die Toweranzhal 0 erreicht hat.


## 2026-06-30

- Ability Resource angepasst.
- Aufladungen für die Abilitys ins Singleton Dictionary gepackt.
- Wenn die Ability gepickt wird, kommt sie in den ersten leeren Slot.


## 2026-07-07

- inputs vom main script über signale verbunden mit den buttons für die abilitys.
- die scenen der abilitys ins dictionary eingefügt.
- beim benutzen der fähigkeit wird nun eine aufladung abgezogen.


## 20226-07-12

- abilitys haben ihre aufladung und geändert das es nicht über resourcen sondern auch über ein dictionary gesteuert wird.
- blockiert wenn aufladung bei null ist und resettet in jeder neuen runde.