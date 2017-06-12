#!/bin/bash

REF_PREFIX=$1


cat ./Templates/Index.template | sed s/REF_PREFIX/$REF_PREFIX/g >> \
./Reference/RefIndex.pbs

cd ./Reference/

qsub -o ../Logs/Index.out -e ../Logs/Index.err ./RefIndex.pbs
