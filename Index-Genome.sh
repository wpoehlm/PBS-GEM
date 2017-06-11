#!/bin/bash

REF_PREFIX=$1


cat ./Templates/Index.template | sed s/REF_PREFIX/$REF_PREFIX/g >> \
./Reference/RefIndex.pbs

cd ./Reference/

qsub -o $BASEDIR/Logs/Index.out -e $BASEDIR/Logs/Index.err ./RefIndex.pbs
