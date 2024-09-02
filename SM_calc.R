#function that takes in a df with 2 columns
#one contains oxide list and one cotnains wt%
#it will then calculate SM value and return in wt%

#defining function
SM_calc <-function(df){
  
  #importing required scripts
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/extract_component_value.R") #oxide finder
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/SM_maths.R") #SM maths script to perform the calculation
  
  #extracting component values
  Na2O <- extr_comp_val("Na2O",df)
  CaO <- extr_comp_val("CaO",df)
  MgO <- extr_comp_val("MgO",df)
  Li2O <- extr_comp_val("Li2O",df)
  K2O <- extr_comp_val("K2O",df)
  Al2O3 <- extr_comp_val("Al2O3",df)
  Fe2O3 <- extr_comp_val("Fe2O3",df)
  SiO2 <- extr_comp_val("SiO2",df)
  P2O5 <- extr_comp_val("P2O5",df)
  B2O3 <- extr_comp_val("B2O3",df)

  #importing SM parameters
  SM_params <- read.csv("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/SM_params_260324.csv")
  
  #extracting params
  a_opt <- SM_params$optimal[which(SM_params$value=="a")]
  a_con <- SM_params$conservative[which(SM_params$value=="a")]
  b_opt <- SM_params$optimal[which(SM_params$value=="b")]
  b_con <- SM_params$conservative[which(SM_params$value=="b")]
  c_opt <- SM_params$optimal[which(SM_params$value=="c")]
  c_con <- SM_params$conservative[which(SM_params$value=="c")]
  X_opt <- SM_params$optimal[which(SM_params$value=="X")]
  X_con <- SM_params$conservative[which(SM_params$value=="X")]
  Y_opt <- SM_params$optimal[which(SM_params$value=="Y")]
  Y_con <- SM_params$conservative[which(SM_params$value=="Y")]
  Z_opt <- SM_params$optimal[which(SM_params$value=="Z")]
  Z_con <- SM_params$conservative[which(SM_params$value=="Z")]
  U_opt <- SM_params$optimal[which(SM_params$value=="U")]
  U_con <- SM_params$conservative[which(SM_params$value=="U")]
  T_opt <- SM_params$optimal[which(SM_params$value=="T")]
  T_con <- SM_params$conservative[which(SM_params$value=="T")]
  V_opt <- SM_params$optimal[which(SM_params$value=="V")]
  V_con <- SM_params$conservative[which(SM_params$value=="V")]
  W_opt <- SM_params$optimal[which(SM_params$value=="W")]
  W_con <- SM_params$conservative[which(SM_params$value=="W")]
  
  #Calculating SM optimal
  SM_opt <- SM_math(a_opt,b_opt,c_opt,X_opt,Y_opt,Z_opt,U_opt,T_opt,V_opt,W_opt,Na2O,CaO,MgO,Li2O,K2O,Al2O3,Fe2O3,SiO2,P2O5,B2O3)
  A_opt_norm <- SM_opt$A_norm
  B_opt_norm <- SM_opt$B_norm
  C_opt_norm <- SM_opt$C_norm
  
  #Calculating SM Conservative0
  SM_con <- SM_math(a_con,b_con,c_con,X_con,Y_con,Z_con,U_con,T_con,V_con,W_con,Na2O,CaO,MgO,Li2O,K2O,Al2O3,Fe2O3,SiO2,P2O5,B2O3)
  A_con_norm <- SM_con$A_norm
  B_con_norm <- SM_con$B_norm
  C_con_norm <- SM_con$C_norm
  
  #Returning both values as a list
  return(list(
    
    "SM_opt"=SM_opt,
    "SM_con"=SM_con,
    "A_opt_norm" = A_opt_norm,
    "B_opt_norm" = B_opt_norm,
    "C_opt_norm" = C_opt_norm,
    "A_con_norm" = A_con_norm,
    "B_con_norm" = B_con_norm,
    "C_con_norm" = C_con_norm
    
    ))
}