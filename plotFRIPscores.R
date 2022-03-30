

library('tidyverse')

sampleList <- as_tibble(sampleList)
  
sampleList %>% 
  filter(grepl('H3K27me3', value)) -> tmpList

fripResult <- c()

for(hist in tmpList){
  fripRes = read_table(paste0(projPath,  '/human/', hist, "_frip.stats.txt"))
  histInfo = strsplit(hist, "_")[[1]]
  fripResult = data.frame(Histone = histInfo[4], Replicate = histInfo[1], Line = histInfo[2], Treatment = histInfo[3],  FractionReadsinPeaks = fripRes[1,1] %>% as.character %>% as.numeric)  %>% rbind(fripResult, .)
}


tmpList$FRIP <- c(0.1555, 0.066, 0.353, 0.07, 0.11, 0.061, 0.345, 0.08 )
tmpList$value <- factor(tmpList$value,  levels = c('Rep4_Naive_noUNC_H3K27me3', 'Rep5_Naive_noUNC_H3K27me3', 'Rep4_Primed_noUNC_H3K27me3', 'Rep5_Primed_noUNC_H3K27me3', 'Rep4_Naive_UNC_H3K27me3', 'Rep5_Naive_UNC_H3K27me3','Rep4_Primed_UNC_H3K27me3', 'Rep5_Primed_UNC_H3K27me3'))

pdf('FRIP_stats_231121.pdf')
tmpList %>%
  ggplot(aes(x=value, y=FRIP)) + geom_col(width = 0.5, position = position_dodge(width =0.5)) 
                        dev.off()
                                          
