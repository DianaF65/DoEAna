fds_plot <- function(designs){
  # (you input diff designs and it gives the resulting fds plot)
}


# # function to make FDS vec
# only works for hypercube, need one for simplex
# make_random_grid <- function(dim = 1){
#   N <- 10000
#   x1 <- runif(N, min = -1, max = 1)
#   if (dim == 1){
#     ran_grid <- matrix(x1)
#   }
#   if (dim == 2){
#     x2 <- runif(N, min = -1, max = 1)
#     ran_grid   <- cbind(x1, x2)
#   }
#   return(ran_grid)
# }

# need to be extended to k = 3
# makeModelVec <- function(X){
#   X <- matrix(X)
#   K <- ncol(X)
#   if (K == 1) {
#     F <- cbind(1, X, X^2)
#   } else if (K == 2) {
#     # use second order model so CEXCH goes for more than a few iterations
#     F <- cbind(1, X, X[, 1] * X[, 2], X^2)
#   }
#   return(matrix(F))
# }


# makeModelMat <- function(X) {
#   ### WARNING: ONLY WORKS FOR k = 1, k = 2
#   N <- nrow(X)
#   K <- ncol(X)
#   if (K == 1) {
#     F <- cbind(rep(1, N), X, X^2)
#   } else if (K == 2) {
#     # use second order model so CEXCH goes for more than a few iterations
#     F <- cbind(rep(1, N), X, X[, 1] * X[, 2], X^2)
#   } else if (K >= 3) {
#     # use second order model with all interactions
#     F <- cbind(rep(1, N), X)
#   }
#   return(F)
# }

# makePredVec <- function(X){
#   F <- makeModelMat(X)
#   F_prime_F_inv <- solve(t(F)%*%F)
#   rand_grid <- make_random_grid(dim = ncol(X)) # random grid, k = ncol(X) dims
#   ran_grid_model_vec <- lapply(row(rand_grid)[,1],
#                                function(x) makeModelVec(rand_grid[x,]))
#   ran_grid_pred <- sapply(ran_grid_model_vec,
#                           function(F_x) t(F_x) %*% F_prime_F_inv %*% (F_x))
#   ord_grid_pred <- ran_grid_pred[order(ran_grid_pred)]
#   return(ord_grid_pred)
# }
#
#
# fds_plot <- function(dd, Ylim = NULL, colV = colv, Main = ""){
#   par(tck = -0.01,
#       mai = c(0.5, 0.5, 0.3, 0.3))
#   if(is.null(Ylim)) Ylim <- range(dd)
#   x    <- seq(1,ncol(dd), by = 1)/ncol(dd)
#   plot(x = x, y = dd[1,], type = "l", col = colV[1], ylim = Ylim,
#        xlab = "", ylab = "", lwd = 2,
#        axes = F, main = Main)
#   grid()
#   for(i in 1:nrow(dd)){
#     lines(x = x, y = dd[i,], type = "l", col = colV[i], lwd = 2)
#   }
#   box()
#   axis(1, tck = -0.01, mgp = c(3, .1, 0), cex.axis= 1)
#   axis(2, tck = -0.01, mgp = c(3, 0.25, 0), cex.axis= 1)
#   mtext("Fraction of Design Space", side = 1, line = 1, cex = 1)
#   mtext("Relative Prediction Variance", side = 2, line = 1.5, cex = 1)
# }
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
