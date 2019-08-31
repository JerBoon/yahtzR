


#' yahtzR
#'
#' Play the game of yahtzee in an R session
#'
#' Yahtzee is a classic dice rolling game and, heck, why not play it in R instead of doing some
#' important machine learning or whatever.
#'
#' @param work.mode Logical. If TRUE, then display the game in a manner which looks a bit
#'   more like you're actually working!
#'
#'   N.B. I accept no responsibility if your boss still notices!
#'
#' @export
#'
#' @examples
#'   yahtzR(work.mode=T)
#'
yahtzR <- function(work.mode=F) {

  if (!work.mode) {
    cat("\014")
    message("Welcome to yahtzR")
    message("")
    message("initialising...")
    Sys.sleep(0.2)
  }

  game <- init_game()

  game <- do_dice_rolls(game, work.mode)

  print(game)
}
