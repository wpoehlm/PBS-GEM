#!/bin/bash

BASEDIR=$(pwd)
mkdir $BASEDIR/Alignment
cp $BASEDIR/Templates/basedir.txt $BASEDIR/Alignment

tar -xf $BASEDIR/Software/samtools-1.3.1.tar.gz -C $BASEDIR/Software

for i in `cat $BASEDIR/SRAList.txt` ; do cat $BASEDIR/Templates/HISAT.template \
| sed s/SRA/$i/g > $BASEDIR/Alignment/$i.hisat.pbs ; done
