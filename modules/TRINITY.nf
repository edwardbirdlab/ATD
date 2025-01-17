process TRINITY {
    label 'midmen'
	container 'trinityrnaseq/trinityrnaseq'

    input:
        tuple val(sample), file(concat_norm_1_fq), file(concat_norm_2_fq)
    output:
	    tuple val(sample), path("trinity_${sample}/Trinity.fasta"), emit: assembly


    script:

    """
    mkdir trinity_${sample}
    Trinity --seqType fq --max_memory ${task.memory.toGiga()}G --left ${concat_norm_1_fq}  --right ${concat_norm_2_fq} --CPU ${task.cpus} --output ./trinity_${sample}
    """
}
