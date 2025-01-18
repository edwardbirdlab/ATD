/*
Subworkflow for assembly QC using Kraken2, minimap2, and blobtools2
Requries set params:


*/

include { KRAKEN2_PLUSPF_FA as KRAKEN2_PLUSPF_FA } from '../modules/KRAKEN2_PLUSPF_FA.nf'
include { KRAKEN2_DB_PLUSPF as KRAKEN2_DB_PLUSPF } from '../modules/KRAKEN2_DB_PLUSPF.nf'


workflow METAGENOMIC_SEQUENCE_IDENTIFICATION {
    take:
        
        fasta //    channel: [ val(sample), fasta]


    main:

        KRAKEN2_DB_PLUSPF()

        KRAKEN2_PLUSPF_FA(fasta, KRAKEN2_DB_PLUSPF.out.kraken2_DB)
}