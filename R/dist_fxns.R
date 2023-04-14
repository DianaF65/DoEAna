#' Minimum Distance Function
#'
#' This function determines the minimum distance between all rows
#' in a matrix
#'
#' @param X The matrix for which the minimum distance between all rows will
#'  be found
#' @param dist_fx The distance between two rows of a matrix (check this)
#'
#' @return The minimum distance between all rows in a matrix
#' @export
min_dist <- function(X, dist_fx) {
  distances <- numeric()
  for (i in seq_len(nrow(X))) {
    for (j in seq_len(nrow(X))) {
      if (i < j) {
        ij_dist <- dist_fx(X[i, ], X[j, ])
        distances <- c(distances, ij_dist)
      }
    }
  }
  min_dist <- min(distances)
  return(min_dist)
}

# Distance functions

#' Euclidean Distance
#'
#' This function calculates the Euclidean distance between two points
#'
#' @param A A vector
#' @param B A vector
#'
#' @return A value representing the distance
#' @export
euclidean_dist <- function(A, B) {
  sum_dist = 0.0
  for (i in seq_along(A)) {
    sum_dist <- sum_dist + (A[i] - B[i]) ^ 2
  }
  dist <- sqrt(sum_dist)
  return(dist)
}

# Manhattan wrapper
manhattan_dist <- function(A, B) {
  lp_norm(A, B, p = 1)
}

#' Chebyshev function
#'
#' This function calculates the Chebyshev distance between two points
#'
#' @param A A vector
#' @param B A vector
#'
#' @return A value which is the distance
#' @export
chebyshev_dist <- function(A, B) {
  all_dist <- numeric()
  for (i in seq_along(A)) {
    ith_dist <- abs(A[i] - B[i])
    all_dist <- c(all_dist, ith_dist)
  }
  dist <- max(all_dist)
  return(dist)
}

# lp_norm function
lp_norm <- function(A, B, p = 2) {
  sum_dist <- 0.0
  dim = nrow(A)
  for (i in seq_along(A)) {
    sum_dist <- sum_dist + abs((A[i] - B[i])) ^ p
  }
  dist <- sum_dist ^ (1 / p)
  return(dist)
}

