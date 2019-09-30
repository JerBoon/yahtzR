
# Game constructor for public domain variation
# AS per https://en.wikipedia.org/wiki/Yatzy

init_game.forced_yatzy <- function(game, no_rolls_allowed) {

  game <- init_game.yatzy(game, no_rolls_allowed)
  game$title <- "Forced Yatzy"

  return(game)

}


