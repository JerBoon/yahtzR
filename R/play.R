#' Play dice game variant
#'
#' Shortcut function calls for calling the variants.
#'
#'
#' @examples
#'   play_yatzy()
#'
#' @name play
#'
NULL

#' @rdname play
#' @export
play_yatzy <- function() {
  yahtzR(variation = "yatzy")
}

#' @rdname play
#' @export
play_yahtzee <- function() {
  yahtzR(variation = "yahtzee")
}

#' @rdname play
#' @export
play_maxi <- function() {
  yahtzR(variation = "maxi_yatzy")
}

#' @rdname play
#' @export
play_forced <- function() {
  yahtzR(variation = "forced_yatzy")
}

#' @rdname play
#' @export
play_mitzy <- function() {
  yahtzR(variation = "mitzy")
}

