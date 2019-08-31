

# "current" is a vector of the current values, if applicable
# "which" is either a character sting containing the numeric positions of the dice to re-roll
#         or if NA, all will be rolled anew

roll_dice <- function (current = NA, which = NA) {

  if (is.na(which)) {
    return (sample(1:6,5,replace=T))
  }

  for (i in 1:5) {
    if (length(grep(as.character(i),which)) == 1) {
      current[i] <- sample(1:6,1)
    }
  }

  return(current)

}


print_dice <- function(d, work.mode=F) {

  c1 <- c("     ", "  *  ", "    *", "*   *", "*   *", "*   *")
  c2 <- c("  *  ", "     ", "  *  ", "     ", "  *  ", "*   *")
  c3 <- c("     ", "  *  ", "*    ", "*   *", "*   *", "*   *")

  if (work.mode) {
    print(d)
  } else {
    cat("+-----+ +-----+ +-----+ +-----+ +-----+\n")
    cat(paste0("|",c1[d[1]],"| |",c1[d[2]],"| |",c1[d[3]],"| |",c1[d[4]],"| |",c1[d[5]],"|\n"))
    cat(paste0("|",c2[d[1]],"| |",c2[d[2]],"| |",c2[d[3]],"| |",c2[d[4]],"| |",c2[d[5]],"|\n"))
    cat(paste0("|",c3[d[1]],"| |",c3[d[2]],"| |",c3[d[3]],"| |",c3[d[4]],"| |",c3[d[5]],"|\n"))
    cat("+-----+ +-----+ +-----+ +-----+ +-----+\n")
  }

}
