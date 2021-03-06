setwd("~/Desktop/Evolution/Tasks/Task_04")


Population 1
trueMean1<-5
trueSD1<-5
population1<-rnorm(1e6, trueMean1, trueSD1)


Population 2
trueMean2<-4
trueSD2<-5
population2<-rnorm(1e6, trueMean2, trueSD2)



Sampling Poplutaion
Size<-50
Sample1<-sample(population1, Size)
Sample2<-sample(population2, Size)
boxplot(Sample1, Sample2)
# The populations were very similar but the mean of population 2 was larger than that of population 1. There also seems to be more variance in population two.


# Reading in data
source("http://jonsmitchell.com/code/simFxn04.R")
MatGrandma<-makeFounder("grandma_mom")
MatGrandpa<-makeFounder("grandpa_mom")
PatGrandma<-makeFounder("grandma_da")
PatGrandpa<-makeFounder("grandpa_da")
nrow(MatGrandma)

Alan<-makeBaby(PatGrandma, PatGrandpa)
nrow(Alan)
Brenda<-makeBaby(MatGrandma, MatGrandpa)
Focus<-makeBaby(Brenda, Alan)
#50%
ToMOM<-length(grep("mom", Focus))/length(Focus)
ToMomMom<-length(grep("grandma_mom", Focus))/length(Focus)
ToMomDad<-length(grep("grandpa_mom", Focus))/length(Focus)
head(ToMomMom)
head(ToMomDad)

# the numbers should be 50/50 but this will not actually occur and do not meet this expectation

Sibling
Sibling_01<-makeBaby(Brenda, Alan)
#In a perfect world, you would expect the sibling to share atlest 50% DNA with Alan
ToSib<-length(intersect(Focus, Sibling_01))/length(Focus)
head(ToSib)
# 50% is not acutally shared between the two. It is much lower

ManySibilings<-replicate(1e3, length(intersect(Focus, makeBaby(Brenda, Alan)))/length(Focus))
head(ManySibilings)
#the amount of genes that he shares with each sibiling varies
ManySiblings<-replicate(1e3, length(intersect(Focus, makeBaby(Brenda, Alan)))/length(Focus))
quantile(ManySiblings)
mean(ManySiblings)
plot(density(ManySiblings), main"", xlab="proportion shared genes")
# a range of values is seen because these values have a large variety of change because the genes will randomly "mix" per kid. There is no set number of who gets what

IV:
HWE<-function(p) {
aa<-p^2
ab<-2*p*(1-p)
bb<-(1-p)^2
return(c(aa=aa, ab=ab, bb=bb))
}
HWE(0.5)


#Blank Plot
plot(1,1, type="n", xlim=c(0,1), ylim=c(0,1), xlab="freq. allele a", ylab="geno.freq")
p<-seq(from=0, to=1, by=0.01)
GenoFreq<-t(sapply(p, HWE))
lines(p, GenoFreq[,"aa"], lwd=2, col="red")
#aa individuals increases as the geno frequency increases. But at the geno frequency decreases so does the amount of aa individuals. This is not geographical space, this space is unknown. 



lines(p, GenoFreq[,"ab"], lwd=2, col="purple")
lines(p, GenoFreq[,"bb"], lwd=2, col="blue")

legend("top", legend=c("aa", "ab", "bb"), col=c("red", "purple", "blue"), lty=1, lwd=2, bty="n")

Pop<-simPop(500)
points(Pop[,"freqa"], Pop[,"Genotypes.aa"]/500, pch=21, bg="red")
#The first frequency does fall closely to the Hardy-Weinberg

Pop<-simPop(50)
points(Pop[,"freqa"], Pop[,"Genotypes.aa"]/50, pch=22, bg="red")
#This looks at a smaller population so the allele frequency will not be as large in a small population
Yes
V. Two-Allele Drift
install.packages("learnPopGen")
library(learnPopGen)


x<-genetic.drift(Ne=200, nrep=5, pause=0.01)

PopSizes<-5:50
Samples<-rep(PopSizes, 5)
tExt<-sapply(Samples, function(x) nrow(simPop(x,500)))
Line<-lm(tExt~Samples)
summary(Line)
Line$coef

plot(Samples, tExt)
abline(Line)

Line2<-lm(tExt~Samples+0)
 # as population size increases the dots are more spread from the line
 # meaning there is more variation within the population
 
install.packages("sandwich")
library(sandwich)

reg_ex1<-lm(lwage~exper+log(huswage),data=Samples)

lm(lwage~exper+log(huswage), data=Samples)
vcv <- vcovHAC(reg_ex1)
vcv<-vcovHAC(reg_exl)