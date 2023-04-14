#### vignette outline

# our fxns
# -design_select (grabs the design row with geometry, distance, and n)
# -make plot_design (take any row in the df and plot design, for H or S geom)
# -make rel_eff_table (gives table of relative efficiency)
# -fds_plot (you input diff designs and it gives the resulting fds plot)

# select a design (hypercube)
my_design_hyper <- select_design(geometry = "hypercube", distance = "chebyshev", n = 30)

# show the design matrix
print_design(my_design_hyper)

# plot the design
plot_design(my_design_hyper)

# or for the simplex
my_design_sim <- select_design(geometry = "simplex", distance = "chebyshev", n = 30)
print_design(my_design_sim)
plot_design(my_design_sim)

# compare designs with rel eff and fds plots
# compare across diffrent distances with releff
my_designM <- select_design(geometry = "hypercube",
                            distance = "manhattan", n = 10)
my_designE <- select_design(geometry = "hypercube",
                            distance = "euclidean", n = 10)
my_designC <- select_design(geometry = "hypercube",
                            distance = "chebyshev", n = 10)

relative_efficiency(m_row = my_designM, e_row = my_designE, c_row = my_designC)




