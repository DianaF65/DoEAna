# Distance functions
# eDist function
eDist <- function(A, B) {
  sumDist = 0.0
  dim = nrow(A)
  for (i in 1:dim) {
    sumDist <- sumDist + (A[i] - B[i]) ^ 2
  }
  dist <- sqrt(sumDist)
  return(dist)
}

# lpNorm function
lpNorm <- function(A, B, p = 2) {
  sumDist <- 0.0
  dim = nrow(A)
  for (i in 1:dim) {
    sumDist <- sumDist + (A[i] - B[i]) ^ p
  }
  dist <- sumDist ^ (1 / p)
  return(dist)
}

# simplex distance function
simplexDist <- function(A, B) {
  sumDist <- 0.0
  for (i in seq_len(length(A))) {
    for (j in seq_len(length(A))) {
      aLn <- log(A[i] / A[j])
      bLn = log(B[i] / B[j])
      sumDist <- sumDist + (aLn - bLn) ^ 2
    }
  }
  dist = sqrt(sumDist * (1 / (2 * length(A))))
  return(dist)
}

# Chebyshev function
chebyshev <- function(A, B) {
  allDist <- numeric()
  for (i in seq_len(length(A))) {
    ithDist <- abs(A[i] - B[i])
    allDist <- c(allDist, ithDist)
  }
  dist <- max(allDist)
  return(dist)
}
