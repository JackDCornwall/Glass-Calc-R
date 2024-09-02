#function that takes in a component name (such as an oxide) and a df with 2 columns
#one contains oxide list and one cotnains wt% or mol% as required.
#it will then return the w% or mol% of the corresponding oxide or altenratively 0 if not present

extr_comp_val<-function(comp,df){
  
  #finding row containing the component
  row_found<-which(df[,1]==comp)
  
  #check if component exists in the df
  if(length(row_found)==1){
    
    #returning wt% or mol% found
    return(df[,2][row_found])
  }else{
    
    #returning zero if not exactly one oxide found in list 
    #NOTE: this will also occur if more than one component 
    return(0)
    
  }
  
}