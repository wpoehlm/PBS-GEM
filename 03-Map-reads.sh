#!/bin/bash

REF=$1

BASEDIR=$(pwd)
mkdir $BASEDIR/Alignment
cp $BASEDIR/Templates/basedir.txt $BASEDIR/Alignment

for i in `cat $BASEDIR/SRAList.txt` ; do cat $BASEDIR/Templates/HISAT.template \
| sed s/SRA/$i/g | sed s/REF/$REF/ > $BASEDIR/Alignment/$i.hisat.pbs ; done

cd $BASEDIR/Alignment

for i in *hisat.pbs ; do qsub -o $BASEDIR/Logs/$i.out \
-e $BASEDIR/Logs/$i.err ./$i ; done

mkdir PBS
mv *pbs PBS
