#Function that takes in all the parameters required to calculate SM 
#and then calculates SM. Can be used for both optimised and conservative.

#defining algebra that will beed to be done (T_var exists becasuse T means TRUE)
SM_math <-function(a,b,c,X,Y,Z,U,T_var,V,W,Na2O,CaO,MgO,Li2O,K2O,Al2O3,Fe2O3,SiO2,P2O5,B2O3){
  
  #Calculating A B & C
  A <- Na2O + U*CaO +V*MgO + Y*Li2O + Z*K2O
  B <- Al2O3 + W*Fe2O3
  C <- SiO2 + T_var*P2O5 + X*B2O3
  
  #Calculating P value
  P = -1*(((b*C)+(2*b*B)-(sqrt(3)*C)) / (2*(A+B+C))) -1*((c*(2*B+C)^2) / (4*(A+B+C)^2)) - a
  #Note calculations are made using non normalised values!!!
  
  #Calculating normalised A B and C values
  A_norm = A / (A+B+C)
  B_norm = B / (A+B+C)
  C_norm = C / (A+B+C)
  
  #Forming list 
  return(list(
    "P" = P,
    "A_norm" = A_norm,
    "B_norm" = B_norm,
    "C_norm" = C_norm
              ))
}