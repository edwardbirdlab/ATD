#!/usr/bin/env nextflow

nextflow.enable.dsl=2


if (params.workflow_opt == 'shortread') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.r1), file(row.r2)) }

    ch_hostgen = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.refernce_genome)) }

    }

include { ATD as ATD } from './workflows/ATD.nf'
include { SR_MULTIQC as SR_MULTIQC } from './workflows/SR_MULTIQC.nf'


workflow {


    if (params.workflow_opt == 'shortread_') {

        ATD(ch_fastq, ch_hostgen)

        }

    if (params.workflow_opt == 'sr_multiqc') {

        SR_MULTIQC()

        }

}