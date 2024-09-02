#function that will take in df with two columns
#the first includes oxide list, the second contains wt%
#the ratio ND = SiO2/(SiO2+Na2O+Al2O3) is calculated
ND_calc <- function(df){
  
  #importing required scripts
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/extract_component_value.R") #oxide finder
  
  #Extracting required oxide values
  SiO2 <- extr_comp_val("SiO2",df)
  Na2O <- extr_comp_val("Na2O",df)
  Al2O3 <- extr_comp_val("Al2O3",df)
  
  
  ND <- SiO2 / (SiO2 + Na2O + Al2O3) #Calculating ND
  
  return(ND)
}