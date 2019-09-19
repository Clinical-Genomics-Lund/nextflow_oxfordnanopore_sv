#!/usr/bin/env nextflow


datasets = Channel.fromPath(params.fastq, checkIfExists: true).map { file -> tuple(file.simpleName, file) }


process minimap_align {

    cpus 28

    publishDir "${params.outputfolder}/bam"

    input:
      set sampleID,file(fastq) from datasets
      
    output:
	set val(sampleID), file("${sampleID}.bam"),file("${sampleID}.bam.bai") into bam_sniffles, bam_npinv, bam_nanoplot, bam_mosdepth, bam_svim
    
    """
    minimap2 --MD -ax map-ont -t $task.cpus \
         -R \"@RG\\tID:$sampleID\\tSM:$sampleID\" \
         $params.inputgenome $fastq | \
    samtools sort -@ 2 -o ${sampleID}.bam - 2> ${sampleID}.minimap2.log
    sambamba index ${sampleID}.bam
    """
}


process svim_call {

    cpus 10


    publishDir "${params.outputfolder}/vcf"

    input:
        set sampleID,bam,bai from bam_svim

    output:
         file "${sampleID}.svim" into results_svim

    """
    svim alignment ${sampleID}.svim $bam $params.inputgenome
    """
}


process nanoplot_plot {

   cpus 3


   publishDir "${params.outputfolder}/qc"

   input:
        set sampleID, bam, bai from bam_nanoplot

   output:
       file "nanoplot/${sampleID}/" into results_nanoplot

   """
   NanoPlot --bam $bam -o nanoplot/$sampleID --N50 -t $task.cpus
   """
}



process mosdepth_plot {

   cpus 3

   publishDir "${params.outputfolder}/qc"

   input:
        set sampleID, bam, bai from bam_mosdepth

   output:
       file "${sampleID}.regions.bed.gz" into results_mosdepth

   """
   mosdepth -t $task.cpus -n --fast-mode --by 500 $sampleID $bam
   """

}



process sniffles_call {

    cpus 10

  
    publishDir "${params.outputfolder}/vcf"
	
    input:
        set sampleID, bam, bai from bam_sniffles

    output:
	file "${sampleID}.sniffles.vcf" into results_sniffles

    """
    sniffles -m $bam -v ${sampleID}.sniffles.vcf --threads $task.cpus
    """
}


/*
process npinv_call {

    cpus 1

   publishDir "${params.outputfolder}/qc"


    input:
        set sampleID,bam,bai from bam_npinv

    output:
	file "$sampleID.npinv.vcf" into results_npinv

    """
    npinv #--input $bam --output $sampleID.npinv.vcf
    """

}*/
