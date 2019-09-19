module load nextflow
nextflow run pipeline.nf -with-singularity singularity/onte_2019-09-09.sif --fastq "fastq/*fastq.gz" -with-dag flowchart.png -with-timeline timeline.html -resume --output './output/' --reference './reference' --executor 'local'

