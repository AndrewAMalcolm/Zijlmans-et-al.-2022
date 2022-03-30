BiocManager::install('TxDb.Hsapiens.UCSC.hg38.knownGene')
BiocManager::install(ChIPseeker)
library(ChIPseeker)

library(TxDb.Hsapiens.UCSC.hg38.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene


files <- list.files(pattern = '120122')
files <- files[-2]
test <- read.table('080122_random.bed')
names(files) <- c( "Naive", 'Primed', "Random")

library(org.Hs.eg.db)
library(EnsDb.Hsapiens.v75)
edb <- EnsDb.Hsapiens.v75
seqlevelsStyle(edb) <- "UCSC"


peakAnnoList <- lapply(files, annotatePeak, TxDb=txdb,  tssRegion = c(-3000, 3000), level = 'gene')
library(tidyverse)
peakAnnoList


plotAnnoBar(peakAnnoList)


