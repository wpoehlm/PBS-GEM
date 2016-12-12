#!/bin/bash

BASEDIR=$(pwd)
mkdir $BASEDIR/FastQ
cp Templates/basedir.txt $BASEDIR/FastQ

tar -xf $BASEDIR/Software/sratoolkit.2.8.0-ubuntu64.tar.gz -C $BASEDIR\
/Software

for i in `cat SRAList.txt` ; do cat $BASEDIR/Templates/FASTQ-DUMP.template | \
sed s/SRAID/$i/g > $BASEDIR/FastQ/$i.FastQDump.pbs ; done

cd $BASEDIR/FastQ

for i in *Dump.pbs ; do qsub -o $BASEDIR/Logs/$i.SRA.out \
-e $BASEDIR/Logs/$i.SRA.err ./$i ; done

mkdir PBS
mv *pbs PBS
