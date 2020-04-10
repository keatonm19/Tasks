install.packages("dplyr")

library(tidyjson)
library(dplyr)
dogAttributes <- "https://raw.githubusercontent.com/ericdrowell/DogBreedChart/master/dogs.json" %>% as.tbl_json()
dogAttributesTbl <- 
  dogAttributes %>%   
  gather_object() %>%  
  gather_array() %>% 
  spread_values(           
    id = jstring("id"),
    breedname = jstring("name"),
    size = jnumber("size"),
    kidFriendly = jnumber("kidFriendly"),
    dogFriendly = jnumber("dogFriendly"),
    shedding = jnumber("lowShedding"),
    grooming_ease = jnumber("easyToGroom"),
    energy = jnumber("highEnergy"),
    health = jnumber("goodHealth"),
    low_barking = jnumber("lowBarking"),
    smart = jnumber("intelligence"),
    trainable = jnumber("easyToTrain"),
    heat_tolerance = jnumber("toleratesHot"),
    cold_tolerance = jnumber("toleratesCold")
  ) %>%
  select(-document.id,-key,-array.index,-id) 
dogAttributesTblF <- read.csv("https://raw.githubusercontent.com/luisDVA/codeluis/master/dogTraits.csv",stringsAsFactors = F)
breedsTable <- read.csv("https://raw.githubusercontent.com/luisDVA/codeluis/master/dogTable.csv",stringsAsFactors = FALSE, na.strings = "") %>%
  select(breedname=Breed,Abrev.,Clade)

install.packages("fuzzyjoin")
library(fuzzyjoin)
  
length(which(is.na(joinedTabs$breedname.y)==FALSE))
joinedTabs <- stringdist_left_join(breedsTable,dogAttributesTblF,max_dist=2)

dogsAttrFilt <- joinedTabs %>% filter(!is.na(breedname.y))


install.packages("purrr")
library(ape)
library(dplyr)
library(purrr)

Breedtree <- read.nexus("https://raw.githubusercontent.com/luisDVA/codeluis/master/dogtree.txt")
tipsbreeds<-Breedtree$tip.label
tipsbreeds
splitbreed<- strsplit(tipsbreeds,"_") %>% map_chr(pluck(1)) %>% unique()
splitbreed
ii<-splitbreed %>% set_names() %>%  map(~grep(.x,tipsbreeds)) %>% map_int(pluck(1))

BreedtreeTrimmed<-drop.tip(Breedtree,setdiff(Breedtree$tip.label,tipsbreeds[ii]))
BreedtreeTrimmed$tip.label<- strsplit(BreedtreeTrimmed$tip.label,"_") %>% map_chr(pluck(1))
plot(BreedtreeTrimmed)

install.packages("geiger")
library(geiger)
row.names(dogsAttrFilt) <- dogsAttrFilt$Abrev.
BreedTreeF <- treedata(phy=BreedtreeTrimmed,data = dogsAttrFilt, sort = TRUE)$phy
dogTraitsF <- treedata(phy=BreedtreeTrimmed,data = dogsAttrFilt, sort = TRUE)$data
dogTraitsF <- data.frame(dogTraitsF)
dogTraitsFnum <- dogTraitsF %>% mutate_at(5:16,funs(as.numeric))
dogTraitsFnum$tiplabs <- gsub(" ","_",dogTraitsFnum$breedname.y)
BreedTreeF$tip.label <- dogTraitsFnum$tiplabs

install.packages("BiocManager")
BiocManager::install("ggtree")
library(ggtree)
ggtree(BreedTreeF,layout="fan")+geom_tiplab2(size=2.5, align=TRUE, linesize=.5)+ggplot2::xlim(0, 4000)
ggtree(BreedTreeF,layout = "fan")

setwd("~/Desktop/Evolution/Tasks/my project hypothesis")

dogClades <- dogTraitsFnum %>% dplyr::filter(Clade=="Retriever" | Clade=="Spitz" | Clade=="German Shepherd*"| Clade=="Dalmation) %>%
dplyr::select(tiplabs,everything())
tokeep <- dogClades$tiplabs1
dogCladesTree<-drop.tip(BreedTreeF,BreedTreeF$tip.label[-match(tokeep, BreedTreeF$tip.label)])
dogCladesC <- dogClades %>% mutate(cutest=case_when(.$tiplabs=="Labrador_Retriever"~"yes",
                                                    .$tiplabs=="German_Shepherd_Dog"~"yes",
                                                    . 
                                                    
setwd("~/Desktop/Evolution/Tasks/my project hypothesis")


