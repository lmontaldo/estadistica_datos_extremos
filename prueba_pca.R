# Define your function
pca_least_squares_df <- function(df, n_components) {
  # Convert dataframe to matrix
  X <- as.matrix(df)
  
  # Calculate sample variance matrix
  Sigma_X <- cov(X)
  
  # Calculate eigenvectors and eigenvalues
  eig <- eigen(Sigma_X)
  
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
  
  return(list(Lambda_hat = Lambda_hat, F_hat = F_hat))
}

# Assuming 'df' is your dataframe with 'Date' as the index
df <- df %>%
  mutate(Date = as.Date(Date)) %>%
  arrange(Date) %>%
  tibble::column_to_rownames(var = "Date")

# Specify the number of components
n_components <- 3  # Change this as needed

# Apply the function on the dataframe
result <- pca_least_squares_df(df, n_components)

# Print the result or further process it as needed
print(result)

install.packages('fmsb')
library(fmsb)

# Extract the loading matrix (Lambda_hat) from the result
Lambda_hat <- result$Lambda_hat

# Convert the loading matrix to a dataframe
loading_df <- data.frame(Lambda_hat)

# Add variable names to the dataframe
colnames(loading_df) <- paste("Factor", 1:ncol(Lambda_hat))

# Initialize a list to store the top variables for each factor
top_variables <- list()

# Loop through each factor and identify the variable with the highest absolute loading value
for (i in 1:ncol(loading_df)) {
  top_variables[[paste0("Factor", i)]] <- rownames(loading_df)[which.max(abs(loading_df[, i]))]
}

# Print the top variables for each factor
print(top_variables)

# Initialize a list to store the top 5 variables for each factor
top_variables <- list()

# Loop through each factor
for (i in 1:ncol(loading_df)) {
  # Sort the absolute loading values for the current factor in descending order
  sorted_loadings <- sort(abs(loading_df[, i]), decreasing = TRUE)
  
  # Identify the top 5 variables with the highest absolute loading values
  top_indices <- head(order(abs(loading_df[, i]), decreasing = TRUE), 5)
  top_variables[[paste0("Factor", i)]] <- rownames(loading_df)[top_indices]
}

# Print the top 5 variables for each factor
print(top_variables)

########
# Initialize a list to store the top 5 variables for each factor
top_variables <- list()

# Loop through each factor
for (i in 1:ncol(loading_df)) {
  # Sort the absolute loading values for the current factor in descending order
  sorted_loadings <- sort(abs(loading_df[, i]), decreasing = TRUE)
  
  # Identify the top 5 variables with the highest absolute loading values
  top_indices <- head(order(abs(loading_df[, i]), decreasing = TRUE), 5)
  top_variables[[paste0("Factor", i)]] <- rownames(loading_df)[top_indices]
}

# Print the top 5 variables for each factor
print(top_variables)
###########
# Initialize a list to store the top 5 variables for each factor
top_variables <- list()

# Loop through each factor
for (i in 1:ncol(loading_df)) {
  # Sort the absolute loading values for the current factor in descending order
  sorted_loadings <- sort(abs(loading_df[, i]), decreasing = TRUE)
  
  # Identify the top 5 variables with the highest absolute loading values
  top_indices <- head(order(abs(loading_df[, i]), decreasing = TRUE), 5)
  top_variables[[paste0("Factor", i)]] <- colnames(loading_df)[top_indices]
}

# Print the top 5 variables for each factor
print(top_variables)


k ubb6