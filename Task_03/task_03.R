library(paleobioDB)
#Extension
Taxon<-"Strigiformes"
MaxMA<-10
Min<-0
fossils<-pbdb_occurrences(base_name=Taxon, show=c("phylo", "coords", "ident"))
Res<-5
nspeciesOverTime<-pbdb_richness(fossils, rank="genus", temporal_extent=c(MaxMA,MinMA), res=Res)
par(mar=c(4,5,2,1), las=1, tck=-0.01, mgp=c(2.5, 0.5, 0))
plot(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime)), nspeciesOverTime[,2], xlim=c(MaxMA,MinMA), type="l", xlab="age(millions of years ago)", ylab="num. of species", main=Taxon)


Taxon 2

Taxon2<-"Cetacea"
MaxMA<-10
MinMA<-0
fossils2<-pbdb_occurrences(base_name=Taxon2, show=c("phylo", "coords", "ident"))
nspeciesOverTime2<-pbdb_richness(fossils2, rank="genus", temporal_extent=c(MaxMA,MinMA), res=Res)



par(mar=c(4,5,2,1), las=1, tck=-0.01, mgp=c(2.5, 0.5, 0))
LineWidth<-2
plot(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime)), nspeciesOverTime[,2], xlim=c(MaxMA, MinMA), type="l", xlab="age(millions of years ago)", ylab="num. of species", main=Taxon)
lines(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime2)), nspeciesOverTime2[,2], lwd=LineWidth)
legend("topleft", legend=c(Taxon, Taxon2), bty="n", lwd=LineWidth)


install.packages ("rfishbase")