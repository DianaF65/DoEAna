minDist <- function(X, distFx) {
  distances <- numeric()
  for (i in seq_len(nrow(X))) {
    for (j in seq_len(nrow(X))) {
      if (i < j) {
        ij_dist <- distFx(X[i, ], X[j, ])
        distances <- c(distances, ij_dist)
      }
    }
  }
  min_dist <- min(distances)
  out <- list(min_dist, distances)
  return(out)
}

eDist <- function(A, B) {
  sumDist = 0.0
  for (i in seq_len(length(A))) {
    sumDist <- sumDist + (A[i] - B[i]) ^ 2
  }
  dist <- sqrt(sumDist)
  return(dist)
}

lpNorm <- function(A, B, p = 2) {
  sumDist <- 0.0
  for (i in seq_len(length(A))) {
    sumDist <- sumDist + (A[i] - B[i]) ^ p
  }
  dist <- sumDist ^ (1 / p)
  return(dist)
}
