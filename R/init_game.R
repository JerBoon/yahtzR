
# Internal function to set up a new game

init_game <- function() {

  t <- data.frame(
    half=c(1,1,1,1,1,1,2,2,2,2,2,2,2),
    section=c("x1","x2","x3","x4","x5","x6","3k","4k","fh","ss","ls","yz","ch"),
    name=c("Aces","Twos","Threes","Fours","Fives","Sixes",
           "3 of a kind","4 of a kind","Full house","Small straight","Long straight",
           "Yahtzee","Chance"),
    score=NA,
    score.available=NA
  )

  x <- list(
    dice = NA,
    rolls = 0,
    table=t
  )

  return(x)

}


