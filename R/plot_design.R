#' Plot Design Function
#'
#' This function plots hypercube and simplex geometries.
#'
#' @param data_row A row of data.
#'
#' @return A plot of the specified geometry.
#' @export
 plot_design <- function(data_row) {
  # either selects hyper cube or simplex plot fxn
  if (data_row$geometry == "hypercube") {
    plot <- plot_hypercube(data_row)
  } else if (data_row$geometry == "simplex") {
    plot <- plot_simplex(data_row)
  } else {
    warning("This either has to be a hyper cube or a simplex.")
  }
   print(plot)
}


#' Plot Hypercube Function
#'
#' This function plots the specified distances on a hypercube geometry.
#'
#' @param data_row A row of data.
#'
#' @return A plot of the hypercube.
plot_hypercube <- function(data_row) {
  design <- as.data.frame(parse_design_to_rmat(data_row))
  x1 <- x2 <- 0
  colnames(design) <- c("x1", "x2")

  plot <- ggplot2::ggplot(design, ggplot2::aes(x = x1, y = x2)) +
    ggplot2::geom_point(size = 2, color = "blue") +
    ggplot2::scale_y_continuous(limits = c(-1, 1)) +
    ggplot2::scale_x_continuous(limits = c(-1, 1)) +
    ggplot2::labs(title = paste0(data_row$distance, " distance, n = ",
                                 data_row$n),
         subtitle = paste0("min_dist score = ", round(data_row$score, 4))) +
    ggplot2::theme(
           plot.title = ggplot2::element_text(size = 14, face = "bold",
                                              hjust = 0.5),
           plot.subtitle = ggplot2::element_text(hjust = 0.5))
  return(plot)
}

#' Plot Simplex Function
#'
#' This function plots the specified distances on a simplex geometry
#'
#' @param data_row A row of data.
#'
#' @return A plot of the simplex.
plot_simplex <- function(data_row) {
  design <- as.data.frame(parse_design_to_rmat(data_row))
  x1 <- x2 <- x2 <- x3 <- xend <- yend <- zend <- 0
  colnames(design) <- c("x1", "x2", "x3")
  lines <- data.frame(x1 = c(0.5, 0, 0.5),
                      x2 = c(0.5, 0.5, 0),
                      x3 = c(0, 0.5, 0.5),
                      xend = c(1, 1, 1) / 3,
                      yend = c(1, 1, 1) / 3,
                      zend = c(1, 1, 1) / 3)

  suppressWarnings({
    plot <- ggtern::ggtern(design, ggplot2::aes(x = x1,
                                y = x2, z = x3)) +
    ggplot2::geom_point(size = 3, color = "blue") +
    ggplot2::geom_segment(data = lines, ggplot2::aes(x = x1, y = x2,  z = x3,
                                xend = xend, yend = yend, zend = zend),
                          color = "grey", size = 0.2) +
    ggplot2::labs(title = paste0(data_row$distance, " distance, n = ",
                                 data_row$n),
                  subtitle = paste0("min_dist score = ",
                                    round(data_row$score, 4))) +
    ggplot2::theme_bw() + ggtern::theme_nomask() + ggtern::theme_clockwise() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 14, face = "bold", hjust = 0.5),
      plot.subtitle = ggplot2::element_text(hjust = 0.5))
    })
  return(plot)
}
