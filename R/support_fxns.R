#' print_design
#'
#' @param design_row a row in the DoEAna data set
#'
#' @return a matrix of the design.
#' @export
print_design <- function(design_row) {
  parse_design_to_rmat(design_row)
}

# This function takes a design and outputs a matrix.
parse_design_to_rmat <- function(design_row) {
  n <- design_row$n
  k <- design_row$k
  t1 <- design_row$design
  nc <- nchar(t1)
  t1 <- substr(t1, start = 2, stop = nc - 1)
  ot <- strsplit(t1, split = c(";"))[[1]]
  MM <- matrix(NA, nrow = n, ncol = k)
  for (i in 1:length(ot)){
    ttt     <- ot[i]
    spt     <- as.numeric(strsplit(ttt, split = " ")[[1]])
    spt2    <- spt[!is.na(spt)]
    MM[i, ] <- spt2
  }
  return(design = round(MM, 6))
}
