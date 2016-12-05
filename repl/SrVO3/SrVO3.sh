#!/bin/bash

### wien2wannier/test/repl/SrVO3.sh
###
### Copyright 2016 Elias Assmann

set -e

w2wdir=$(realpath $(dirname $0)/../../..)

me=SrVO3

$w2wdir/SRC_w2w/w2w w2w.def

GIT_PAGER= git diff --no-index -U0 $me.outputwf{.old,} \
         || echo

../compare-num.py $me.eig.old $me.eig > $me.eig.diff
../compare-num.py $me.mmn.old $me.mmn > $me.mmn.diff
../compare-num.py $me.amn.old $me.amn > $me.amn.diff

x wannier90

../compare-num.py ${me}_hr.dat{.old,} > ${me}_hr.dat.diff
../compare-num.py ${me}_centres.xyz{.old,} > ${me}_centres.xyz.diff

$w2wdir/SRC_wplot/wplot wplot.def

GIT_PAGER= git diff --no-index -U0 ${me}_1.outputwplot{.old,} \
         || echo

../compare-num.py ${me}_1.psink{.old,} > ${me}_1.psink.diff
../compare-num.py ${me}_1.psiarg{.old,} > ${me}_1.psiarg.diff

## Time-stamp: <2016-08-02 15:21:04 assman@faepop71.tu-graz.ac.at>
