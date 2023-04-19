test_that("all dist fxns and min dist work", {
  data("sf_designs")
  for (i in seq_len(nrow(sf_designs))) {
    design <- parse_design_to_rmat(sf_designs[i, ])
    if (sf_designs[i, 6] == "euclidean") {
      expect_equal(round(min_dist(design, dist_fx = euclidean_dist),
                         digits = 3), round((sf_designs[i, 1]), digits = 3))
    } else if (sf_designs[i, 6] == "chebyshev") {
      expect_equal(round(min_dist(design, dist_fx = chebyshev_dist),
                         digits = 3), round((sf_designs[i, 1]), digits = 3))
    } else if (sf_designs[i, 6] == "manhattan") {
      expect_equal(round(min_dist(design, dist_fx = manhattan_dist),
                         digits = 3), round((sf_designs[i, 1]), digits = 3))
    }
  }
})
