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
