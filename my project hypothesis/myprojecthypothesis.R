setwd("~/Desktop/Evolution/Tasks/my project hypothesis")

# Hypothesis: Development of Canine Tranmissible Venereal Tumors within canine populations with increase in frequency with increase in size and breed of the canine.
source("~/Desktop/Evolution/Tasks/my project hypothesis")
object<-source("ProjectHypothesis.csv")


write.csv(object, "ProjectHypothesis.csv", quote=T, row.names=TRUE )
myData<-read.csv('ProjectHypothesis.csv', TRUE)
install.packages("ggpubr")
library("ggpubr")

myData[,3]

breed<-which(myData[,3])


counts<-table[1,3]
vector1=myData[,3]
head(vector1)
subject1=myData[1,]
head(subject1)
subject=myData[,1]
head(subject)
counts<-table(subject$breed)
install.packages("ggplot2")
library("ggplot2")
breed=myData[,3]
subject=myData[,1]
b<-c(67,39,21,15,13,2,1)
barplot(b, col="blue")