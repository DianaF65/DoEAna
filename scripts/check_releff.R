data("sf_designs")
my_designM <- select_design(d_data = sf_designs,
                            geometry = "hypercube",
                           distance = "manhattan", n = 30)

my_designE <- select_design(d_data = sf_designs,
                            geometry = "hypercube",
                           distance = "euclidean", n = 30)

my_designC <- select_design(d_data = sf_designs,
                            geometry = "hypercube",
                           distance = "chebyshev", n = 30)

relative_efficiency(m_row = my_designM, e_row = my_designE, c_row = my_designC)

for (i in 1:3){
  n = i * 10
  my_designM <- select_design(d_data = sf_designs,
                              geometry = "hypercube",
                              distance = "manhattan", n)
  my_designE <- select_design(d_data = sf_designs,
                              geometry = "hypercube",
                              distance = "euclidean", n)
  my_designC <- select_design(d_data = sf_designs,
                              geometry = "hypercube",
                              distance = "chebyshev", n)

}
