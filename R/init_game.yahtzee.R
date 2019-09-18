
# Game constructor for official version
# for the official rules

init_game.yahtzee <- function(game, no_rolls_allowed) {

  ## table for standard game scorecard

  t <- data.frame(
    half=c(1,1,1,1,1,1,1,2,2,2,2,2,2,2, 99,99,99),
    section=c("1s","2s","3s","4s","5s","6s","ub","3k","4k","fh","ss","ls","yz","ch","ut","lt","gt"),
    name=c("Aces","Twos","Threes","Fours","Fives","Sixes","Upper bonus",
           "3 of a kind","4 of a kind","Full house","Small straight","Large straight",
           "Yahtzee","Chance",
           "Upper total","Lower total","TOTAL"),
    score=NA,
    score.available=NA,
    stringsAsFactors = F
  )


  ## add this and other attributes to the list

  game$dice = NA
  game$rolls = 0
  game$no_rolls_allowed = no_rolls_allowed
  game$no_dice = 5
  game$table=t

  ## Done

  return(game)

}


