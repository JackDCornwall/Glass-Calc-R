#function that will take in df with two columns
#the first includes oxide list, the second contains mol%
#the OB is then calculated in a loop
OB_calc <- function(df){
  
  #importing lambda and q values for different oxides
  #this will be used as a first attempt to extract the required values
  lambda_q <- read.csv("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/OB_lambda_q_values_061223.csv")
  
  #Importing rPauling electronegativity used to calculate a lambda  when a lambda value inst known
  electroneg <- read.csv("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Pauling_electronegativity_230424.csv")
  
  
  #OB calculation is a fraction of 2 sums these are initialised here
  numerator <- 0
  denominator <- 0
  
  #looping through each element and summing
  for (n in 1:nrow(df)){
    
    oxi <- df[n,1] #extracting oxide
    
    #checking if lambda is availalbe in the common table
    if (any(lambda_q$Oxide.list==oxi)){
      
      #lambda was found from calculated tables
      lambda <- lambda_q[lambda_q[,1]==oxi,2] #extracting lambda
      
      #extracting q
      q <- lambda_q[lambda_q[,1]==oxi, 3] 
      
    }else{ #not found in list so calculating with best possible model
      
      #extracting element data
      elem_data<-oxide2elem(oxi)
      
      #checking if any oxigens are present
      if(any(elem_data$element=="O")){
        
        #extracting number of oxigens
        q <- elem_data$count[which(elem_data$element=="O")]
        
      }else{
        
        #no oxigens found
        q <- 0
      }
      
      ####extracting pauling electronegativity
      #!!!!!!!!!for now this will only work for compounds containing 1 element other than oxygen. !!!!!!!!!!!!!!
      #extracting non oxigen element
      element <- elem_data$element[which(elem_data$element != "O")]
      #extracting electronegativitty
      x <- electroneg$electronegativity[which(electroneg$Element==element)]
      
      #Calculating gamma from 1/(1.36*(x-0.26))
      lambda <- 1 / (1.36 * (x - 0.26))
      
    }
    
    #updating sums
    numerator <- numerator + df[n,2] * lambda * q
    denominator <- denominator + df[n,2] * q
    
  }
  
  #OB calc
  OB <- numerator/denominator
  
  return(OB) #returning caluclated value
}