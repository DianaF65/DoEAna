#' Relative Efficiency
#'
#' This function takes in the different generated distances
#' and selects specific traits from each type.  With the
#' selected values, relative efficiency is done for each
#' distance on each score "(M(x), E(x), C(x)).  The output
#' will be a table with all efficiencies.
#'
#' @param m_row Generated with mahattan distance
#' @param e_row Generated with euclidean distance
#' @param c_row Generated with chebyshev distance
#'
#' @return A 3x3 data frame efficiency table
#' @export
relative_efficiency <- function(m_row, e_row, c_row) {
  if (m_row$distance != "manhattan") {
    stop(paste0("Distance for m_df should be 'manhattan', not ", m_row$distance))
  }
  if (e_row$distance != "euclidean") {
    stop(paste0("Distance for e_df should be 'euclidean', not ", e_row$distance))
  }
  if (c_row$distance != "chebyshev") {
    stop(paste0("Distance for c_df should be 'chebyshev', not ", c_row$distance))
  }

  m_best <- parse_design_to_rmat(m_row)
  e_best <- parse_design_to_rmat(e_row)
  c_best <- parse_design_to_rmat(c_row)
  all_candidates <- c(m_best, e_best, c_best)

  m_score <- m_row$score
  e_score <- e_row$score
  c_score <- c_row$score
  all_scores <- c(m_score, e_score, c_score)

  all_eff <- matrix(NA, nrow = 3, ncol = 3)
  metrics <- c(manhattan_dist, euclidean_dist, chebyshev_dist)
  for (i in seq_len(3)) {
    for (j in seq_len(3)) {
      eval_metrix <- metrics[i]
      to_eval <- all_candidates[j]
      top_eval <- min_Dist(to_eval, eval_metrix)
      rel_eff <- (top_eval / all_scores[i]) * 100
      all_eff[i, j] <- rel_eff
    }
  }
  df <- data.frame(all_eff)
  colnames(df) <- c(":M", ":E", ":C")
  rownames(df) <- c("M(x)", "E(x)", "C(x)")
  return(df)
}
