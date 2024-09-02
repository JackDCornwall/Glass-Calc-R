#A function that takes in comp_wt and performs Glass_Calc_R
#The format needs to be:
#Each col is an individual composition titled wt_#
#Each row is an oxide (usually weight fraction)
Glass_calc_func<-function(df){
  
  #importing extenal functions
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/wt2mol.R")
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/ND_calc.R")
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/OB_calc.R")
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/SM_calc.R")
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/DC_calc.R")
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Calc_16.R")
  
  #df renaming
  df <- comp_wt_temp
  
  comp_wt <- comp_wt_temp #creating wt export
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for ND
  comp_wt[nrow(comp_wt),1] <- "ND" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for OB
  comp_wt[nrow(comp_wt),1] <- "OB" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_optimal
  comp_wt[nrow(comp_wt),1] <- "SM_opt" # adding label
  
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "A_opt_norm" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "B_opt_norm" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "C_opt_norm" # adding label
  
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "SM_con" # adding label
  
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "A_con_norm" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "B_con_norm" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for SM_conservative
  comp_wt[nrow(comp_wt),1] <- "C_con_norm" # adding label
  
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for DC
  comp_wt[nrow(comp_wt),1] <- "DC" # adding label
  comp_wt <- rbind(comp_wt, rep(NA, ncol(comp_wt))) # adding row for Calc_1.6 Ratio
  comp_wt[nrow(comp_wt),1] <- "Calc_16" # adding label
  
  comp_mol <- comp_wt #creating mol% export
  comp_mol[, c(2:ncol(comp_mol))] <- NA
  colnames(comp_mol) <- gsub("wt","mol",colnames(comp_mol)) # renaming wt to mol
  
  #Create a progress bar
  progress <- txtProgressBar(min = 0, max = ncol(comp_wt_temp)-1, style = 3)
  
  #looping through each composition in the imported wt% data
  for (i in 1:(ncol(comp_wt_temp)-1)) {
    
    #converting from wt% to mol%
    comp_mol_temp <- wt2mol(comp_wt_temp[, c(1, i+1)])
    
    #calculating nepheline discriminator (ND)
    ND <- ND_calc(comp_wt_temp[, c(1, i+1)])
    
    #calculating optical basicity (OB)
    OB <- OB_calc(comp_mol_temp)
    
    #Calculating Submixture model value (SM)
    SM_temp <- SM_calc(comp_wt_temp[, c(1, i+1)])
    
    SM_opt <- SM_temp$SM_opt
    SM_con <- SM_temp$SM_con
    
    A_opt_norm <- SM_opt$A_norm
    B_opt_norm <- SM_opt$B_norm
    C_opt_norm <- SM_opt$C_norm
    
    A_con_norm <- SM_con$A_norm
    B_con_norm <- SM_con$B_norm
    C_con_norm <- SM_con$C_norm
    
    SM_opt <- SM_temp$SM_opt$P
    SM_con <- SM_temp$SM_con$P
    
    #Calculating difference based on correlation (DC)
    DC <- DC_calc(comp_wt_temp[, c(1, i+1)])
    
    #Calculating 1.6 value
    Calc_ratio<-Calc_16(comp_wt_temp[, c(1, i+1)])
    
    #Calculating Cation Field Strengh Index (CFSI)
    
    #Calculating Non bridging oxygen per tetrahedron (NBO/T)
    
    #Calculating PC1 & PC2
    
    #Calculating Zone 1,2,3,4 zone
    
    #storing values for export
    comp_mol[1:nrow(comp_mol_temp),i+1] <- comp_mol_temp[, 2] # storing mol% values
    #storing ND in mol and wt tables
    comp_mol[comp_mol[, 1]=="ND",i+1] <- ND
    comp_wt[comp_wt[, 1]=="ND",i+1] <- ND
    #storing OB in mol and wt tables
    comp_mol[comp_mol[, 1]=="OB",i+1] <- OB
    comp_wt[comp_wt[, 1]=="OB",i+1] <- OB
    #storing SM_opt
    comp_mol[comp_mol[, 1]=="SM_opt",i+1] <- SM_opt
    comp_wt[comp_wt[, 1]=="SM_opt",i+1] <- SM_opt
    
    #storing A, B C, norm opt
    comp_mol[comp_mol[, 1]=="A_opt_norm",i+1] <- A_opt_norm
    comp_wt[comp_wt[, 1]=="A_opt_norm",i+1] <- A_opt_norm
    
    comp_mol[comp_mol[, 1]=="B_opt_norm",i+1] <- B_opt_norm
    comp_wt[comp_wt[, 1]=="B_opt_norm",i+1] <- B_opt_norm
    
    comp_mol[comp_mol[, 1]=="C_opt_norm",i+1] <- C_opt_norm
    comp_wt[comp_wt[, 1]=="C_opt_norm",i+1] <- C_opt_norm
    
    
    #storing SM_con
    comp_mol[comp_mol[, 1]=="SM_con",i+1] <- SM_con
    comp_wt[comp_wt[, 1]=="SM_con",i+1] <- SM_con
    
    #storing A, B C, norm con
    comp_mol[comp_mol[, 1]=="A_con_norm",i+1] <- A_con_norm
    comp_wt[comp_wt[, 1]=="A_con_norm",i+1] <- A_con_norm
    
    comp_mol[comp_mol[, 1]=="B_con_norm",i+1] <- B_con_norm
    comp_wt[comp_wt[, 1]=="B_con_norm",i+1] <- B_con_norm
    
    comp_mol[comp_mol[, 1]=="C_con_norm",i+1] <- C_con_norm
    comp_wt[comp_wt[, 1]=="C_con_norm",i+1] <- C_con_norm
    
    #storing DC
    comp_mol[comp_mol[, 1]=="DC",i+1] <- DC
    comp_wt[comp_wt[, 1]=="DC",i+1] <- DC
    #storing Calc 1.6 Ratio
    comp_mol[comp_mol[, 1]=="Calc_16",i+1] <- Calc_ratio
    comp_wt[comp_wt[, 1]=="Calc_16",i+1] <- Calc_ratio
    
    #Update the progress bar
    setTxtProgressBar(progress, i)
  }
  
  #Close the progress bar
  close(progress)
  
  #creating return
  return(list(comp_wt = comp_wt, comp_mol = comp_mol))
  
}