# nextflow_oxfordnanopore_sv
Nextflow pipeline for detection of structural variants from Oxford Nanopore data



FILER
- nextflow.config anger var referensgenom finns samt output och lite övrig konfig
- pipeline.nf     recept för pipelinen med exakta kommandon för varje steg
- run_pipeline.sh startar pipelinen
- flowchart.png   flödesschema över pipelinen (genereras varje gång den körs)
- timeline.html   tidslinje (genereras varje gång den körs)

MAPPAR
- output          här hamnar resultaten
- reference       referensfiler
- singularity     innehåller container med mjuvkaran
- testfastq       mapp med testfastq
- work            här hamnar resultat/tmpfiler mm under körning
