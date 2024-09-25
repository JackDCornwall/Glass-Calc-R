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

#fixing annoying storing as character, at present I am unsure where this is happengin!
comp_wt <- data.frame(lapply(comp_wt, as.numeric))
comp_mol <- data.frame(lapply(comp_mol, as.numeric))

#Applying filters
comp_wt <-comp_wt[comp_wt$SM_opt<0.11,]
comp_wt <-comp_wt[comp_wt$SM_opt>-0.11,]
comp_wt <-comp_wt[comp_wt$DC<0.271,]
comp_wt <-comp_wt[comp_wt$DC>0.249,]

comp_mol <-comp_mol[comp_mol$SM_opt<0.11,]
comp_mol <-comp_mol[comp_mol$SM_opt>-0.11,]
comp_mol <-comp_mol[comp_mol$DC<0.271,]
comp_mol <-comp_mol[comp_mol$DC>0.249,]

#exporting data
write.csv(comp_wt, "comp_wt_export.csv", row.names = FALSE)
write.csv(comp_mol, "comp_mol_export.csv", row.names = FALSE)