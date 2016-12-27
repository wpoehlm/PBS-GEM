#!/bin/bash

BASEDIR=$(pwd)
mkdir Count
cp $BASEDIR/Templates/basedir.txt $BASEDIR/Count

for i in `cat SRAList.txt` ; do cat $BASEDIR/Templates/STRINGTIE.template \
| sed s/SRA/$i/g > $BASEDIR/Count/$i.stringtie.pbs ; done

cd $BASEDIR/Count

for i in *tie.pbs ; do qsub -o $BASEDIR/Logs/$i.out \
-e $BASEDIR/Logs/$i.err ./$i ; done

mkdir PBS
mv *pbs PBS



