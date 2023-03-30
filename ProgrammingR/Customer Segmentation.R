data<-read.csv("Train.csv")
data<-data[,2:9]
summary(data)
unique(data$Profession)
data[data==""]<-NA
data<-data[complete.cases(data),]
#install.packages("dplyr")
library(dplyr)
dataset<-data%>%select_if(is.numeric)
character<-data%>%select_if(is.character)
#transform character into numerical/dummy
#install.packages("fastDummies")
library(fastDummies)
character<-dummy_cols(character,remove_most_frequent_dummy = TRUE)
#finalise the data set
dataset<-cbind(dataset,character[,6:18])
#scale the dataset
dataset[,1:16]<-scale(dataset[,1:16])
#determining the  amount of segement
#install.packages("factoextra")
library(factoextra)
fviz_nbclust(dataset,centers=6,iter.max=10)+
labs(subtitle = "Elbow Method")
#cluster
clusters <-kmeans(dataset,centers = 6,iter.max = 10)
clusters$centers
write.csv(clusters$centers,file = "clusters.csv")
dataset<-cbind(dataset,clusters$cluster)
