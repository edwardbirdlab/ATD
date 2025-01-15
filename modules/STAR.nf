process STAR {
    label 'midmem'
    container 'mgibio/star'

    input:
        tuple val(sample), file(fq1), file(fq2), file(ref)
    output:
        tuple val(sample), path("${sample}_host_removal.sam"), emit: sam

    script:

    """
    mkdir ${sample}_index
    STAR --runThreadN ${task.cpus} --runMode genomeGenerate --genomeDir ${sample}_index --genomeFastaFiles ${ref} --sjdbOverhang ${params.read_len}
    STAR --runThreadN ${task.cpus} --genomeDir ${sample}_index --readFilesIn ${fq1} ${fq2}
    """
}