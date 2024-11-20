import numpy
from scipy import stats

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

volume = 600
observed = numpy.array([75, volume-75])
print(dg.Chi_squared(observed, numpy.array([1/6, 5/6])))
print(f'Threshold: {stats.chi2.ppf(1-0.05, df=1):.5f}')
