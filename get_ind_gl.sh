#!/bin/sh
#Variables
REF_GENOME=/groups/dog/llenezet/test-datasets/data/ref_gen/ref_gen.chr38.fa
IND_LOC=./data/ind/
IND_S_1X=${IND_LOC}12559.chr38.s.1x
REGION=38:10000000-15000000

PANEL_NAME=/groups/dog/llenezet/test-datasets/data/panel/DVDBC.chr38.s
VCF=${PANEL_NAME}.sites.vcf.gz
TSV=${PANEL_NAME}.sites.tsv.gz

# Compute genotype likelihood based on the panel
bcftools mpileup -f ${REF_GENOME} -I -E -a 'FORMAT/DP' -T ${VCF} -r ${REGION} ${IND_S_1X}.bam -Ou |
bcftools call -Aim -C alleles -T ${TSV} -Oz -o ${IND_S_1X}.vcf.gz
bcftools index -f ${IND_S_1X}.vcf.gz