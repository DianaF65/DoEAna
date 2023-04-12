 plot_design <- function(data_row) {
  # either selects hyper cube or simplex plot fxn
  if (my_design$geometry == "hypercube") {
    plot_hypercube(data_row)
  } else if (my_design$geometry == "simplex") {
    plot_simplex(data_row)
  } else {
    warning("This either has to be a hyper cube or a simplex function.")
  }
}

# we can do this in baseR or with ggplot2
plot_hypercube <- function(data) {
  # ggplot2 example code
  for(i in 1:nrow(d)){
    main <- d$fgbest[i]
    Xt <- ml[[i]]
    Xt <- as.data.frame(ml[[i]])
    plot <- ggplot(Xt, aes(x = V1, y = V2)) + geom_point() +
      scale_y_continuous(limits = c(-1,1)) +
      scale_x_continuous(limits = c(-1,1)) +
      ggtitle(paste0("Min.Dist-Score = ", main))
    gridExtra::grid.arrange(plot)
  }
}

  # baseR example code:
  # ml <- list()
  # for(i in seq_len(nrow(data))) {
  #   ml[[i]] <- parseDesign_toRmatrix(data$optDes[i], N = 10, K = 2)
  #
  # }
  # for(i in seq_len(nrow(data))) {
  #   main <- data$fgbest[i]
  #   Xt <- ml[[i]]
  #   plot(Xt[,1], Xt[,2], xlim = c(-1,1), ylim = c(-1,1), pch = 16, col = "blue",
  #        main = paste0("Min.Dist-Score = ", main))
  # }


# need ggplot2 and ggtern libraries
plot_simplex <- function(data) {
  euc_df <- as.data.frame(euc_mat)
  colnames(euc_df) <- c("x1", "x2", "x3")
  ggtern(euc_df, aes(x1, x2, x3)) + geom_point(size = 3, color = "blue") +
    geom_segment(data = lines, aes(x = x1, y = x2,  z = x3,
                                   xend = xend, yend = yend, zend = zend),
                 color = "grey", size = 0.2) +
    labs(title = "Euclidean Dist, N = 20 Maximum SF_Design",
         subtitle = paste0("Min.Dist-Score = ", euc$fgbest[1])
    ) +
    theme_bw() + theme_nomask() + theme_clockwise() + theme(
      plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5))
  dev.off()

  png("figures/k3n20_aitchison_sim.png", units = "in", height = 6, width = 6, res = 172)
  aitc_df <- as.data.frame(aitc_mat)
  colnames(aitc_df) <- c("x1", "x2", "x3")
  ggtern(aitc_df, aes(x1, x2, x3)) + geom_point(size = 3, color = "blue") +
    geom_segment(data = lines, aes(x = x1, y = x2,  z = x3,
                                   xend = xend, yend = yend, zend = zend),
                 color = "grey", size = 0.2) +
    # labs(title = "Aitchison Dist, N = 20 Maximum SF_Design",
    labs(title = paste0(my_design$distance, "optimal design"),
         subtitle = paste0("Min.Dist-Score = ", aitc$fgbest[1])
    ) +
    theme_bw() + theme_nomask() + theme_clockwise() + theme(
      plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5))
}
