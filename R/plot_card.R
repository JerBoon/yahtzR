

plot_card <- function(game, work.mode) {

  # I could dplyr this if I wanted, but heh..
  gg.dat <- game$table
  gg.dat <- gg.dat[gg.dat$half != 99,]
  names(gg.dat)[names(gg.dat) == {if (work.mode) "section" else "name"}] <- "label"
  gg.dat$label <- factor(gg.dat$label, levels=gg.dat$label, ordered=T)


  gg <- ggplot2::ggplot(gg.dat, ggplot2::aes(x=label,y=score, fill=factor(half))) +
    ggplot2::geom_col() +
    ggplot2::scale_x_discrete(name="", limits=rev(gg.dat$label)) +
    ggplot2::ylab("") +
    ggplot2::theme(legend.position = "none") +
    ggplot2::coord_flip()

  suppressWarnings(print(gg))
}
