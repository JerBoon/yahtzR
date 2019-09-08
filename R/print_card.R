
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

    empty <- gsub("\\+","|",edge)
    empty <- gsub("-"," ",empty)

    # Print the main cards side-by-side, accounting for potential
    # different lengths (in standard, they each have 7 rows, but
    # in variants they may not)

    l1 <- sum(p$half == 1)
    l2 <- sum(p$half == 2)
    out1 <- p[p$half == 1,"print"]
    out2 <- p[p$half == 2,"print"]

    cat(sprintf("%s %s\n",edge,edge))

    for (i in 1:max(l1,l2)) {
      cat(if(i <= l1) out1[i] else empty)
      cat(" ")
      cat(if(i <= l2) out2[i] else empty)
      cat("\n")

    }
    cat(sprintf("%s %s\n",edge,edge))

    ## Print total summary box

    na0 <- function(x) { if (is.na(x)) 0 else x }

    if (add.totals) {
      cat(sprintf("|Upper total     %3d| |Game: %-13s|\n", na0(p[p$section=="ut","score"]), class(game)))
      cat(sprintf("|Lower total    %4d| |TOTAL          %4d|\n",
                  na0(p[p$section=="lt","score"]),
                  na0(p[p$section=="gt","score"])))
      cat("+-------------------+ +-------------------+\n")
    }
  }

  print_dice(game$dice, rolls=game$rolls, work.mode=work.mode)

}
