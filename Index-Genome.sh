#!/bin/bash

REF_PREFIX=$1

pwd > basedir.txt
BASEDIR=$(pwd)
cp basedir.txt $BASEDIR/Templates 
cp basedir.txt $BASEDIR/Logs/Progress
rm $BASEDIR/basedir.txt


cat ./Templates/Index.template | sed s/REF_PREFIX/$REF_PREFIX/g >> \
$BASEDIR/Reference/RefIndex.pbs

cd $BASEDIR/Reference/

qsub -o $BASEDIR/Logs/Index.out -e $BASEDIR/Logs/Index.err ./RefIndex.pbs
