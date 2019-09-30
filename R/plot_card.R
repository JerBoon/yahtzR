

plot_card <- function(game, work.mode) {

  # I could dplyr this if I wanted, but heh..
  gg.dat <- game$table
  gg.dat <- gg.dat[gg.dat$half != 99,]
  names(gg.dat)[names(gg.dat) == {if (work.mode) "section" else "name"}] <- "label"
  gg.dat$label <- factor(gg.dat$label, levels=gg.dat$label, ordered=T)
  #score with NAs coorced to 0 - some charts work better with this
  gg.dat$score.z <- gg.dat$score
  gg.dat$score.z[is.na(gg.dat$score.z)] <- 0

  # ------------------------ randomness ----------------

  # Pick a random theme
  base_theme <- sample(list(ggplot2::theme_classic(),
                            ggplot2::theme_grey(),
                            ggplot2::theme_bw(),
                            ggplot2::theme_minimal()),
                       1)

  # colour palette
  base_palette <- sample(c("Greens","Oranges","Accent","Dark2","Paired","Set1","Set2"),1)

  # Print a random chart
  style <-  sample(1:3,1)

  # ------------------------

  if (style == 1)
  {
    #Horizontal column plot
    gg <- ggplot2::ggplot(gg.dat, ggplot2::aes(x=label,y=score, fill=factor(half), group=factor(half))) +
      base_theme +
      ggplot2::scale_fill_brewer(palette = base_palette) +
      ggplot2::geom_col() +
      ggplot2::scale_x_discrete(name="", limits=rev(gg.dat$label)) +
      ggplot2::ylab("") +
      ggplot2::theme(legend.position = "none") +
      ggplot2::coord_flip()
  }
  else if (style == 2)
  {
    #Vertical column plot
    gg <- ggplot2::ggplot(gg.dat, ggplot2::aes(x=label,y=score, fill=factor(half), group=factor(half))) +
      base_theme +
      ggplot2::scale_fill_brewer(palette = base_palette) +
      ggplot2::geom_col() +
      ggplot2::xlab("") +
      ggplot2::ylab("") +
      ggplot2::theme(legend.position = "none")

    if (!work.mode)
      gg <- gg +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle=30,vjust=1,hjust=1))
  }
  else
  {
    #Vertical column plot with facets
    gg <- ggplot2::ggplot(gg.dat, ggplot2::aes(x=label,y=score.z, fill=factor(half))) +
      base_theme +
      ggplot2::scale_fill_brewer(palette = base_palette) +
      ggplot2::geom_col() +
      ggplot2::xlab("") +
      ggplot2::ylab("") +
      ggplot2::theme(legend.position = "none") +
      ggplot2::facet_grid(~ factor(half, labels = c("Upper","Lower")),
                          scales="free_x", space="free_x")

    if (!work.mode)
      gg <- gg +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle=30,vjust=1,hjust=1))
  }

  # Standard titles
  if (work.mode)
    gg <- gg + ggplot2::ggtitle(label = "Stats for Y",
                                subtitle = paste("sum(val) =",game$table[game$table$section == "gt", "score"]))
  else
    gg <- gg + ggplot2::ggtitle(label = paste(game$title),
                                subtitle = paste("Total score = ",game$table[game$table$section == "gt", "score"]))

  suppressWarnings(print(gg))

}
