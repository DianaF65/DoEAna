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

plot_hypercube <- function(data) {
  pdf("0.1_k2n10chebyshev.pdf")
  ml <- list()
  for(i in seq_len(nrow(data))) {
    ml[[i]] <- parseDesign_toRmatrix(data$optDes[i], N = 10, K = 2)

  }
  for(i in seq_len(nrow(data))) {
    main <- data$fgbest[i]
    Xt <- ml[[i]]
    plot(Xt[,1], Xt[,2], xlim = c(-1,1), ylim = c(-1,1), pch = 16, col = "blue",
         main = paste0("Min.Dist-Score = ", main))
  }
  dev.off()
}

parseDesign_toRmatrix <- function(d, N = 9, K = 2){
  t1 <- d
  nc <- nchar(t1)
  t1 <- substr(t1, start = 2, stop = nc-1)
  ot <- strsplit(t1, split = c(";"))[[1]]
  MM <- matrix(NA, nrow = N, ncol = K)
  for(i in 1:length(ot)){
    ttt     <- ot[i]
    spt     <- as.numeric(strsplit(ttt, split = " ")[[1]])
    spt2    <- spt[!is.na(spt)]
    MM[i, ] <- spt2
  }
  return(design = round(MM, 6))
}
