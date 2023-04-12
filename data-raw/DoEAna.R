## code to prepare `DoEAna` dataset goes here

# read in all file names
filenames <- list.files(path="C:/Users/rebek/github/packages/DoEAna/data-raw/all_csv_data",
                        pattern=".*csv")
# subset file names
names <-substr(filenames,3,12)

# load all files
all_raw_df_list <- vector(mode='list', length=length(filenames))
for(i in seq_along(filenames)){
  filepath <- file.path("C:/Users/rebek/github/packages/DoEAna/data-raw/all_csv_data",
                        paste(filenames[i],sep=""))
  if (substr(names[i],1,1) == "1"){
    substr(names[i],1,1) <- "H"
  } else if (substr(names[i],1,1) == "2"){
    substr(names[i],1,1) <- "S"
  }
  all_raw_df_list[[i]] <- read.csv(filepath)
}

# subset it to the first row and
for(i in seq_along(all_raw_df_list)){
  all_raw_df_list[[i]] <- all_raw_df_list[[i]][1,4:5]
}

# rename current cols
for(i in seq_along(all_raw_df_list)){
  colnames(all_raw_df_list[[i]]) <- c("score", "design")
}

# add cols for geometry based on file name
for(i in seq_along(all_raw_df_list)){
  if (substr(names[i],1,1) == "H"){
    all_raw_df_list[[i]]$geometry <- "hypercube"
  } else if (substr(names[i],1,1) == "S"){
    all_raw_df_list[[i]]$geometry <- "simplex"
  }
}

# assign k and n based on file name
for(i in seq_along(all_raw_df_list)){
  all_raw_df_list[[i]]$k <- as.integer(substr(names[i],4,4))
  all_raw_df_list[[i]]$n <- as.integer(substr(names[i],6,7))
}

# assign distance metric based on file name
for(i in seq_along(all_raw_df_list)){
  if (substr(names[i],8,11) == "che"){
    all_raw_df_list[[i]]$distance <- "chebyshev"
  } else if (substr(names[i],8,11) == "man"){
    all_raw_df_list[[i]]$distance <- "manhattan"
  } else if (substr(names[i],8,11) == "euc"){
    all_raw_df_list[[i]]$distance <- "euclidean"
  }
}

# bind the list to a data frame

DoEAna <- rbind(all_raw_df_list[[1]], all_raw_df_list[[2]], all_raw_df_list[[3]],
                all_raw_df_list[[4]], all_raw_df_list[[5]], all_raw_df_list[[6]],
                all_raw_df_list[[7]], all_raw_df_list[[8]], all_raw_df_list[[9]],
                all_raw_df_list[[10]], all_raw_df_list[[11]], all_raw_df_list[[12]],
                all_raw_df_list[[13]], all_raw_df_list[[14]], all_raw_df_list[[15]],
                all_raw_df_list[[16]], all_raw_df_list[[17]], all_raw_df_list[[18]])


usethis::use_data(DoEAna, overwrite = TRUE)
