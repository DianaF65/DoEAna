#' Minimum Distance Function
#'
#' This function determines the minimum distance between all rows
#' in a matrix
#'
#' @param x The matrix for which the minimum distance between all rows will
#'  be found
#' @param dist_fx The distance between two rows of a matrix (check this)
#'
#' @return The minimum distance between all rows in a matrix
#' @export
min_dist <- function(x, dist_fx) {
  distances <- numeric()
  for (i in seq_len(nrow(x))) {
    for (j in seq_len(nrow(x))) {
      if (i < j) {
        ij_dist <- dist_fx(x[i, ], x[j, ])
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
#' @param a A vector
#' @param b A vector
#'
#' @return A value representing the distance
#' @export
euclidean_dist <- function(a, b) {
  sum_dist <- 0.0
  for (i in seq_along(a)) {
    sum_dist <- sum_dist + (a[i] - b[i]) ^ 2
  }
  dist <- sqrt(sum_dist)
  return(dist)
}

# Manhattan wrapper
manhattan_dist <- function(a, b) {
  lp_norm(a, b, p = 1)
}

#' Chebyshev function
#'
#' This function calculates the Chebyshev distance between two points
#'
#' @param a A vector
#' @param b A vector
#'
#' @return A value which is the distance
#' @export
chebyshev_dist <- function(a, b) {
  all_dist <- numeric()
  for (i in seq_along(a)) {
    ith_dist <- abs(a[i] - b[i])
    all_dist <- c(all_dist, ith_dist)
  }
  dist <- max(all_dist)
  return(dist)
}

# lp_norm function
lp_norm <- function(a, b, p = 2) {
  sum_dist <- 0.0
  for (i in seq_along(a)) {
    sum_dist <- sum_dist + abs((a[i] - b[i])) ^ p
  }
  dist <- sum_dist ^ (1 / p)
  return(dist)
}
