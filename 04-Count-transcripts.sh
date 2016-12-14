#!/bin/bash

BASEDIR=$(pwd)
mkdir Count
cp $BASEDIR/Templates/basedir.txt $BASEDIR/Count

tar -xf $BASEDIR/Software/stringtie-1.3.1c.Linux_x86_64.tar.gz -C \
$BASEDIR/Software

for i in `cat SRAList.txt` ; do cat $BASEDIR/Templates/STRINGTIE.template \
| sed s/SRA/$i/g > $BASEDIR/Count/$i.stringtie.pbs ; done

cd $BASEDIR/Count

for i in *tie.pbs ; do qsub -o $BASEDIR/Logs/$i.out \
-e $BASEDIR/Logs/$i.err ./$i ; done

mkdir PBS
mv *pbs PBS



