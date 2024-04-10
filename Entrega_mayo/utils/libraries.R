load_libraries <- function() {
  libraries <- c("VGAM","patchwork", "evd", "lubridate", "dplyr", "ggplot2", "urca", "tseries")
  
  for (lib in libraries) {
    if (!requireNamespace(lib, quietly = TRUE)) {
      install.packages(lib)
      library(lib, character.only = TRUE)
    }
  }
}

# Call the function to load libraries
load_libraries()
