#### TO DO (R fxns)
# -design_select (grabs the design row with geometry, distance, and n)
# -make plot_design (take any row in the df and plot design, for H or S geom)
# -make rel_eff_table (gives table of relative efficiency)
# -fds_plot (you input diff designs and it gives the resulting fds plot)

my_design <- select_design(geometry = "hypercube", distance = "chebyshev", n = 30)

design[2]

design[1] # gives us score
design[5] # gives us n

design[4] # gives us k
design[5] # gives us n

my_design$geometry
my_design$distance
my_design$geometry

paste0(my_design$distance, " optimal design")

relative_efficiency(design1, design2, design3)

parse_design_to_rmat(my_design)

parse_design_to_rmat(DoEAna[1, ])

data("DoEAna")



