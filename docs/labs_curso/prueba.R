###########################################
# Define the function
pca_least_squares <- function(X, n_components) {
  # Calculate sample variance matrix
  Sigma_X <- cov(X)
  
  # Calculate eigenvectors and eigenvalues
  eig <- eigen(Sigma_X, symmetric = TRUE)
  
  # Sort eigenvectors by eigenvalues in descending order
  indices <- order(eig$values, decreasing = TRUE)
  eig$values <- eig$values[indices]
  eig$vectors <- eig$vectors[, indices]
  
  # Estimate Lambda
  Lambda_hat <- eig$vectors[, 1:n_components]
  
  # Estimate F
  F_hat <- t(Lambda_hat) %*% t(X) / nrow(X)
  
  # Normalize F to satisfy F'F/T = I
  F_hat <- F_hat / sqrt(ncol(X))
  
  return(list(Lambda_hat = Lambda_hat, F_hat = F_hat, eig$values=eig$values,  eig$vectors=eig$vectors))
}

# Example usage:
# Create a random matrix of dimensions 500 x 120
set.seed(1)
X <- matrix(rnorm(500 * 120), nrow = 500, ncol = 120)

# Specify the number of principal components
n_components <- 6

# Perform PCA using least squares method with specified number of components
result <- pca_least_squares(X, n_components)

# Access the estimated loading matrix (Lambda_hat)
Lambda_hat <- result$Lambda_hat

# Access the estimated principal components matrix (F_hat)
F_hat <- result$F_hat

#################################################################################
X <- scale(X, center = TRUE, scale=TRUE)
Sigma_X <- cor(X)
d=diag(1/500,nrow=500, ncol=500)

# Calculate eigenvectors and eigenvalues
eig <- eigen(Sigma_X, symmetric = TRUE)

# Sort eigenvectors by eigenvalues in descending order
indices <- order(eig$values, decreasing = TRUE)
eig$values <- eig$values[indices] # son los lamba_i
eig$vectors <- eig$vectors[, indices]

# Estimate Lambda
Lambda_hat <- eig$vectors[, 1:n_components]

# Estimate F
F_hat <- t(Lambda_hat) %*% t(X) / nrow(X)



# Normalize F to satisfy F'F/T = I
F_hat <- F_hat / sqrt(ncol(X))