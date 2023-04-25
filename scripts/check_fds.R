data("sf_designs")
my_design1 <- select_design(d_data = sf_designs, geometry = "hypercube", distance = "manhattan", n = 30)
my_design2 <- select_design(d_data = sf_designs, geometry = "hypercube", distance = "manhattan", n = 20)

fds_plot(design1 = my_design1, design2 = my_design2, title = "Hi there")

# need to make for simplex

my_design1 <- select_design(d_data = sf_designs, geometry = "simplex", distance = "manhattan", n = 30)
my_design2 <- select_design(d_data = sf_designs, geometry = "simplex", distance = "manhattan", n = 10)

# actually simplex model is way complicated
