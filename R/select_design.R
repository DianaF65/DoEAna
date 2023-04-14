#' Select Design Function
#'
#' @param geometry Geometry of the design space, either 'simplex' or
#' 'hypercube'
#' @param distance Distance metric used in design, either 'manhattan',
#' 'chebyshev', or 'euclidean'
#' @param n Number of design points, either 10, 20, or 30
#'
#' @return Specified row of the DoEAna dataframe that can be used for further
#' analysis
#' @export
select_design <- function(geometry, distance, n) {
  if (!all(geometry %in% c("simplex", "hypercube"))) {
    stop(paste0("Geometry should be either 'simplex' or 'hypercube', not "
                , geometry))
  }
  if (!all(distance %in% c("manhattan", "chebyshev", "euclidean"))) {
    stop(paste0("Distance should be either 'manhattan', 'chebyshev',
                or 'euclidean', not ", distance))
  }
  if (!all(n %in% c(10, 20, 30))) {
    stop(paste0("N should be either 10, 20, or 30, not ", n))
  }
  DoEAna = load(DoEAna)
  DoEAna[which((DoEAna$geometry == geometry) & (DoEAna$n == n) &
                 (DoEAna$distance == distance)), ]
}
