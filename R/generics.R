
# S3 generic class definitions

init_game <- function(game, no_rolls_allowed) {
  UseMethod("init_game")
}


## calc_scores() should update the score.available column of the scoring table according to
## the rolled dice, and the ruleset in play.
## Values should only be set for scores which are available to be chosen for this round
##
## returns the updated game object

calc_scores <- function(game) {
  UseMethod("calc_scores")
}

## Technically this is a function which applies any additional scoring to the score
## table after user selection has been made.
## Implemented to facilitate the Upper Bonus, but could theoretically be used for
## any other appropriate post-selection tasks

apply_bonuses <- function(game) {
  UseMethod("apply_bonuses")
}
