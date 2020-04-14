setwd("~/Desktop/Evolution/Tasks/Task_10")
library(phytools)
desired_length<-100
trees<-vector(mode="list", length=desired_length)
births<-rep(NA, desired_length)
fractions<-rep(NA, desired_length)
str(trees)