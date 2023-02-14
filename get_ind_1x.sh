#!/bin/sh
conda init bash
conda activate env_tools
REF_GENOME=/groups/dog/llenezet/test-datasets/data/ref_gen/ref_gen.chr38.fa
IND_LOC=/groups/dog/data/canFam3/NGS/Epilepsy/DNA/WGS/BAM/BERN-EPIL-2015_T_12559RE_CACO.bam
IND_NAME=./data/ind/12559
IND_S=${IND_NAME}.chr38.s
IND_S_1X=${IND_S}.1x
REGION=38:10000000-15000000

# Filter out the region of interest and format to BAM
samtools view -T ${REF_GENOME} -bo ${IND_S}.bam ${IND_LOC} ${REGION}
samtools index ${IND_S}.bam

# Get the genotype likelihood based on the panel for the validation file
PANEL_NAME=/groups/dog/llenezet/test-datasets/data/panel/DVDBC.chr38.s
VCF=${PANEL_NAME}.sites.vcf.gz
TSV=${PANEL_NAME}.sites.tsv.gz

bcftools mpileup -f ${REF_GENOME} -I -E -a 'FORMAT/DP' -T ${VCF} -r ${REGION} ${IND_S}.bam -Ou |
bcftools call -Aim -C alleles -T ${TSV} -Ob -o ${IND_S}.bcf
bcftools index -f ${IND_S}.bcf

# Downsampling the individual data to 1X
samtools coverage ${IND_S}.bam -r ${REF_GENOME} # mean = 21.903
samtools view -T ${REF_GENOME} -s 1.04545 -bo ${IND_S_1X}.bam ${IND_S}.bam ${REGION}
samtools index ${IND_S_1X}.bam