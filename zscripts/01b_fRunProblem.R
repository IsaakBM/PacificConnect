
run <- function(data, outdir) {
  library(sf)
  library(dplyr)
  library(data.table)
  library(prioritizr)
  library(gurobi)
  library(stringr)
  
  d1 <- readRDS(data)
  d2 <- lapply(d1, function(x) {
    s1 <- solve(x, force = TRUE) %>%
      st_as_sf(sf_column_name = "geometry")})
  saveRDS(d2, paste0(outdir, "Sol_", unlist(strsplit(str_remove_all(basename(data), pattern = ".rds"), split = "_"))[[2]], ".rds"))
}

run(data = "/QRISdata/Q1216/BritoMorales/Project05d_Maya/Prioritisation/Problems/03a_ProblemsIUCNMico.rds", 
    outdir = "/QRISdata/Q1216/BritoMorales/Project05d_Maya/Prioritisation/Solutions/")