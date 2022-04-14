#Script to plot the Kernel Density estimate of naive and primed H3K27me3 libraries


#read in raw count data for 1kb bins
read.table('NaivevsPrimed_rawcounts.txt') -> bins

colnames(bins) <- c('Chromosome', 'Start', 'End', 'Naive_rep1','Naive_rep2', 'Primed_rep1','Primed_rep2')
library(tidyverse)
bins <- as_tibble(bins)

#sum counts for replicates
bins %>% 
  mutate(Naive = Naive_rep1 + Naive_rep2)%>%
  mutate(Primed = Primed_rep1 + Primed_rep2) -> bins
#Convert to long format
bins %>%
  pivot_longer(8:9, names_to ='Stage', values_to= 'Count') -> bins
#Remove bins with no counts
bins %>%
  filter(!is.na(Count))-> bins
#Log transform counts
bins %>%
  mutate(log2 = log2(Count)) -> bins


#Plot geom_density plots to compare distributions

p <- ggplot(bins, aes(x = log2,  fill=Stage)) + geom_density(stat = 'density', adjust = 2, alpha = 0.9) +scale_fill_manual(values = c('mediumorchid', 'palegreen4'))+ scale_x_continuous(limits =c (0, 10))
p
dev.off()


read.table('NaivevsPrimed_rawcounts.txt') -> bins

colnames(bins) <- c('Chromosome', 'Start', 'End', 'Naive_rep1','Naive_rep2', 'Primed_rep1','Primed_rep2')
library(tidyverse)
bins <- as_tibble(bins)
bins %>% 
  mutate(Naive = Naive_rep1 + Naive_rep2)%>%
  mutate(Primed = Primed_rep1 + Primed_rep2) -> bins

bins %>%
  pivot_longer(8:9, names_to ='Stage', values_to= 'Count') -> bins

bins %>%
  filter(!is.na(Count))-> bins

bins %>%
  mutate(log2 = log2(Count)) -> bins





#svg('240821_KDE_NaivevsPrimedd.svg')


p <- ggplot(bins, aes(x = log2,  fill=Stage)) + geom_density(stat = 'density', adjust = 2, alpha = 0.9) +scale_fill_manual(values = c('mediumorchid', 'palegreen4'))+ scale_x_continuous(limits =c (0, 10))
p
dev.off()


read.table('NaivevsPrimed_rawcounts.txt') -> bins

colnames(bins) <- c('Chromosome', 'Start', 'End', 'Naive_rep1','Naive_rep2', 'Primed_rep1','Primed_rep2')
library(tidyverse)
bins <- as_tibble(bins)
bins %>% 
  mutate(Naive = Naive_rep1 + Naive_rep2)%>%
  mutate(Primed = Primed_rep1 + Primed_rep2) -> bins

bins %>%
  pivot_longer(8:9, names_to ='Stage', values_to= 'Count') -> bins

bins %>%
  filter(!is.na(Count))-> bins

bins %>%
  mutate(log2 = log2(Count)) -> bins






p <- ggplot(bins, aes(x = log2,  fill=Stage)) + geom_density(stat = 'density', adjust = 2, alpha = 0.9) +scale_fill_manual(values = c('mediumorchid', 'palegreen4'))+ scale_x_continuous(limits =c (0, 10))
p
dev.off()


read.table('NaivevsPrimed_rawcounts.txt') -> bins

colnames(bins) <- c('Chromosome', 'Start', 'End', 'Naive_rep1','Naive_rep2', 'Primed_rep1','Primed_rep2')
library(tidyverse)
bins <- as_tibble(bins)
bins %>% 
  mutate(Naive = Naive_rep1 + Naive_rep2)%>%
  mutate(Primed = Primed_rep1 + Primed_rep2) -> bins

bins %>%
  pivot_longer(8:9, names_to ='Stage', values_to= 'Count') -> bins

bins %>%
  filter(!is.na(Count))-> bins

bins %>%
  mutate(log2 = log2(Count)) -> bins







p <- ggplot(bins, aes(x = log2,  fill=Stage)) + geom_density(stat = 'density', adjust = 2, alpha = 0.9) +scale_fill_manual(values = c('mediumorchid', 'palegreen4'))+ scale_x_continuous(limits =c (0, 10))
p
dev.off()





