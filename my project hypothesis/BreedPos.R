
setwd("~/Desktop/Evolution/Tasks/my project hypothesis")
library(tidyverse)

~/Desktop/Evolution/Tasks/my project hypothesis/ProjectHypothesis.csv
df <- read_csv("~/Desktop/Evolution/Tasks/my project hypothesis/ProjectHypothesis.csv")

head(df)

df %>% 
  count(Breed,sort=T) %>% na.omit( ) %>%
  mutate(Breed=fct_reorder(Breed,n)) %>% 
  ggplot(aes(Breed,n,fill=Breed))+
  geom_col(show.legend = F)+
  coord_flip()+
  theme_light()+
  labs(title="Breed most likely to be positve", y="Count")