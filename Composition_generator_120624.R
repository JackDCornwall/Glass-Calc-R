#code that generates many combinations of compositions based on specific inputs and then stores only those that add up to 100.
#I would kindly like to thank Chat GPT for its help in generating this code as my version was going to take 700,000 years.

#clearing crap
rm(list=ls())

#setting wd
wd="C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/"
setwd(wd)

# Define the ranges and step sizes for each oxide component
ranges <- list(
  Al2O3 = seq(0.1, 0.25, by = 0.005),
  B2O3 = seq(0.07, 0.2, by = 0.005),
  #Bi2O3 = seq(0, 0.02, by = 0.005),
  CaO = seq(0, 0.04, by = 0.005),
  Cr2O3 = seq(0, 0.005, by = 0.0025),
  Fe2O3 = seq(0.02, 0.05, by = 0.005),
  K2O = seq(0, 0.01, by = 0.0025),
  Li2O = seq(0, 0.06, by = 0.005),
  Na2O = seq(0.1, 0.2, by = 0.005),
  #P2O5 = seq(0, 0.02, by = 0.005),
  SiO2 = seq(0.3, 0.45, by = 0.005),
  #SO3 = seq(0, 0.1, by = 0.005),
  TiO2 = seq(0, 0.05, by = 0.0025)
)

# Define the number of samples
num_samples <- 100000000
#num_samples <- 100000

# Create a progress bar
pb <- txtProgressBar(min = 0, max = num_samples, style = 3)

# Initialize an empty list to store valid combinations
valid_combinations <- list()

# Loop through samples and filter
for (i in 1:num_samples) {
  # Generate a random combination
  sample_combination <- lapply(ranges, function(x) sample(x, 1))
  sample_combination <- unlist(sample_combination)
  
  #stores a combination that sums to 1 as long as the below conditions are also met:
  if (round(sum(sample_combination), 5) == 1 &&
      abs(sample_combination["Al2O3"]/sample_combination["Na2O"] - 1.678943452) <= 1.678943452 * 0.05 #Matches ratio of Goel wt% 
      ){
    
    # Store the valid combination
    valid_combinations <- append(valid_combinations, list(sample_combination))
    
    
  }
  
  # Update the progress bar
  setTxtProgressBar(pb, i)
}

# Close the progress bar``
close(pb)

# Convert the list of valid combinations to a data frame
valid_combinations_df <- do.call(rbind, valid_combinations)
colnames(valid_combinations_df) <- names(ranges)

#storing file
write.csv(valid_combinations_df, "valid_combinations_050924.csv", row.names = FALSE)
