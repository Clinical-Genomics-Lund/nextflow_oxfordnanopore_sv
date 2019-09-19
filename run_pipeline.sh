module load nextflow
nextflow run pipeline.nf -with-singularity singularity/onte_2019-09-09.sif --fastq "/projects/fs1/petterst/onte/ERR2585112/*fastq.gz" -with-dag flowchart.png -with-timeline timeline.html -resume --output '/projects/fs1/petterst/onte/output/'

