/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { SAMTOOLS_STATS as SAMTOOLS_STATS } from '../modules/SAMTOOLS_STATS.nf'
include { STAR as STAR } from '../modules/STAR.nf'
include { SAMTOOLS_EXTRACT_UNMAPPED as SAMTOOLS_EXTRACT_UNMAPPED } from '../modules/SAMTOOLS_EXTRACT_UNMAPPED.nf'
include { FASTQC as FASTQC_HOST_DEP } from '../modules/FASTQC.nf'



workflow HOST_REMOVAL_SHORT_READ {
    take:
        ch_fastqs_trim                // channel: [val(sample), [fastq_1, fastq_2]]
        ch_hostgen                  // channel: [val(sample), fasta]
    main:

        ch_for_star= ch_fastqs_trim.join(ch_hostgen)

        STAR(ch_for_star)
        SAMTOOLS_STATS(STAR.out.sam)
        SAMTOOLS_EXTRACT_UNMAPPED(STAR.out.sam)
        FASTQC_HOST_DEP(SAMTOOLS_EXTRACT_UNMAPPED.out.non_host_reads)

    emit:
        host_removed_reads    =  SAMTOOLS_EXTRACT_UNMAPPED.out.non_host_reads  //   channel: [ val(sample), fastq_1, fastq_2]

}