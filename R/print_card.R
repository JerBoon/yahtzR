

print_card <- function(game,work.mode=F) {

  if (!work.mode)
    cat("\014")

  print(game$table[,c(2,3,4,5)])


}
