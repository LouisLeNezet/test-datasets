# 5k A549, Lung Carcinoma Cells, No Treatment Transduced with a CRISPR Pool

This dataset was obtained from [10x Genomics](https://www.10xgenomics.com/datasets/5-k-a-549-lung-carcinoma-cells-no-treatment-transduced-with-a-crispr-pool-3-1-standard-6-0-0) and modifiedas described below. The dataset description and download instructions are reproduced from the 10x Genomics website.

## Dataset overview

A549 lung carcinoma cells that expressed dCas9-KRAB were transduced with a pool containing 93 total sgRNAs (90 sgRNAs targeting 45 different genes and 3 non-targeting control sgRNAs, all using Capture Sequence 2 inserted into the hairpin structure of the sgRNA). Cells were obtained by 10x Genomics from MilliporeSigma. Selected cells (cultured in a selection media) for each condition were individually frozen. Aliquots of cells were then thawed and counted. The same cells were used as part of the multiplexed sample.

Libraries were prepared following the Chromium Single Cell 3' Reagent Kits User Guide (v3.1 Chemistry Dual Index) with Feature Barcoding technology for CRISPR Screening User Guide (CG000316) and sequenced on Illumina NovaSeq 6000.

### Single Cell 3’ CRISPR Screening v3.1 Dual Index Library

- Sequencing Depth: 21,401 read pairs per cell
- Paired-end, dual indexing Read 1: 28 cycles (16 bp barcode, 12 bp UMI); i5 index: 10 cycles (sample index); i7 index: 10 cycles (sample index); Read 2: 90 cycles (transcript)

### Key Metrics

- Estimated Number of Cells: 5,867
- Median Genes per Cell: 3,194
- Median UMI Counts per Cell: 10,773

## Original input files download

Original input files were downloaded using:

```bash
# Input Files
curl -O https://s3-us-west-2.amazonaws.com/10x.files/samples/cell-exp/6.0.0/SC3_v3_NextGem_DI_CRISPR_A549_5K_Multiplex/SC3_v3_NextGem_DI_CRISPR_A549_5K_Multiplex_fastqs.tar
curl -O https://cf.10xgenomics.com/samples/cell-exp/6.0.0/SC3_v3_NextGem_DI_CRISPR_A549_5K_Multiplex/SC3_v3_NextGem_DI_CRISPR_A549_5K_Multiplex_config.csv
curl -O https://cf.10xgenomics.com/samples/cell-exp/6.0.0/SC3_v3_NextGem_DI_CRISPR_A549_5K_Multiplex/SC3_v3_NextGem_DI_CRISPR_A549_5K_Multiplex_count_feature_reference.csv
```

## Changes to original input files

For both gene expression and CRISPR FASTQ files, only lanes 1 and 2 files were kept, and the first 10,000 reads were subsampled.

In the count_feature_reference.csv file, the older gene symbol H2AFY was replaced by the newer gene symbol MACROH2A1 designating the same gene for compatibility with newer genome references.