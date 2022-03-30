module load bedtools
module load samtools

for histName in $(ls *.bam);
do
## Convert into bed file format
name=$(basename $histName .bam)
echo $name

samtools view -h -q 20 ${histName} > ${name}.filt.bam 

done


module load samtools
for hist in $(ls *.filt.bam);
do
name=$(basename $hist .bam)

samtools view -F 0x04 ${hist} | awk -F'\t' 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($9)}' | sort | uniq -c | awk -v OFS="\t" '{print $2, $1/2}' >${hist}_fragment_length.txt;

#convert filtered bam file to bed

bedtools bamtobed -i ${hist} -bedpe >${name}_bowtie2.bed

## Keep the read pairs that are on the same chromosome and fragment length less than 1000bp.
awk '$1==$4 && $6-$2 < 1000 {print $0}' ${name}_bowtie2.bed >${name}_bowtie2.clean.bed

## Only extract the fragment related columns
cut -f 1,2,6 ${name}_bowtie2.clean.bed | sort -k1,1 -k2,2n -k3,3n  >${name}_bowtie2.fragments.bed


## Extract fragment counts for QC
binLen=500
awk -v w=$binLen '{print $1, int(($2 + $3)/(2*w))*w + w/2}' ${name}_bowtie2.fragments.bed | sort -k1,1V -k2,2n | uniq -c | awk -v OFS="\t" '{print $2, $3, $1}' |  sort -k1,1V -k2,2n  >${name}_bowtie2.fragmentsCount.bin$binLen.bed

 done



mkdir BED
mv *.bed BED

#sort filtered bam file for downstream analysis

module load samtools

ls *.filt.bam > BAM.list

paste BAM.list | while read BAM;
do


name=$(basename ${BAM} .filt.bam)
echo $name


samtools sort ${name}.filt.bam -o ${name}.sorted.bam
samtools index ${name}.sorted.bam ${name}.sorted.bam.bai
done


mkdir sorted 
mv *sorted.ba* sorted












