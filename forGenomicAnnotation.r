#RScript for annotating peaks with genomic context using the ChIPSeeker package (Yu et al., 2015)

BiocManager::install('TxDb.Hsapiens.UCSC.hg38.knownGene')
BiocManager::install(ChIPseeker)
library(ChIPseeker)

library(TxDb.Hsapiens.UCSC.hg38.knownGene)


#load library
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

#read in filenames for peak bed files
files <- list.files(pattern = '120122')
files <- files[-2]
test <- read.table('080122_random.bed')
names(files) <- c( "Naive", 'Primed', "Random")


#annotate each peak for each file with genomic context 

peakAnnoList <- lapply(files, annotatePeak, TxDb=txdb,  tssRegion = c(-3000, 3000), level = 'gene')
library(tidyverse)
peakAnnoList

#plot stacked bar chart 
plotAnnoBar(peakAnnoList)


