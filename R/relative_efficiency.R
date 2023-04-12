relative_efficiency <- function(m_df, e_df, c_df) {
  if (m_df$distance != "manhattan") {
    stop(paste0("Distance for m_df should be 'manhattan', not ", m_df$distance))
  }
  if (e_df$distance != "euclidean") {
    stop(paste0("Distance for m_df should be 'euclidean', not ", e_df$distance))
  }
  if (c_df$distance != "euclidean") {
    stop(paste0("Distance for m_df should be 'chebyshev', not ", c_df$distance))
  }

  m_best <- parse_design_to_rmat(m_df)
  e_best <- parse_design_to_rmat(e_df)
  c_best <- parse_design_to_rmat(c_df)
  all_candidates <- c(m_best, e_best, c_best)

  m_score <- m_df$score
  e_score <- e_df$score
  c_score <- c_df$score
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
