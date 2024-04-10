dgp_distribution <- function(data, xi, sigma, mu) {
  Fx <- 1 - (1 + (xi * (data - mu) / sigma))^(-1 / xi)
  return(Fx)
}