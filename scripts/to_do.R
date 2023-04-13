#### TO DO (R fxns)
# -design_select (grabs the design row with geometry, distance, and n)
# -make plot_design (take any row in the df and plot design, for H or S geom)
# -make rel_eff_table (gives table of relative efficiency)
# -fds_plot (you input diff designs and it gives the resulting fds plot)

my_design <- select_design(geometry = "simplex", distance = "chebyshev", n = 30)


plot_simplex(my_design)
