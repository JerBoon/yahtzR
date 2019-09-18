
# Game constructor for public domain variation
# AS per https://en.wikipedia.org/wiki/Yatzy

init_game.maxi_yatzy <- function(game, no_rolls_allowed) {

  ## table for standard game scorecard

  t <- data.frame(
    half=c(1,1,1,1,1,1,1, 2,2,2,2,2,2,2,2,2,2,2,2,2,2, 99,99,99),
    section=c("1s","2s","3s","4s","5s","6s","ub",
              "1p","2p","3p","3k","4k","5k",
              "ss","ls","fs","fh","vl","tw","my","ch","ut","lt","gt"),
    name=c("Aces","Twos","Threes","Fours","Fives","Sixes","Upper bonus",
           "1 pair","2 pairs","3 pairs","3 of a kind","4 of a kind","5 of a kind",
           "Small straight","Large straight","Full straight",
           "Full house","Villa (3-3)","Tower (4-2)","Maxi Yatzy","Chance",
           "Upper total","Lower total","TOTAL"),
    score=NA,
    score.available=NA,
    stringsAsFactors = F
  )


  ## add this and other attributes to the list

  game$dice = NA
  game$rolls = 0
  game$bonus_rolls = 0
  game$no_rolls_allowed = no_rolls_allowed
  game$no_dice = 6
  game$table=t

  ## Done

  return(game)

}


