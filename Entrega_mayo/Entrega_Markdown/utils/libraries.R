load_libraries <- function() {
  libraries <- c("VGAM","patchwork", "evd", "lubridate", "dplyr", "ggplot2", "urca", "tseries", "reticulate", "zoo", "xts", "aTSA")
  
  for (lib in libraries) {
    if (!requireNamespace(lib, quietly = TRUE)) {
      install.packages(lib)
      library(lib, character.only = TRUE)
    }
  }
}

