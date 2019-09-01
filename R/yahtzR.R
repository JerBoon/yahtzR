


#' yahtzR
#'
#' Play the game of yahtzee in an R session
#'
#' Yahtzee is a classic dice rolling game and, heck, why not play it in R instead of doing some
#' important machine learning or whatever.
#'
#' Work mode prints minimal help messages and prompting, but accepts exactly the same inputs
#' as regular mode. It assumes that you have already played in regular (verbose) mode and
#' therefore understand what inputs are available at the various prompts.
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
    Sys.sleep(0.5)
  }

  game <- init_game()

  while( sum(is.na(game$table$score)) > 0 ) {
    game <- do_dice_rolls(game, work.mode)
    if (class(game) != "list") {
      if (!work.mode) cat("bye then\n")
      return(invisible(NA))
    }

    game <- calc_available(game)

    game <- make_choice(game,work.mode)
    if (class(game) != "list") {
      if (!work.mode) cat("bye then\n")
      return(invisible(NA))
    }

    print_card(game,work.mode)
  }

}
