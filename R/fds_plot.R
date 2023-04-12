fds_plot <- function(designs){
  # (you input diff designs and it gives the resulting fds plot)
}


# # function to make FDS vec
# only works for hypercube, need one for simplex

#' make_random_grid generates random designs
#'
#' @param dim the dimension of the grid. Accepts only values of 1 or 2.
#' @return a randomized design with user specified number of parameters.
make_random_grid <- function(dim = 1){
  N <- 10000
  x1 <- runif(N, min = -1, max = 1)
  if (dim == 1){
    ran_grid <- matrix(x1)
  }
  if (dim == 2){
    x2 <- runif(N, min = -1, max = 1)
    ran_grid   <- cbind(x1, x2)
  }
  return(ran_grid)
}

# need to be extended to k = 3
#' makeModelVec generates a single vector of the design matrix
#'
#' @param X a vector or matrix object that represents an experiment design
#' @return
makeModelVec <- function(X){
  X <- matrix(X)
  K <- ncol(X)
  if (K == 1) {
    M <- cbind(1, X, X^2)
  } else if (K == 2) {
    # use second order model so CEXCH goes for more than a few iterations
    M <- cbind(1, X, X[, 1] * X[, 2], X^2)
  } else if (k == 3) {
    M <- cbind(1, X, X[, 1] * X[, 2], X[, 1] * X[, 3], X[, 2] * X[, 3],
               X[, 1] * X[, 2] * X[, 3], X^2)
  }
  return(matrix(M))
}


#' Title
#'
#' @param X
#' @return
makeModelMat <- function(X) {
  X <- as.matrix(X)### WARNING: ONLY WORKS FOR k = 1, k = 2
  N <- nrow(X)
  K <- ncol(X)
  if (K == 1) {
    M <- cbind(rep(1, N), X, X^2)
  } else if (K == 2) {
    # use second order model so CEXCH goes for more than a few iterations
    M <- cbind(rep(1, N), X, X[, 1] * X[, 2], X^2)
  } else if (K >= 3) {
    # use second order model with all interactions
    M <- cbind(rep(1, N), X, X[, 1] * X[, 2], X[, 1] * X[, 3], X[, 2] * X[, 3],
               X[, 1] * X[, 2] * X[, 3], X^2)
  }
  return(M)
}

#' makePredVec creates a list of prediction variances of randomized designs for
#' the FDS plot
#'
#' @param X candidate design being compared
#' @return a list of ordered prediction variance of the randomized designs
makePredVec <- function(X){
  M <- makeModelMat(X)
  F_prime_F_inv <- solve(t(M)%*%M)
  rand_grid <- make_random_grid(dim = ncol(X)) # random grid, k = ncol(X) dims
  ran_grid_model_vec <- lapply(row(rand_grid)[,1],
                               function(x) makeModelVec(rand_grid[x,]))
  ran_grid_pred <- sapply(ran_grid_model_vec,
                          function(F_x) t(F_x) %*% F_prime_F_inv %*% (F_x))
  ord_grid_pred <- ran_grid_pred[order(ran_grid_pred)]
  return(ord_grid_pred)
}


#' Title
#'
#' @param design an experimental design
#' @param Ylim ignore
#' @param colV a vector of strings containing a number of colors equal to the
#' number of designs being plotted
#' @param Main a string containing the desired title for the FDS plot
#'
#' @return an FDS plot
#' @export
#'
#' @examples
fds_plot <- function(design1, design2, Ylim = NULL, colV = colv, Main = ""){
  design1 <- parse_design_to_rmat(design1)
  design2 <- parse_design_to_rmat(design2)
  pred1 <- makePredVec(design1)
  pred2 <- makePredVec(design2)
  design <- rbind(pred1, pred2)
  par(tck = -0.01,
      mai = c(0.5, 0.5, 0.3, 0.3))
  if(is.null(Ylim)) Ylim <- range(design)
  x    <- seq(1,ncol(design), by = 1)/ncol(design)
  plot(x = x, y = design[1,], type = "l", col = colV[1], ylim = Ylim,
       xlab = "", ylab = "", lwd = 2,
       axes = F, main = Main)
  grid()
  for(i in 1:nrow(design)){
    lines(x = x, y = design[i,], type = "l", col = colV[i], lwd = 2)
  }
  box()
  axis(1, tck = -0.01, mgp = c(3, .1, 0), cex.axis= 1)
  axis(2, tck = -0.01, mgp = c(3, 0.25, 0), cex.axis= 1)
  mtext("Fraction of Design Space", side = 1, line = 1, cex = 1)
  mtext("Relative Prediction Variance", side = 2, line = 1.5, cex = 1)
  legend('topleft', inset = 0.1, paste0(
    design1$distance, " distance, N = ", design1$n,
    design2$distance, " distance, N = ", design2$n), lty = 1, col = colV,
    cex = 0.65)
}
#
# pv_i_k1  <- makePredVec(best_design_3_k1)
# pv_g_k1 <- makePredVec(best_design_4_k1)
# pv_i_k2  <- makePredVec(best_design_3_k2)
# pv_g_k2 <- makePredVec(best_design_4_k2)
#
#
# colv <- c("blue", "red", "purple", "orange", "darkgreen")
#
# spvd_k1 <- rbind(pv_i_k1, pv_g_k1)
# spvd_k2 <- rbind(pv_i_k2, pv_g_k2)
# spvd_all <- rbind(pv_i_k1, pv_g_k1, pv_i_k2, pv_g_k2)
#
#
# fds_plot(spvd_k1, Main = "FDS Plot: K = 1, I vs G - opt Design, 2nd-Order")
# legend("topleft", lwd = 2, legend = c("I - opt Design", "G - opt Design"), col = c("blue", "red"))
#
# fds_plot(spvd_k2, Main = "FDS Plot: K = 2, I vs G - opt Design, 2nd-Order")
# legend("topleft", lwd = 2, legend = c("I - opt Design", "G - opt Design"), col = c("blue", "red"))


# ## utilities for generating design and model matrices
# function genRandDesign_mix(N, K)
# # N:= number of points in design (nrows)
# # K:= number of factors (ncols)
# # generate from uniform dirichlet
# alpha = ones(K)
# d     = Dirichlet(alpha)
# X     = transpose(rand(d, N))
# # make sure smallest is bigger than 0
# smallest = eps()
# for i in 1:N
# xt = X[i, :]
# xt[xt .< smallest] .= smallest
# xt = xt/sum(xt)
# X[i, :] = xt
# end
#
# return X
# end
