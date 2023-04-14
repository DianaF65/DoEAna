test_that("all dist fxns and min dist work", {
  data("DoEAna")
  for (i in seq_len(nrow(DoEAna))){
    design <- parse_design_to_rmat(DoEAna[i, ])
    if (DoEAna[i, 6] == "euclidean"){
      expect_equal(round(min_dist(design, dist_fx = euclidean_dist),
                         digits = 3), round((DoEAna[i, 1]), digits = 3))
    } else if (DoEAna[i, 6] == "chebyshev"){
      expect_equal(round(min_dist(design, dist_fx = chebyshev_dist),
                         digits = 3), round((DoEAna[i, 1]), digits = 3))
    } else if (DoEAna[i, 6] == "manhattan"){
      expect_equal(round(min_dist(design, dist_fx = manhattan_dist),
                         digits = 3), round((DoEAna[i, 1]), digits = 3))
    }
  }
})
