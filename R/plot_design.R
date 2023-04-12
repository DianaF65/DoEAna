 plot_design <- function(data_row) {
  # either selects hyper cube or simplex plot fxn
  if (data_row$geometry == "hypercube") {
    plot <- plot_hypercube(data_row)
  } else if (data_row$geometry == "simplex") {
    plot <- plot_simplex(data_row)
  } else {
    warning("This either has to be a hyper cube or a simplex function.")
  }
   print(plot)
}

# we can do this in baseR or with ggplot2
plot_hypercube <- function(data_row) {
  # ggplot2 example code
  design <- as.data.frame(parse_design_to_rmat(data_row))
  plot <- ggplot2::ggplot(design, ggplot2::aes(x = V1, y = V2)) + ggplot2::geom_point() +
    ggplot2::scale_y_continuous(limits = c(-1,1)) +
    ggplot2::scale_x_continuous(limits = c(-1,1)) +
    ggplot2::labs(title = paste0(data_row$distance, " distance, N = ", data_row$n),
         subtitle = paste0("Min.Dist-Score = ", data_row$score))
  return(plot)
}


# need ggplot2 and ggtern libraries
plot_simplex <- function(data_row) {
  design <- as.data.frame(parse_design_to_rmat(data_row))
  lines <- data.frame(x1 = c(0.5, 0, 0.5),
                      x2 = c(0.5, 0.5, 0),
                      x3 = c(0, 0.5, 0.5),
                      xend = c(1, 1, 1)/3,
                      yend = c(1, 1, 1)/3,
                      zend = c(1, 1, 1)/3)
  ggtern::ggtern(design, ggplot2::aes(V1, V2, V3)) + ggplot2::geom_point(size = 3, color = "blue") +
    ggplot2::geom_segment(data = lines, ggplot2::aes(x = x1, y = x2,  z = x3,
                                   xend = xend, yend = yend, zend = zend),
                 color = "grey", size = 0.2) +
    ggplot2::labs(title = paste0(data_row$distance, " distance, N = ", data_row$n),
         subtitle = paste0("Min.Dist-Score = ", data_row$score)) +
    ggplot2::theme_bw() + ggplot2::theme_nomask() + ggplot2::theme_clockwise() + ggplot2::theme(
      plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5))
  return(plot)
}
