
# Print score card, plus if applicable the latest dice roll
# Displays in 2 different styles, depending on whether you're in work.mode
# or not.
# Also displays extra information in the card (score you'd increase by if chosen)
# if it precedes an input to select your scoring move.

print_card <- function(game,work.mode=F) {

  if (work.mode) {

    cat("[[1]]\n")
    p <- game$table[,c(2,4,5)]

    # having columns called "score" is suspicious.. :)
    names(p) <- c("category","val","val.new")

    #prettify slightly - "NA"s are very hard to read
    p$val <- as.character(p$val)
    p[is.na(p$val),2] <- ""
    p$val.new <- paste0("+",as.character(p$val.new))
    p[p$val.new == "+NA",3] <- ""

    # don't display the val.new column if it's not relevant
    if (max(nchar(p$val.new)) == 0)
      p$val.new <- NULL

    print(p)

    cat("\n[[2]]\n")

  } else {   # ------------------------ not work mode -----

    cat("\014")

    p <- game$table
    p$print <- sprintf("|%2s|%-14s|%4d|%+3d|",
                       p$section,
                       p$name,
                       as.integer(p$score),
                       as.integer(p$score.available))
    p$print <- gsub("NA","  ",p$print)

    edge <- "+--+--------------+----+---+"
    add.totals <- F
    if (sum(!is.na(p$score.available)) == 0) {
      add.totals <- T
      p$print <- substr(p$print,4,24)
      edge <- substr(edge,4,24)
    }
    out <- p[p$half == 1,"print"]
    out <- cbind(out,p[p$half == 2,"print"])

    cat(sprintf("%s %s\n",edge,edge))
    cat(sprintf("%s %s\n", out[,1], out[,2]), sep="")
    cat(sprintf("%s %s\n",edge,edge))

    if (add.totals) {
      cat(sprintf("|Upper total     %3d| |                   |\n",p[p$section=="ut","score"]))
      cat(sprintf("|Lower total    %4d| |TOTAL          %4d|\n",p[p$section=="lt","score"],p[p$section=="gt","score"]))
      cat("+-------------------+ +-------------------+\n")
    }
  }

  print_dice(game$dice, rolls=game$rolls, work.mode=work.mode)

}
