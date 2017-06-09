# PBS-GEM
This workflow contains PBS job wrappers, pre-configured software packages(all open source), and bash scripts that automate the submission of PBS jobs that perform the following tasks:

* Download RNA sequencing data in FASTQ format using the [SRA Toolkit](https://www.ncbi.nlm.nih.gov/books/NBK158900/)
* Trim raw fastq files of poor quality reads and Illumina adapter sequences using [Trimmomatic](http://www.usadellab.or/cms/?page=trimmomatic)
* Map cleaned reads to a reference genome using  [Hisat2](https://ccb.jhu.edu/software/hisat2/manual.shtml)
* Quantify RNA transcript abundances using [StringTie](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
* Parse FPKM values from StringTie output into a Gene Expression Matrix (GEM)

This workflow utilizes Genome annotation files in GFF3 format to quantify transcript abudances as described in the following Nature Protocol:

Pertea, M., et al. (2016). "Transcript-level expression analysis of RNA-seq experiments with HISAT, StringTie and Ballgown." Nat. Protocols 11(9): 1650-1667.

## Pre-Workflow User Input

### Decompress software
This workflow contains pre-configured software packages.  To decompress them for use, execute the _initiate_ script:

    $ ./initiate
  
This will submit a PBS job that decompresses the SRA toolkit, Trimmomatic, Hisat2, and StringTie packages for use 

### Index the Reference Genome

The reference genome must be indexed using Hisat2.  Download a reference genome in FASTA (.fa) format.  To index this reference genome, create and submit a PBS script from the _Reference_ directory as follows ($REF_PREFIX must be replaced with the prefix of the reference genome index files that you want):

#!/bin/bash
#PBS -N hisat_index
#PBS -l select=1:ncpus=1:mem=14gb,walltime=72:00:00
#PBS -j oe

cd ${PBS_O_WORKDIR}

../Software/hisat2-2.0.5/hisat2-build -f *.fa $REF_PREFIX

### Download GFF3 Genome Annotation

A GFF3 file that corresponds to the reference genome must be placed in the _Reference_ directory


### Identify SRA sample ID's and modify SRAList.txt file

SRA sample ID's must be specified in the "SRAList.txt" file.  Please modify this file to specify the samples that you want to process.  Each SRA ID must be present on a new line.  

## Execute the Workflow

The workflow contains a small reference genome for testing.  To run the workflow, execute each step of the pipeline as follows:  

### Download Input Data

    $ ./01-Prepare-inputs.sh
  
### Trim Reads

    $ ./02-Trim-reads.sh

### Map Reads to Reference Genome 

    $ ./03-Map-reads.sh chr21-GRCh38

### Quantify Transcript Abundances

    $ ./04-Count-transcripts.sh

### Build Gene Expression Matrix (GEM)

    $ ./05-GEM-parse.sh
    
#### Comments/Notes

With full datasets, each step of this workflow can take several hours.  Please be sure that all PBS jobs have finished before moving onto the next step.  A "Logs" directory will be created upon initiation of the workflow.  Please inspect all log files for errors.  

