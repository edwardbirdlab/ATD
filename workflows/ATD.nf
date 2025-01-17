/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_SR as READ_QC_SR } from '../subworkflows/READ_QC_SR.nf'
include { HOST_REMOVAL_SHORT_READ as HOST_REMOVAL_SHORT_READ } from '../subworkflows/HOST_REMOVAL_SHORT_READ.nf'
include { ASSEMBLY as ASSEMBLY } from '../subworkflows/ASSEMBLY.nf'
include { METAGENOMIC_SEQUENCE_IDENTIFICATION as METAGENOMIC_SEQUENCE_IDENTIFICATION } from '../subworkflows/METAGENOMIC_SEQUENCE_IDENTIFICATION.nf'


workflow ATD {
    take:
        fastqs_short_raw      //    channel: [val(sample), [fastq_1, fastq_2]]
        host_gen_fasta        //    channel: channel: [val(sample), fasta]

    main:
        READ_QC_SR(fastqs_short_raw)

        HOST_REMOVAL_SHORT_READ(READ_QC_SR.out.trimmed_fastq, host_gen_fasta)

        ASSEMBLY(HOST_REMOVAL_SHORT_READ.out.host_removed_reads)

        METAGENOMIC_SEQUENCE_IDENTIFICATION(ASSEMBLY.out.assembly)

}