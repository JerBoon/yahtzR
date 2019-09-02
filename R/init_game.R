
# Internal function to set up a new game
# Takes the form of a list of the various objects required
# to define current game scorecard, status, and dice rolls etc

init_game <- function() {

  t <- data.frame(
    half=c(1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3),
    section=c("1s","2s","3s","4s","5s","6s","ub","3k","4k","fh","ss","ls","yz","ch","ut","lt","gt"),
    name=c("Aces","Twos","Threes","Fours","Fives","Sixes","Upper bonus",
           "3 of a kind","4 of a kind","Full house","Small straight","Long straight",
           "Yahtzee","Chance",
           "Upper total","Lower total","TOTAL"),
    score=NA,
    score.available=NA,
    stringsAsFactors = F
  )

  x <- list(
    dice = NA,
    rolls = 0,
    table=t
  )

  return(x)

}


