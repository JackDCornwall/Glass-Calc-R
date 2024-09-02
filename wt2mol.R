#function that takes in a df with 2 columns
#one contains oxide list and one cotnains wt%
#it will spit out similar df containing mol%
wt2mol <-function(df) {
  
  #importing required packages
  source("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/oxide2elem.R") #oxide finder
  
  #adding new column to contain mol$
  df[, 3] <- NA
  #renaming
  colnames(df)[3] <- colnames(df)[2]
  colnames(df)[3] <- gsub("wt_","mol_",colnames(df)[3])
  
  temp_sum <- 0 #temporary value (sum of(oxide mass/oxide AMU)) needed further in calc
  
  #looping through each row of the df to calculate required sums SUM(wt%/amu of ith oxide)
  for (n in 1:(nrow(df))){
    
    #extracting oxide
    oxi <- df[n,1]
    
    #extracting element data
    elem_data<-oxide2elem(oxi)

    #cacluclating oxide amu based on elemetn amu
    oxi_amu <- 0 #resetting oxide amu value
    for (m in 1: nrow(elem_data)){
      
      oxi_amu <- oxi_amu + (elem_data$count[m] * elem_data$amu[m])
    }
    
    #summing temp sum (wt%/amu of ith oxide)
    temp_sum <- temp_sum + df[,2][n]/oxi_amu
    
  }
  
  #looping through to calculate mol% of each oxide now that temp is known
  for (l in 1:nrow(df)){
    
    #extracting oxide
    oxi <- df[l,1]
    
    #extracting element data
    elem_data<-oxide2elem(oxi)
    
    #cacluclating oxide amu based on elemetn amu
    oxi_amu <- 0 #resetting oxide amu value
    for (m in 1: nrow(elem_data)){
      
      oxi_amu <- oxi_amu + (elem_data$count[m] * elem_data$amu[m])
    }
    
    #storing mol% for oxide
    df[,3][l] <- df[,2][l] / (temp_sum * oxi_amu)
    
  }
  
  
  #simply returning mol% not wt%
  df <- df[, c(1,3)]
  
  #returning caluclated value
  return(df)
  
}