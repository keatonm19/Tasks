setwd("~/Desktop/Evolution/Tasks/my project hypothesis")

# Hypothesis: Development of Canine Tranmissible Venereal Tumors within canine populations with increase in frequency with increase in size and breed of the canine.
source("~/Desktop/Evolution/Tasks/my project hypothesis")
object<-source("ProjectHypothesis.csv")


write.csv(object, "ProjectHypothesis.csv", quote=T, row.names=TRUE )
Data<-read.csv("ProjectHypothesis.csv")