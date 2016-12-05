#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import numpy as np

OLD = '\033[31m'
NEW = '\033[32m'
FAT = '\033[1m'
END = '\033[0m'

f1 = open(sys.argv[1]); f1.readline()
f2 = open(sys.argv[2]); f2.readline()

ndiff = 0
ntot  = 0
dsum  = 0
sqsum = 0
dmax  = 0

a1=np.array([])
a2=np.array([])

quiet = False

for l1 in f1:
    l2 = f2.readline()

    try:
        a1 = np.array(l1.split(), float)
        a2 = np.array(l2.split(), float)
    except ValueError:
        next

    ntot += len(a1)

    if not (a1 == a2).all():
        idx = np.where(a1 != a2)
        diff = a2[idx] - a1[idx]

        ndiff += len(diff)
        dsum  += sum(diff)
        sqsum += sum(diff**2)
        if any(abs(diff) > dmax):
            dmax = max(abs(diff))

        if not quiet:
            print OLD+str(l1)+END + NEW+str(l2)+END + FAT+str(diff)+END

if ndiff > 0:
    print >>sys.stderr, 'Comparing', OLD+sys.argv[1]+END, '↔', \
        NEW+sys.argv[2]+END+':'
    print >>sys.stderr, '', ndiff, '/', ntot, \
      '('+str((100*ndiff)/ntot)+' %) elements differ'
    print >>sys.stderr, '', ' ⟨Δ⟩    =', dsum/ndiff
    print >>sys.stderr, '', '√⟨Δ²⟩   =', np.sqrt(sqsum/ndiff)
    print >>sys.stderr, '', 'max |Δ| =', dmax
