
# extract sequencing depth for normalisation
module load samtools
module load bedtools
module load python
for histName in $(ls *_bowtie2.rmDup.bam);
do
## Convert into bed file format
name=$(basename $histName _BDGP6_bowtie2.filt.rmDup.bam)
echo $name

seqDepthDouble=`samtools view -F 0x04 ../BDGP6/${name}_BDGP6_bowtie2.filt.bam | wc -l`
seqDepth=$((seqDepthDouble/2))
echo $seqDepth >${name}_BDGP6_bowtie2.seqDepth

done
