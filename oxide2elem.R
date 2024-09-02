#A script that takes in an oxide and returns individual elements as well as returning stats about it required in other scripts
oxide2elem <- function(oxide){
  
  #importing database
  elem_amu <- read.csv("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Element_amu_120424.csv")
  
  #creating export dataframe
  export <- data.frame(oxide = character(), element = character(), count = integer(), amu = integer(), stringsAsFactors = FALSE)
  
  #reading in element AMU table
  #elem_amu <- read.csv("C://Users/Jack/Documents/University/PhD/Code/Glass Calc R/Element_amu_120424.csv")
  
  #extracting capitals from oxide
  caps<-gregexpr("[A-Z]",oxide)

  #looping through each capital letter found
  for(i in 1:length(caps[[1]])){
    
    #starting character
    start<-caps[[1]][i]
    
    #if last capital, then rest of string is selected
    if(i == length(caps[[1]])){
      
      end<-nchar(oxide)
      
    }else{ #otherwise up to next capital is selected.
      
      end<-caps[[1]][i+1]-1
      
    }
    
    #extracting element
    elem<-substr(oxide,start=start, stop=end)
    
    #checking if a number present in elem
    if(grepl("[0-9]",elem)){
      
      count<-as.numeric(gsub("\\D","",elem)) #removing any character that is not a digit
      
      elem<-gsub("\\d","",elem) #removing number from element now that count is stored
      
    }else{ # count is one if no number is present 
      
      count = 1 #only 1 present & elem  is already correct
    }
    
    #looking up AMU value for element
    amu <- elem_amu$amu[which(elem_amu$element==elem)]
      
    #storing in export df
    new_row <- data.frame(oxide = oxide, element = elem, count = as.numeric(count),amu = as.numeric(amu), stringsAsFactors = FALSE)
    export <- rbind(export, new_row)
    
  }
  
 return(export)
  
  
}
