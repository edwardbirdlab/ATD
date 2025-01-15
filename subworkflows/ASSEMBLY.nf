/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { TRINITY as TRINITY } from '../modules/TRINITY.nf'



workflow ASSEMBLY {
    take:
        fastqs                                          // channel: [val(sample), [fastq_1, fastq_2]]
    main:


        TRINITY(fastqs)

    emit:
        assembly    =  TRINITY.out.assembly  //   channel: [ val(sample), fastq_1, fastq_2]

}