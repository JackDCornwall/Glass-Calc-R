#Takes an input from BulkFiltering_stage1_060724.R and performs additional filtering

#clearing crap
rm(list=ls())

#setting wd
wd="C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Bulk Filtering/"
setwd(wd)

#importing external functions
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Glass_Calc_Function.R")

#importing compositiopns in wt. fr.
comp_wt_temp <- read.csv("Stage1_export_050924.csv")

#Running glass calc
data <- Glass_calc_func(comp_wt_temp)

#preparing export data
comp_wt <- data$comp_wt
comp_mol <- data$comp_mol

#transposing & correcting for filtering
comp_wt <- as.data.frame(t(comp_wt))
colnames(comp_wt) <- comp_wt[1,] #fixing colnames
comp_wt <- comp_wt[-1,]

comp_mol <- as.data.frame(t(comp_mol))
colnames(comp_mol) <- comp_mol[1,] #fixing colnames
comp_mol <- comp_mol[-1,]

#Applying filters
comp_wt <-comp_wt[comp_wt$SM_opt<0.01,]
comp_wt <-comp_wt[comp_wt$SM_opt>-0.01,]
comp_wt <-comp_wt[comp_wt$DC<0.2601,]
comp_wt <-comp_wt[comp_wt$DC>0.2599,]

comp_mol <-comp_mol[comp_mol$SM_opt<0.01,]
comp_mol <-comp_mol[comp_mol$SM_opt>-0.01,]
comp_mol <-comp_mol[comp_mol$DC<0.2601,]
comp_mol <-comp_mol[comp_mol$DC>0.2599,]

#exporting data
write.csv(comp_wt, "comp_wt_export.csv", row.names = FALSE)
write.csv(comp_mol, "comp_mol_export.csv", row.names = FALSE)