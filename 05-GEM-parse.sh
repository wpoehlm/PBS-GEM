#!/bin/bash

BASEDIR=$(pwd)
mkdir $BASEDIR/GEM
mkdir $BASEDIR/GEM/transcripts
cp $BASEDIR/Templates/basedir.txt $BASEDIR/GEM
cp $BASEDIR/Templates/basedir.txt $BASEDIR/GEM/transcripts

cd $BASEDIR/Templates

qsub -o $BASEDIR/Logs/GEM.out -e $BASEDIR/Logs/GEM.err \
./GEM.template

cd $BASEDIR
