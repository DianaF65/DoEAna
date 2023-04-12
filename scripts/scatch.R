data("DoEAna")
my_design <- select_design(geometry = "simplex", distance = "manhattan", n = 10)

plot_design(my_design)


design <- as.data.frame(parse_design_to_rmat(my_design))

print(plot_simplex(my_design))
