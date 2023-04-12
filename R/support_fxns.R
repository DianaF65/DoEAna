parse_design_to_rmat <- function(d, n = 10, k = 2){
  t1 <- d
  nc <- nchar(t1)
  t1 <- substr(t1, start = 2, stop = nc-1)
  ot <- strsplit(t1, split = c(";"))[[1]]
  MM <- matrix(NA, nrow = n, ncol = k)
  for(i in 1:length(ot)){
    ttt     <- ot[i]
    spt     <- as.numeric(strsplit(ttt, split = " ")[[1]])
    spt2    <- spt[!is.na(spt)]
    MM[i, ] <- spt2
  }
  return(design = round(MM, 6))
}
