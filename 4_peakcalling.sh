#!/bin/sh

module load samtools
module load bedtools
module load python
for histName in $(ls *_GRCh38_bowtie2.filt_bowtie2.fragments.bed);
do


# scale bed files by scaling factor

name=$(basename $histName _GRCh38_bowtie2.filt_bowtie2.fragments.bed)
echo $name
seqDepthDouble=`samtools view -F 0x04 ../../BDGP6/${name}_BDGP6_bowtie2.filt.bam | wc -l`
seqDepth_B=$((seqDepthDouble/2))
echo $seqDepth_B



    scale_factor=`echo "4809036/$seqDepth_B" | bc -l`
    echo "Scaling factor for $name is: $scale_factor!"
bedtools genomecov -bg -scale $scale_factor -i ${name}_GRCh38_bowtie2.filt_bowtie2.fragments.bed -g hg38.chrom.sizes >${name}_bowtie2.fragments.normalized.bedgraph



done

module load R
module load bedtools
seacr=SEACR_1.3.sh

#call peaks using all settings in SEACR with and without IgG

for histName in $(ls *H3K27me3_bowtie2.fragments.normalized.bedGraph);
do
## Convert into bed file format
name=$(basename $histName _bowtie2.fragments.normalized.bedGraph)
echo $name
IFS='_'
read -ra ADDR <<< "${histName}"
ADDR[3]="IgG"
echo ${ADDR[0]}
echo ${ADDR[1]}
echo ${ADDR[2]}
echo ${ADDR[3]}
unset IFS
input="${ADDR[0]}_${ADDR[1]}_${ADDR[2]}_${ADDR[3]}"
echo $input


sh $seacr ${histName} ${input}_bowtie2.fragments.normalized.bedGraph non stringent ${name}_norm_stringent_control.peaks
sh $seacr ${histName} ${input}_bowtie2.fragments.normalized.bedGraph non relaxed ${name}_norm_relaxed_control.peaks

sh $seacr ${histName} 0.01 non stringent ${name}_norm_stringent_top001.peaks
sh $seacr ${histName} 0.01 non relaxed ${name}_norm_relaxed_top001.peaks



done

