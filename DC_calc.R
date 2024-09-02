#A script that takes in the required oxide weight percentages
#and returns difference based on correlation or DC
DC_calc<-function(df){
  
  #importing required scripts
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/extract_component_value.R") #oxide finder
  
  #extracting required oxide values
  Al2O3 <- extr_comp_val("Al2O3",df)
  Cr2O3 <- extr_comp_val("Cr2O3",df)
  P2O5 <- extr_comp_val("P2O5",df)
  K2O <- extr_comp_val("K2O",df)
  Na2O <- extr_comp_val("Na2O",df)
  Li2O <- extr_comp_val("Li2O",df)
  TiO2 <- extr_comp_val("TiO2",df)
  B2O3 <- extr_comp_val("B2O3",df)
  Ce2O3 <- extr_comp_val("Ce2O3",df)
  La2O3 <- extr_comp_val("La2O3",df)
  Nd2O3 <- extr_comp_val("Nd2O3",df)
  CeO2 <- extr_comp_val("CeO2",df)
  SO3 <- extr_comp_val("SO3",df)
  MoO3 <- extr_comp_val("MoO3",df)
  CdO <- extr_comp_val("CdO",df)
  PdO <- extr_comp_val("PdO",df)
  NiO <- extr_comp_val("NiO",df)
  SrO <- extr_comp_val("SrO",df)
  ZrO2 <- extr_comp_val("ZrO2",df)
  
  #Calculating DC
  DC <- (Al2O3+Cr2O3+P2O5+K2O+Na2O+Li2O+TiO2) - (B2O3+Ce2O3+La2O3+Nd2O3+CeO2+SO3+MoO3+CdO+PdO+NiO+SrO+ZrO2)
  
  #returnign DC value
  return(DC)
}