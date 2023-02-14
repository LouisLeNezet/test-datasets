#!/bin/sh
#Panel available
#/groups/dog/data/canFam3/variation/ostrander/722g.990.SNP.INDEL.chrAll.vcf.gz
#/groups/dog/data/canFam3/variation/NIH/435.PASS.INDEL.chr38.vcf.gz
#/groups/dog/data/canFam3/variation/dogs.648.vars.flt.ann.vcf.gz
#/groups/dog/data/canFam3/variation/dogs.813.vars.flt.ann.vcf.gz
PANEL_LOC=./data/panel/
PANEL_ORIGIN=/groups/dog/data/canFam3/variation/dogs.813.vars.flt.ann.vcf.gz
PANEL_NAME=${PANEL_LOC}DVDBC.chr38
PANEL_S=${PANEL_NAME}.s
REGION=38:10000000-15000000

# Filter the region of interest of the panel file
bcftools view ${PANEL_ORIGIN} -r ${REGION} -O z -o ${PANEL_S}.vcf.gz
bcftools index -f ${PANEL_S}.vcf.gz --threads 4

# Normalise the panel
bcftools norm -m -any ${PANEL_S}.vcf.gz -Ou --threads 4 |
bcftools view -m 2 -M 2 -v snps --threads 4 -Ob -o ${PANEL_S}.bcf
bcftools index -f ${PANEL_S}.bcf --threads 4

# Select only the SNPS
bcftools view -G -m 2 -M 2 -v snps ${PANEL_S}.bcf -Oz -o ${PANEL_S}.sites.vcf.gz
bcftools index -f ${PANEL_S}.sites.vcf.gz

# Convert to TSV
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\n' ${PANEL_S}.sites.vcf.gz | bgzip -c > ${PANEL_S}.sites.tsv.gz
tabix -s1 -b2 -e2 ${PANEL_S}.sites.tsv.gz

# Get the chromosome reference genome
awk -vRS=">" 'BEGIN{t["38"]=1}
                {if($1 in t){printf ">%s",$0}}' /groups/dog/data/canFam3/sequence/canfam3.2_ordered_Tosso_285.fa > ./data/ref_gen.chr38.fa