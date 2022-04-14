# Script for calculating fraction of reads in peaks using the deeptools API countReadsPerBin module


import deeptools.countReadsPerBin as crpb
#gets tmp files from the bash wrapper script
bam_file="tmpa"
bed_files="tmpb"
#calculates reads per bin and summarises data as a total value of reads per bin (peaks)
cr = crpb.CountReadsPerBin([bam_file],
                                        bedFile=bed_files,
                                        numberOfProcessors=10)
reads_at_peaks = cr.run()
total = reads_at_peaks.sum(axis=0)

import pysam
#extracts total number of reads from bam_file
bam1 = pysam.AlignmentFile(bam_file)
#calculates frip score based on reads in peaks over total reads
frip1 = float(total[0]) / bam1.mapped
#creates tmp file - renamed by the bash wrapper script
f = open("my_tmp_file.txt", "x")
#writes frip1 to tmp file
f.write(str(frip1))
