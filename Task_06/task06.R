install.packages("coala")
install.packages("phytools")
?coalescent.plot()
install.packages("learnPopGen") 
library(coala)


coalescent.plot(n=5, ngen=10, col.order="alternating")
pdf("learnPopGen_SmallPopulation", height=4, width=4)
coalescent.plot(n=15, ngen=10, col.order="alternating")
pdf("learnPopGen_MediumPopulation", height=4, width=4)
coalescent.plot(n=35, ngen=10, col.order="alternating")

# The first graph starts with 5 alleles, the second 15 allels, and the last have 35 alleles. Each of these have a generation of 10. The number of offspring is dependent on the number of alleles. Fitness is dependent on the starting number and how many generations are seen. The MCA is not in generation 0. 
model<-coal_model(sample_size=5, loci_number=10, loci_length=500, ploidy=2)+
feat_mutation(10)+
feat_recombination(10)+
sumstat_trees()+
sumstat_nucleotide_div()
stats<-simulate(model, nsim=1)
Diversity<-stats$pi
head(Diversity)
# All the numbers are different because they are looking at the differences between different individuals 
Nloci<-length(stats$trees)

t1<-read.tree(text=stats$trees[[1]][1])
plot(t1)
axisPhylo()
#Q6: This only looks at some of the individuals and the MCRA
Agel<-max(nodeHeights(t1))
head(Agel)

t2<-read.tree(text=stats$trees[[2]][1])
plot(t2)
axisPhylo()
Agel<-max(nodeHeights(t2))
# The MRCA is #8

par(mfrow=c(1,2))
plot(t1)
axisPhylo()
plot(t2)
axisPhylo()
#Q7: These do not match.

compare.chronograms(t1,t2)

t1_1<-read.tree(text=stats$trees[[1]][1])
t1_2<-read.tree(text=stats$trees[[1]][2])
compare.chronograms(t1_1,t1_2)


for(locus in 1:Nloci) {
	ntrees<-length(stats$trees[[locus]])
	for(n in 1:ntrees) {
		if(locus==1 && n==1){
			outPhy<-read.tree(text=stats$trees[[locus]][n])
		}
		else { 
			outPhy<-ape:::c.phylo(outPhy, read.tree(text=stats$trees[[locus]][n]))  
		}
	}
}



	ntrees<-length(stats$trees[[locus]])
	for(n in 1:ntrees) {
		if(locus==1 && n==1) {
			outPhy<-read.tree(text=stats$trees[[locus]][n])
			}
			else{
				out Phy<-ape:::c.phylo(outPhy, read.tree(text=stats$trees[[locus]][n]))
				}
				}
				}

par(mfrow=c(1,1))
densityTree(outPhy)

model3<-coal_model(10, 50) +
feat_mutation(par_prior("theta", sample.int(100, 1))) +
sumstat_nucleotide_div()
stats<-simulate(model3, nsim=40)

mean_pi<-sapply(stats, function(x) mean(x$pi))
theta<-sapply(stats, function(x) x$pars[["theta"]])

par(mfrow=c(1,2))
plot(mean_pi)
axisPhylo()
plot(theta)

compare.graph(mean_pi,theta)