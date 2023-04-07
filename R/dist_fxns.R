# min dist fxn (min distance between all rows in a matrix)

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

# eDist function
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

# Chebyshev function
chebyshev_dist <- function(A, B) {
  all_dist <- numeric()
  for (i in seq_along(A)) {
    ith_dist <- abs(A[i] - B[i])
    all_dist <- c(all_dist, ith_dist)
  }
  dist <- max(all_dist)
  return(dist)
}


# lpNorm function
lp_norm <- function(A, B, p = 2) {
  sum_dist <- 0.0
  dim = nrow(A)
  for (i in seq_along(A)) {
    sum_dist <- sum_dist + abs((A[i] - B[i])) ^ p
  }
  dist <- sum_dist ^ (1 / p)
  return(dist)
}

