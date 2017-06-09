# Palmetto-GEM
This workflow contains PBS job wrappers, pre-configured software packages, and bash scripts that automate the submission of jobs that perform the following tasks:

* Download RNA sequencing data in FASTQ format using the [SRA Toolkit](https://www.ncbi.nlm.nih.gov/books/NBK158900/)
* Trim raw fastq files of poor quality reads and Illumina adapter sequences using [Trimmomatic](http://www.usadellab.or/cms/?page=trimmomatic)
* Map cleaned reads to a reference genome using  [Hisat2](https://ccb.jhu.edu/software/hisat2/manual.shtml)
* Quantify RNA transcript abundances using [StringTie](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
* Parse FPKM values from StringTie output into a Gene Expression Matrix (GEM)

This workflow utilizes Genome annotation files in GFF3 format to quantify transcript abudances as described in the following Nature Protocol:

Pertea, M., et al. (2016). "Transcript-level expression analysis of RNA-seq experiments with HISAT, StringTie and Ballgown." Nat. Protocols 11(9): 1650-1667.

## Pre-Workflow User Input

### Index the Reference Genome

### Identify SRA sample ID's and modify SRAList.txt file

To execute workflow using the test files:

./initiate

./01-Prepare-inputs.sh

./02-Trim-reads.sh

./03-Map-reads.sh chr21-GRCh38

./04-Count-transcripts.sh

./05-GEM-parse.sh

