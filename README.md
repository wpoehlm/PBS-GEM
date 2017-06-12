# PBS-GEM
This workflow contains PBS job wrappers, pre-configured software packages(all open source), and bash scripts that automate the submission of PBS jobs that perform the following tasks:

* Download RNA sequencing data in FASTQ format using the [SRA Toolkit](https://www.ncbi.nlm.nih.gov/books/NBK158900/)
* Trim raw fastq files of poor quality reads and Illumina adapter sequences using [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
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

### Download and Index Reference Genome


The reference genome must be indexed using Hisat2.  Download a reference genome in FASTA (.fa) format, and place this file in the _Reference_ directory of the workflow.  To index this reference genome, execute the _Index-Genome.sh_ script and provide a reference prefix as an argument:

        $ ./Index-Genome.sh $REF_PREFIX
        
For example:

        $ ./Index-Genome.sh chr21-GRCh38

Please note that only one .fa genome file can be present in the _Reference_ directory.  Please remove the example file, "chr21-GRCh38.fa", before using your own data.  

### Download GFF3 Genome Annotation

A GFF3 file that corresponds to the reference genome must be placed in the _Reference_ directory.  Please check that only one GFF3 file is present.  


### Identify SRA sample ID's and modify SRAList.txt file

SRA sample ID's must be specified in the "SRAList.txt" file.  Please modify this file to specify the samples that you want to process.  Each SRA ID must be present on a new line.  

## Execute the Workflow

The workflow contains a small reference genome for testing.  To run the workflow, execute each step of the pipeline as follows:  

### Download Input Data

    $ ./01-Prepare-inputs.sh
    
Please note that this script has the "-X 10000" parameter set by default.  This will only download the first 10,000 reads from each sample, to enable the user to quickly test the workflow.  Please remove "X 10000" from the _FASTQ-DUMP.template_ file in the _Templates_ directory when performing your experiment.  
  
### Trim Reads

    $ ./02-Trim-reads.sh

### Map Reads to Reference Genome 

    $ ./03-Map-reads.sh chr21-GRCh38
    
When using your own data, please replace "chr21-GRCh38" with the appropriate reference prefix (same as the $REF_PREFIX that you chose when indexing the reference genome).  

### Quantify Transcript Abundances

    $ ./04-Count-transcripts.sh

### Build Gene Expression Matrix (GEM)

    $ ./05-GEM-parse.sh
    
#### Comments/Notes

With full datasets, each step of this workflow can take several hours.  Please be sure that all PBS jobs have finished before moving onto the next step.  A "Logs" directory will be created upon initiation of the workflow.  Please inspect all log files for errors.  

