#This script is designed to be fed the input of Composition_generator_120624.R
#It then filters our compositions that dont meet certain cryteria such as:
#A given ratio between certain oxides

#clearing crap
rm(list=ls())

#setting wd
wd="C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Bulk Filtering/"
setwd(wd)

#importing extenal functions
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/wt2mol.R")
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/ND_calc.R")
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/OB_calc.R")
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/SM_calc.R")
source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/DC_calc.R")

#importing data in wt%
comp_wt_temp <- read.csv("valid_combinations_050924.csv")
#comp_wt_temp <- read.csv("Test_combinations.csv") #smaller file for testing.

#desired output:
#Nepheline ratio Al2O3/Na2O = 1.488513165 ¦ Al2O3/SiO2 = 0.537952011
#Alk sum  > .15
#SM = 0 
#DC = 1

######STAGE 1 - Performing Nepheline ratios and alk sum calculations

#creating empty store database
stage_1 <- comp_wt_temp[0, ]

#Create a progress bar
progress <- txtProgressBar(min = 0, max = nrow(comp_wt_temp)-1, style = 3)

#looping through each row 
for(i in 1:nrow(comp_wt_temp)){
  
  #Calculating sums and ratios for conditions
  Al2O3_Na2O = comp_wt_temp[i,]$Al2O3/comp_wt_temp[i,]$Na2O
  Al2O3_SiO2 = comp_wt_temp[i,]$Al2O3/comp_wt_temp[i,]$SiO2 #Nepheline specific
  Alk_sum = comp_wt_temp[i,]$Na2O + comp_wt_temp[i,]$Li2O + comp_wt_temp[i,]$K2O
  
  #checking desired conditions are met (ratios)
  if(
    Al2O3_Na2O > 1.5 & Al2O3_Na2O < 1.7 &
    #Al2O3_SiO2 > 0.5 & Al2O3_SiO2 < 0.6 & #can be removed as Nephe speciofic
    Alk_sum > .15
  ){
    
    #storing as acceptable initial conditions met
    stage_1 <- rbind(stage_1, comp_wt_temp[i,])
  }
  
  #Update the progress bar
  setTxtProgressBar(progress, i)
  
}

######STAGE 2 - performing SM/DC calculations

#importing stage 1 data
comp_wt_temp <- stage_1
comp_wt_temp <- t(comp_wt_temp) #transposing

#renaming columns with wt_
colnames(comp_wt_temp) <- paste0("wt_",1:ncol(comp_wt_temp))

#Exporting files ready for Glass_Calc R.R
write.csv(comp_wt_temp, "Stage1_export_050924.csv", row.names = TRUE)
