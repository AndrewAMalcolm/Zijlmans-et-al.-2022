#Bash shell for iteratively running the python script frip_script.py


FRIP=frip_script.py

for histName in $(ls *H3K27me3_GRCh38_bowtie2.sorted.bam);
do
name=$(basename ${histName} _GRCh38_bowtie2.sorted.bam)
echo $name

cp ${histName} tmpa
cp BED/peaks/stringent_top001/${name}_norm_stringent_top001.peaks.bed tmpb 
cp ${histName}.bai tmpa.bai
python frip_script.py

mv my_tmp_file.txt ${name}_frip.stats.txt

done


