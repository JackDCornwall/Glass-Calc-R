#A function that takes in a df of oxide percentages
#and  returns the  ratio: Al2O3/(Na2O+Li2O+CaO)
Calc_16<-function(df){
  
  #importing required scripts
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/extract_component_value.R") #oxide finder
  
  #extracting required oxide values
  Al2O3 <- extr_comp_val("Al2O3",df)
  Na2O <- extr_comp_val("Na2O",df)
  Li2O <- extr_comp_val("Li2O",df)
  CaO <- extr_comp_val("Cao",df)
  
  #Calculating ratio
  Calc_16 <- Al2O3/(Na2O+Li2O+CaO)
  
  #Returning Value
  return(Calc_16)
  
}