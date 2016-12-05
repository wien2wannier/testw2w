#!/bin/bash

### wien2wannier/test/repl/iss10-tetragonal.sh
###
### Copyright 2016 Elias Assmann

set -e

w2wdir=$(realpath $(dirname $0)/../../..)

me=W-new

$w2wdir/SRC_w2w/w2wc upw2w.def

GIT_PAGER= git diff --no-index -U0 $me.outputwf.old $me.outputwf \
         || echo

../compare-num.py $me.eig.old   $me.eig   > $me.eig.diff
../compare-num.py $me.mmnup.old $me.mmnup > $me.mmnup.diff
../compare-num.py $me.amnup.old $me.amnup > $me.amnup.diff

$w2wdir/SRC_wplot/wplotc wplot.def

GIT_PAGER= git diff --no-index -U0 ${me}_1.outputwplot{.old,} \
    || echo

../compare-num.py ${me}_1.psink{.old,} > ${me}_1.psink.diff
../compare-num.py ${me}_1.psiarg{.old,} > ${me}_1.psiarg.diff


## Time-stamp: <2016-08-04 09:08:41 assman@faepop71.tu-graz.ac.at>
