#A script that runs a wide array of other subfunctions for selected compositions

#clearing crap
rm(list=ls())

#setting wd
wd="C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/"
setwd(wd)

#importing external functions
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Glass_Calc_Function.R")

#importing data in wt%
#comp_wt_temp <- read.csv("CCC_data_280424.csv")
#comp_wt_temp <- read.csv("Test files/Test_file_6_230424_known.csv")
comp_wt_temp <- read.csv("AAA_temp_to run_file.csv")
#comp_wt_temp <- read.csv("valid_combinations_10000000_t.csv")

#Running glass calc
data <- Glass_calc_func(comp_wt_temp)

#preparing export data
comp_wt <- data$comp_wt
comp_mol <- data$comp_mol

#exporting data
write.csv(comp_wt, "comp_wt_export.csv", row.names = FALSE)
write.csv(comp_mol, "comp_mol_export.csv", row.names = FALSE)
