source("../extremales/Entrega_mayo/utils/libraries.R")
source("../extremales/Entrega_mayo/utils/dpg.R")
#
xaux <- seq(0, 10, length = 10000)
xi <- 0.2
sigma <- 1
mu <- 0
#
Fx <- dgp_distribution(xaux, xi, sigma, mu)
# Plot the distribution with improved appearance
plot(xaux, Fx, col = "red", type = "l", lwd = 2, ylim = c(0, 1), 
     xlab = "x", ylab = "F(x)", main = "Distribucion de Pareto Generalizada (DPG)", 
     sub = "Parameters: xi = 0.2, sigma = 1, mu = 0")
#
# Number of random combinations
num_combinations <- 3

# Set up the plotting layout
par(mfrow = c(1, num_combinations))

# Loop to generate random combinations and plot each distribution as a subplot
for (i in 1:num_combinations) {
  # Generate random values for mu, sigma, and xi within specified ranges
  mu <- runif(1, min = -0.1, max = 0.3)  # Adjust the range as needed
  sigma <- runif(1, min = 0, max = 0.5)   # Adjust the range as needed
  xi <- runif(1, min = -5, max = 5)     # Adjust the range as needed
  
  # Calculate Fx for the current combination
  Fx <- dgp_distribution(xaux, xi, sigma, mu)
  
  # Plot the distribution for the current combination
  plot(xaux, Fx, col = "green", type = "l", lwd = 2, ylim = c(0, 1), 
       xlab = "x", ylab = "F(x)", main = paste("Distribution Function (Combination", i, ")"), 
       sub = paste("Parameters: xi =", round(xi, 2), ", sigma =", round(sigma, 2), 
                   ", mu =", round(mu, 2)))
}
#