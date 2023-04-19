data("sf_designs")
my_design <- select_design(d_data = sf_designs, geometry = "hypercube", distance = "manhattan", n = 30)

dists <- c("manhattan", "euclidean", "chebyshev")
ns <- c(10, 20, 30 )

for (i in 1:3){
  for (j in 1:3){
    plot_design(select_design(d_data = sf_designs, geometry = "hypercube", distance = dists[i], n = ns[j]))
  }
}

for (i in 1:3){
  for (j in 1:3){
    plot_design(select_design(d_data = sf_designs, geometry = "simplex", distance = dists[i], n = ns[j]))
  }
}


png("simplex.png", res = 90)
plot_design(select_design(d_data = sf_designs, geometry = "simplex", distance = "chebyshev", n = 20))
dev.off()

