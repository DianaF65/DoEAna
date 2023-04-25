#' make_random_grid generates random designs
#'
#' @param dim the dimension of the grid. Accepts only values of 1 or 2.
#' @return a randomized design with user specified number of parameters.
make_random_grid <- function(dim = 1) {
  n <- 10000
  x1 <- stats::runif(n, min = -1, max = 1)
  if (dim == 1) {
    ran_grid <- matrix(x1)
  }
  if (dim == 2) {
    x2 <- stats::runif(n, min = -1, max = 1)
    ran_grid   <- cbind(x1, x2)
  }
  if (dim == 3) {
    x2 <- stats::runif(n, min = -1, max = 1)
    x3 <- stats::runif(n, min = -1, max = 1)
    ran_grid <- cbind(x1, x2, x3)
  }
  return(ran_grid)
}

#' make_model_vec Function
#'
#' makeModelVec generates a single vector of the design matrix for computation
#' purposes in makePredVec.
#'
#' @param x a vector or matrix object that represents an experiment design
#' @return a single vector
make_model_vec <- function(x) {
  x <- matrix(x)
  k <- ncol(x)
  if (k == 1) {
    m <- cbind(1, x, x^2)
  } else if (k == 2) {
    # use second order model so CEXCH goes for more than a few iterations
    m <- cbind(1, x, x[, 1] * x[, 2], x^2)
  } else if (k == 3) {
    m <- cbind(1, x, x[, 1] * x[, 2], x[, 1] * x[, 3], x[, 2] * x[, 3],
               x[, 1] * x[, 2] * x[, 3], x^2)
  }
  return(matrix(m))
}

#' make_model_mat Function
#'
#' make_model_mat takes an experiment's design matrix and extends it into the
#' model matrix. The function creates a second order model which includes main
#' effects, interaction, and squared terms.
#'
#' @param x an experiment design in the form of a matrix.
#'
#' @return a model matrix of the input design.
make_model_mat <- function(x) {
  x <- as.matrix(x)
  n <- nrow(x)
  k <- ncol(x)
  if (k == 1) {
    m <- cbind(rep(1, n), x, x^2)
  } else if (k == 2) {
    # use second order model so CEXCH goes for more than a few iterations
    m <- cbind(rep(1, n), x, x[, 1] * x[, 2], x^2)
  } else if (k >= 3) {
    # use second order model with all interactions
    m <- cbind(rep(1, n), x, x[, 1] * x[, 2], x[, 1] * x[, 3], x[, 2] * x[, 3],
               x[, 1] * x[, 2] * x[, 3], x^2)
  }
  return(m)
}

#' make_pred_vec Function
#'
#' make_pred_vec creates a list of prediction variances of randomized designs
#' for the fds_plot function.
#'
#' @param x candidate design being compared.
#' @return a list of ordered prediction variance of the randomized designs.
make_pred_vec <- function(x) {
  m <- make_model_mat(x)
  f_prime_f_inv <- solve(t(m) %*% m)
  rand_grid <- make_random_grid(dim = ncol(x)) # random grid, k = ncol(X) dims
  ran_grid_model_vec <- lapply(row(rand_grid)[, 1],
                               function(x) make_model_vec(rand_grid[x, ]))
  ran_grid_pred <- sapply(ran_grid_model_vec,
                          function(f_x) t(f_x) %*% f_prime_f_inv %*% (f_x))
  ord_grid_pred <- ran_grid_pred[order(ran_grid_pred)]
  return(ord_grid_pred)
}


#' FDS Plot
#'
#' fds_plot takes two experiment designs and creates a Fraction of Design Space
#' visualization that compares relative prediction variance across the design
#' space. A lower prediction variance is considered a a desirable quality in an
#' experiment.
#'
#' @param design1 an experimental design for comparison.
#' @param design2 an experimental design for comparison.
#' @param y_lim ignore.
#' @param col_v a vector of strings containing a number of colors equal to the
#' number of designs being plotted.
#' @param title a string containing the desired title for the FDS plot.
#'
#' @return an FDS plot.
#' @export
fds_plot <- function(design1, design2, y_lim = NULL, col_v = col_v,
                     title = "") {
  if (design1$geometry == "simplex" || design2$geometry == "simplex") {
    stop("Sorry, becuase the models for the simplex are very complex, the
         FDS plot for the simplex is currently not supported and is an
         area of future research.")
  }
  design1_mat <- parse_design_to_rmat(design1)
  design2_mat <- parse_design_to_rmat(design2)
  pred1 <- make_pred_vec(design1_mat)
  pred2 <- make_pred_vec(design2_mat)
  design <- rbind(pred1, pred2)
  col_v <- c("blue", "red", "purple", "orange", "darkgreen")
  graphics::par(tck = -0.01,
      mai = c(0.5, 0.5, 0.3, 0.3))
  if (is.null(y_lim)) y_lim <- range(design)
  x    <- seq(1, ncol(design), by = 1) / ncol(design)
  graphics::plot(x = x, y = design[1, ], type = "l", col = col_v[1],
                 ylim = y_lim, xlab = "", ylab = "", lwd = 2,
       axes = FALSE, main = title)
  graphics::grid()
  for (i in seq_len(nrow(design))) {
    graphics::lines(x = x, y = design[i, ], type = "l", col = col_v[i], lwd = 2)
  }
  graphics::box()
  graphics::axis(1, tck = -0.01, mgp = c(3, .1, 0), cex.axis = 1)
  graphics::axis(2, tck = -0.01, mgp = c(3, 0.25, 0), cex.axis = 1)
  graphics::mtext("Fraction of Design Space", side = 1, line = 1, cex = 1)
  graphics::mtext("Relative Prediction Variance", side = 2, line = 1.5, cex = 1)
  graphics::legend("topleft", inset = 0.1, legend = c(paste0(
    design1$distance, " distance, N = ", design1$n), paste0(
      design2$distance, " distance, N = ", design2$n)), lty = 1, col = col_v,
    cex = 0.65)
}
