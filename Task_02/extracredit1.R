setwd("~/Desktop/Evolution/Tasks/Task_02")
beren3<-read.csv("beren_new.csv")
nap<-which(beren3$event == "nap")
beren4<-beren3[nap,]
timestart<-beren4$start_hour + beren4$start_minute/60
timeend<-beren4$end_hour + beren4$end_minute/60
duration<-timeend-timestart
duration[1:6]
totaltime<-tapply(beren4$value[nap], beren4$age[nap], sum)
numtime<-tapply(beren4$value[nap], beren4$age[nap], length)
cor(beren4$value[nap], beren4$age[nap])
cor.test(beren4$value[nap], beren4$age[nap])
berenCor<-cor.test(beren4$value[nap], beren4$age[nap])