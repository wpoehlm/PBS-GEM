#!/bin/bash

BASEDIR=$(pwd)
mkdir $BASEDIR/FastQ
cp Templates/basedir.txt FastQ

tar -xf $BASEDIR/Software/sratoolkit.2.8.0-ubuntu64.tar.gz -C $BASEDIR\
/Software

for i in `cat SRAList.txt` ; do cat Templates/FASTQ-DUMP.template | \
sed s/SRAID/$i/g > FastQ/$i.FastQDump.pbs ; done

cd $BASEDIR/FastQ

for i in *Dump.pbs ; do qsub -o $BASEDIR/Logs/$i.out \
-e $BASEDIR/Logs/$i.err ./$i ; done

