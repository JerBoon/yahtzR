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
  
- Forced Yatzy (public domain game)
  - same as regular Yatzy, but where you are compelled to fill the score card in the order in
    which the options appear.
  
- Maxi Yatzy (6 dice version of Yatzy)
  - as per [Wikipedia](https://en.wikipedia.org/wiki/Yatzy#Maxi_Yatzy).

- Mitzy (a 4-dice derivative-ish of Yatzy)
  - Upper bonus value is 25, awarded for total of 42 or more.
  - Introduces a "Mini straight" which is a 4 number straight, scores per the dice roll total.

### Coming soon...

Curently in development... v1.4.0 will come with graphical outputs of some kind

![image](https://user-images.githubusercontent.com/23141865/65390567-4110ee80-dd58-11e9-83b0-9f6d55874592.png)
