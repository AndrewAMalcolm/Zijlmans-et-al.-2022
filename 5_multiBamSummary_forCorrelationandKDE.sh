module load python
#Calculate  normalised read counts across 1kb bins of the genome for different comparisons
multiBamSummary bins -bs 1000 -b Rep4_Naive_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep5_Naive_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep4_Primed_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep5_Primed_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam -o NaivevsPrimed_1kb_bins.npz --outRawCounts NaivevsPrimed_rawcounts.txt --scalingFactors 230821_NaivevsPrimed.txt -p 8 
multiBamSummary bins -bs 1000 -b Rep4_Naive_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep4_Naive_UNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep5_Naive_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep5_Naive_UNC_H3K27me3_GRCh38_bowtie2.sorted.bam -o NaivevsUNC_1kb_bins.npz --outRawCounts NaivevsUNC_rawcounts.txt --scalingFactors 230821_NaivsvsUNC.txt -p 8
multiBamSummary bins -bs 1000 -b Rep4_Primed_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep4_Primed_UNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep5_Primed_noUNC_H3K27me3_GRCh38_bowtie2.sorted.bam Rep5_Primed_UNC_H3K27me3_GRCh38_bowtie2.sorted.bam -o PrimedvsUNC_1kb_bins.npz --outRawCounts PrimedvsUNC_rawcounts.txt --scalingFactors 230821_PrimedvsUNC.txt -p 8

#Plot pearson correlation of samples within comparisons

plotCorrelation --corData NaivevsPrimed_1kb_bins.npz -c pearson -p scatterplot -l Rep4_Naive_noUNC Rep5_Naive_noUNC Rep4_Primed_noUNC Rep5_Primed_noUNC --plotFileFormat svg -o NaivevsPrimed_scatterplot.svg
plotCorrelation --corData NaivevsUNC_1kb_bins.npz -c pearson -p scatterplot -l Rep4_Naive_noUNC Rep4_Naive_UNC Rep5_Naive_noUNC Rep5_Naive_UNC --plotFileFormat svg -o NaivevsUNC.svg
plotCorrelation --corData PrimedvsUNC_1kb_bins.npz -c pearson -p scatterplot -l Rep4_Primed_noUNC Rep4_Primed_UNC Rep5_Primed_noUNC Rep5_Primed_UNC --plotFileFormat svg -o PrimedvsUNC.svg
