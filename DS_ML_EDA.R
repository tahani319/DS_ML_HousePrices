#01/12/2020
#EDA 
#House Price


#data from: https://www.kaggle.com/shree1992/housedata
#the data contains information  about houses in USA 
#contains 18 variables and 4600 observation
#my main goal is to building a model to predict the price of a house
#based on specific features of the house.


#so i start with EDA to understand my data :

#load packages 

library(tidyverse)
install.packages("ggcorrplot")#for correlation visualization
library(ggcorrplot)
library(corrplot) 
library(ggplot2)
library(reshape2)

#Read data: 

house <- read.csv("data/data.csv")

#Exploration Data:

head(house)
tail(house)
nrow(house)
ncol(house)
str(house)

#change statezip and city into factors 

house$statezip <- as.factor(house$statezip)
house$city <- as.factor(house$city)
house$street <- as.factor(house$street)


#change bathrooms, bedrooms into numeric 

house$price <- as.numeric(house$price)
house$bedrooms <- as.numeric(house$bedrooms)
house$bathrooms <- as.numeric(house$bathrooms)




#see distribution of price  

ggplot(house, aes(price)) +
  geom_density() 

#distribution of price is  positivly skewed 
 

#count values in price column 

house %>% count(price)

#it seems that we have 49 values of price is 0 so we will replace them 



#count values of bedrooms column 

house %>% count(bedrooms) #we have 2 valuse is 0 

house %>% count(bathrooms) #we have 2 valuse is 0 


# count values of view 
house %>% count(view) # we have 4140 valuse in view is 0 


#count values of waterfront 
house %>% count(waterfront) #we have 4567 valuse in view is 0




#we have statezip so we do not need for columns city, street 
#drop column of country because it has just one value 
#drop column of date beacuse it isn't necessary 


house <- subset( house , select = -c( date,country, street,city) )

str(house)




#outliers 

#check outlier in bedrooms

boxplot(house$bedrooms)
        
#check outliers in bathrooms 

boxplot(house$bathrooms)



#we have outliers values in bedrooms and bathrooms features 



#to see correlation 

#correlation matrix 

house1 <- house[c("price","bedrooms","bathrooms","floors","sqft_living",
"sqft_lot","sqft_above","sqft_basement","view","waterfront","condition",
"yr_built","yr_renovated")]


correlation_matrix <- cor(house1)
ggplot(melt(correlation_matrix), aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low="blue", mid="white", high="red") +
  coord_equal()


















