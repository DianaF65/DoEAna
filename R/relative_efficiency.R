relative_efficiency <- function(designs, distances){
  #make rel_eff_table (gives table of relative efficiency)


}

# old Julia code
# function relEff(m_df, e_df, c_df; metrics = [manhattan_minDist, euclidean_minDist, chebyshev_minDist])
# num_candidates = 3
# all_eff = zeros(num_candidates, num_candidates)
#
# m_best = parseToMatrix(m_df[1,5])
# e_best = parseToMatrix(e_df[1,5])
# c_best = parseToMatrix(c_df[1,5])
# all_candidates = [m_best, e_best, c_best]
#
# m_score = m_df[1,4]
# e_score = e_df[1,4]
# c_score = c_df[1,4]
# all_scores = [m_score, e_score, c_score]
#
# for i in 1:num_candidates
# for j in 1:num_candidates
# eval_metric = metrics[i]
# to_eval = all_candidates[j]
# top_eval = eval_metric(to_eval)
# rel_eff = (top_eval / all_scores[i])* 100
# all_eff[i, j] = rel_eff
# end
# end
# return all_eff
# end
#


# function matrixToDf(matrix)
# dataFrame = DataFrame(matrix,:auto)
# dataFrame = rename!(dataFrame,:x1 => :M, :x2 => :E, :x3 => :C)
# label = ["M(x)", "E(x)", "C(x)"]
# dataFrame.label = label
# dataFrame = dataFrame[!, [4, 1, 2, 3]]
# return dataFrame
# end

# example of running Julia fxn

#------- comparing n = 10
# m_n10_df = DataFrame(CSV.File("Results/0.1_k2n10manhattan.csv"))
# e_n10_df = DataFrame(CSV.File("Results/0.1_k2n10euclid.csv"))
# c_n10_df = DataFrame(CSV.File("Results/0.1_k2n10chebyshev.csv"))
#
# n10re = relEff(m_n10_df, e_n10_df, c_n10_df)
# n10re_df = matrixToDf(n10re)
# CSV.write("Results/0.1_k2n10releff.csv", n10re_df)

