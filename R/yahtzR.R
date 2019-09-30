


#' yahtzR
#'
#' Play variations of the well-known dice rolling game in an R session.
#'
#' Yatzy (and variants) are a classic dice rolling game and, heck, why not play then in
#' an R console instead of doing some important machine learning or whatever.
#'
#' Work mode prints minimal help messages and prompting, but accepts exactly the same inputs
#' as regular mode. It assumes that you have already played in regular (verbose) mode and
#' therefore understand what inputs are available at the various prompts.
#'
#' Type "help" or "?" at any prompt for more information.
#'
#' @param variation Character value. Name of game variation and ruleset to apply. Valid options are:
#'
#' \itemize{
#'    \item "yahtzee" - Official Yahtzee game with "Forced Joker" rules.
#'          \href{https://en.wikipedia.org/wiki/Yahtzee}{Wikipedia}
#'    \item "yatzy" - The public domain variation of the game.
#'          \href{https://en.wikipedia.org/wiki/Yatzy}{Wikipedia}
#'    \item "forced_yatzy" - Regular Yatzy, but you have to fill the card from top to
#'          bottom (see previous wiki).
#'    \item "maxi_yatzy" - Version of Yatzy with 6 dice, and some extra game rules.
#'          \href{https://en.wikipedia.org/wiki/Yatzy#Maxi_Yatzy}{Wikipedia}
#'    \item "mitzy" - a simplified, 4 dice game with rules similar to Yatzy.
#' }
#'
#' @param rolls_per_turn Integer value. The number of dice rolls allowed per turn.
#'   Usually (and by default) 3, but can be changed to any other value to create your own bespoke
#'   game variation.
#'
#' @param work.mode Logical. If TRUE, then display the game in a manner which looks a bit
#'   more like you're actually working!
#'
#'   N.B. I accept no responsibility if your boss still notices!
#'
#' @param graphical Logical, TRUE by default. If set, plots your scorecard as a ggplot.
#'   Will vary the outputs, both to entertain you, and to make it look like you're
#'   developing some interesting charts (useful in work mode?).
#'   Requires installation of ggplot and dependencies.
#'
#' @export
#'
#' @examples
#'   yahtzR(work.mode=T)
#'
#'   #This is just a silly idea :)
#'   yahtzR(variation="yatzy", rolls_per_turn = 10)
#'
yahtzR <- function(variation = "yahtzee", rolls_per_turn = 3, work.mode = FALSE, graphical = TRUE) {

  if (!variation %in% c("yahtzee", "yatzy", "mitzy", "forced_yatzy", "maxi_yatzy")) {
    message(paste0("Unknown rule variation option '",variation,"'"))
    return()
  }

  # Welcome message
  if (!work.mode) {
    cat("\014")
    message(paste0("Welcome to yahtzR v",packageVersion("yahtzR")))
    message("")
    message("initialising...")
  }

  if (graphical) {
    # test for package
    if (!requireNamespace("ggplot2", quietly = TRUE)) {
      message("ggplot2 package needed for graphical option. Running in text mode only.")
      graphical=FALSE
    }
  }

  if (!work.mode) {
    Sys.sleep(1)
  }

  # initialise
  game <- structure(list(), class = variation)

  game <- init_game(game = game, no_rolls_allowed = rolls_per_turn)

  # loop until the scorecard is full
  while( sum(is.na(game$table$score)) > 0 ) {
    game <- do_dice_rolls(game, work.mode)

    if (class(game) != variation) {
      if (!work.mode) cat("bye then\n")
      return(invisible(NA))
    }

    game <- calc_available(game)

    game <- make_choice(game,work.mode)
    if (class(game) != variation) {
      if (!work.mode) cat("bye then\n")
      return(invisible(NA))
    }

    print_card(game,work.mode, graphical)
  }

  cat("\n")

}
