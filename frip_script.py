import deeptools.countReadsPerBin as crpb

bam_file="tmpa"
bed_files="tmpb"

cr = crpb.CountReadsPerBin([bam_file],
                                        bedFile=bed_files,
                                        numberOfProcessors=10)
reads_at_peaks = cr.run()

total = reads_at_peaks.sum(axis=0)
import pysam
bam1 = pysam.AlignmentFile(bam_file)
frip1 = float(total[0]) / bam1.mapped

f = open("my_tmp_file.txt", "x")

f.write(str(frip1))
