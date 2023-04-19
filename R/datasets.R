#' Optimal Space-filling designs data
#'
#' A collection of optimal Maxmin space-filling designs on the hypercube and
#' simplex for n = 10, 20, 30. There are k = 2 experimental factors for
#' the hypercube k = 3 for the simplex. These were found with three different
#' distance metrics: Manhattan, Euclidean, and Chebyshev.
#'
#'
#' @format ## `sf_designs`
#' A data frame with 18 rows and 6 columns:
#' \describe{
#'   \item{score}{Minimum distance between points on the design
#'   (distance metric varies)}
#'   \item{design}{Optimal design found under those conditions}
#'   \item{geometry}{Geometry of the design space, either hypercube or
#'   standard n-simplex}
#'   \item{k}{Number of experimental factors}
#'   \item{n}{Number of design points}
#'   \item{distance}{Distance metric used in design, either manhattan,
#'   euclidean, or chebyshev}
#' }
#' @source Particle Swarm Optimization searches run by Rebekah Scott for
#' undergraduate research at Utah State University.
"sf_designs"
