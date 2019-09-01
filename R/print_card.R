

print_card <- function(game,work.mode=F) {

  if (work.mode) {

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

  } else {   # ------------------------

    cat("\014")

    print(game$table[,c(2,3,4,5)])

  }

}
