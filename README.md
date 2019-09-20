# yahtzR

Play variations of the well-known dice rolling game in an R session.

Because why not?

Latest release: [v1.3.0](https://github.com/JerBoon/yahtzR/releases/tag/v1.3.0)

Previous releases:
- [v1.2.0](https://github.com/JerBoon/yahtzR/releases/tag/v1.2.0)
- [v1.1.0](https://github.com/JerBoon/yahtzR/releases/tag/v1.1.0)
- [v1.0.0](https://github.com/JerBoon/yahtzR/releases/tag/v1.0.0)


```
+--------------+----+ +--------------+----+
|Aces          |    | |1 pair        |    |
|Twos          |    | |2 pairs       |    |
|Threes        |    | |3 of a kind   |    |
|Fours         |   8| |4 of a kind   |    |
|Fives         |    | |Small straight|    |
|Sixes         |  18| |Long straight |    |
|Upper bonus   |    | |Full house    |    |
|              |    | |Chance        |    |
|              |    | |Yatzy         |    |
+--------------+----+ +--------------+----+
|Upper total      26| |Game: yatzy        |
|Lower total       0| |TOTAL            26|
+-------------------+ +-------------------+
   -----   -----   -----   -----   ----- 
  |  o  | |    o| |o   o| |o   o| |o   o|
  |     | |  o  | |     | |  o  | |o   o|
  |  o  | |o    | |o   o| |o   o| |o   o|
   -----   -----   -----   -----   ----- 
```
### Details

Available variations:

- Yahtzee (official game)
  - uses the _Forced Joker_ rules, as described at 
  [Wikipedia](https://en.wikipedia.org/wiki/Yahtzee).

- Yatzy (public domain game)
  - as per [Wikipedia](https://en.wikipedia.org/wiki/Yatzy).
  
- Maxi Yatzy (6 dice version of Yatzy)
  - as per [Wikipedia](https://en.wikipedia.org/wiki/Yatzy#Maxi_Yatzy).

- Mitzy (a 4-dice derivative-ish of Yatzy)
  - Upper bonus value is 25, awarded for total of 42 or more.
  - Introduces a "Mini straight" which is a 4 number straight, scores per the dice roll total.
