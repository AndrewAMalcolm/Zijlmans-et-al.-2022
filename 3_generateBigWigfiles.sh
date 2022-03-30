module load samtools
module load bedtools
module load python



for histName in $(ls *.sorted.bam);
do

name=$(basename $histName _GRCh38_bowtie2.sorted.bam)

echo $name 
#calculate scaling factor
seqDepthDouble=`samtools view -F 0x04 ../BDGP6/${name}_BDGP6_bowtie2.filt.bam | wc -l`
seqDepth_B=$((seqDepthDouble/2))
echo $seqDepth_B

    scale_factor=`echo "4809036/$seqDepth_B" | bc -l`
    echo "Scaling factor for $name is: $scale_factor!"

#produce bigwig file scaling by scaling factor
bamCoverage -b ${name}_GRCh38_bowtie2.sorted.bam -o ${name}.normalized.bw  -p 8 --scaleFactor ${scale_factor} --ignoreForNormalization ChrM ChrY



done
