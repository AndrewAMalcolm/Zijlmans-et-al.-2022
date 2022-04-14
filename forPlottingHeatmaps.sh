#calculate and plot profiles from peak centred windows with 25kb genomic context
#code adapted from Jan Oppelt (https://janbio.home.blog/2021/03/19/speed-up-deeptools-computematrix/)

module load python
positions=5000
threads=12

rnd=$RANDOM

split -l $positions 080122_DESEQ2_naive_peaks_filtered.bed ref.chunks${rnd}

for chunk in ref.chunks${rnd}*; do
  # Rename name column (4) in bed to avoid potential problems which deepTools naming which might happen if the reference position name are not unique
  name=$(basename $chunk)
  name=${name##*.}

  cat $chunk | awk -v name=$name 'BEGIN {FS = "\t"; OFS = "\t"} {print $1,$2,$3,name,$5,$6}' > tmp.$rnd && mv tmp.$rnd $chunk
done

# calculate matrix for each chunk
for chunk in ref.chunks${rnd}*; do
computeMatrix reference-point --referencePoint center -R ${chunk} -S Naive_noUNC_H3K27me3.bw Naive_UNC_H3K27me3.bw Primed_noUNC_H3K27me3.bw Primed_UNC_H3K27me3.bw Naive_noUNC_IgG.bw Naive_UNC_IgG.bw Primed_noUNC_IgG.bw Primed_UNC_IgG.bw  -o ${chunk}.gz -b 25000 -a 25000 --sortUsingSamples 1 --missingDataAsZero -p max --verbose





done

# merge the chunks back to one file
computeMatrixOperations rbind -m ref.chunks${rnd}*.gz -o 080122_Naive_enriched-DESEQ2.matrix_25kb.gz && rm ref.chunks${rnd}*.gz


threads=12

rnd=$RANDOM

split -l $positions 080122_DESEQ2_primed_peaks_filtered.bed ref.chunks${rnd}

for chunk in ref.chunks${rnd}*; do
  # Rename name column (4) in bed to avoid potential problems which deepTools naming which might happen if the reference position name are not unique
  name=$(basename $chunk)
  name=${name##*.}

  cat $chunk | awk -v name=$name 'BEGIN {FS = "\t"; OFS = "\t"} {print $1,$2,$3,name,$5,$6}' > tmp.$rnd && mv tmp.$rnd $chunk
done

# calculate matrix for each chunk
for chunk in ref.chunks${rnd}*; do
computeMatrix reference-point --referencePoint center -R ${chunk} -S Naive_noUNC_H3K27me3.bw Naive_UNC_H3K27me3.bw Primed_noUNC_H3K27me3.bw Primed_UNC_H3K27me3.bw Naive_noUNC_IgG.bw Naive_UNC_IgG.bw Primed_noUNC_IgG.bw Primed_UNC_IgG.bw -o ${chunk}.gz -b 25000 -a 25000 --sortUsingSamples 1 --missingDataAsZero -p max --verbose
done

# merge the chunks back to one file
computeMatrixOperations rbind -m ref.chunks${rnd}*.gz -o 080122_Primed_enriched_DESEQ2_25kb.matrix.gz && rm ref.chunks${rnd}*.gz

split -l $positions 080122_DESEQ2_common_peaks_filtered.bed ref.chunks${rnd}

for chunk in ref.chunks${rnd}*; do
  # Rename name column (4) in bed to avoid potential problems which deepTools naming which might happen if the reference position name are not unique
  name=$(basename $chunk)
  name=${name##*.}

  cat $chunk | awk -v name=$name 'BEGIN {FS = "\t"; OFS = "\t"} {print $1,$2,$3,name,$5,$6}' > tmp.$rnd && mv tmp.$rnd $chunk
done

# calculate matrix for each chunk
for chunk in ref.chunks${rnd}*; do
computeMatrix reference-point --referencePoint center -R ${chunk} -S Naive_noUNC_H3K27me3.bw Naive_UNC_H3K27me3.bw Primed_noUNC_H3K27me3.bw Primed_UNC_H3K27me3.bw Naive_noUNC_IgG.bw Naive_UNC_IgG.bw Primed_noUNC_IgG.bw Primed_UNC_IgG.bw  -o ${chunk}.gz -b 25000 -a 25000 --sortUsingSamples 1 --missingDataAsZero -p max --verbose

done

# merge the chunks back to one file
computeMatrixOperations rbind -m ref.chunks${rnd}*.gz -o 080122_common_DESEQ2.matrix_25kb.gz && rm ref.chunks${rnd}*.gz


#plot profiles 
plotProfile -m 080122_Naive_enriched-DESEQ2.matrix_25kb.gz -o 080122_Naive_enriched-DESEQ2.matrix_25kb.pdf --yMin 0 --yMax 20 --perGroup
plotProfile -m 080122_Primed_enriched-DESEQ2.matrix_25kb.gz -o 080122_Primed_enriched-DESEQ2.matrix_25kb.pdf --yMin 0 --yMax 20 --perGroup
plotProfile -m 080122_common_DESEQ2.matrix_25kb.gz -o 080122_common_DESEQ2.matrix_25kb.pdf --yMin 0 --yMax 20 --perGroup



