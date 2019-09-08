
# Game constructor for a 4 dice game similar to yatzy rules

init_game.mitzy <- function(game, no_rolls_allowed) {

  ## table for standard game scorecard

  t <- data.frame(
    half=c(1,1,1,1,1,1,1, 2,2,2,2,2,2, 3,3,3),
    section=c("1s","2s","3s","4s","5s","6s","ub",
              "1p","2p","3k","4k","ms","ch","ut","lt","gt"),
    name=c("Aces","Twos","Threes","Fours","Fives","Sixes","Upper bonus",
           "1 pair","2 pairs","3 of a kind","4 of a kind","Mini straight", "Chance",
           "Upper total","Lower total","TOTAL"),
    score=NA,
    score.available=NA,
    stringsAsFactors = F
  )


  ## add this and other attributes to the list

  game$dice = NA
  game$rolls = 0
  game$no_rolls_allowed = no_rolls_allowed
  game$no_dice = 4
  game$table=t

  ## Done

  return(game)

}


