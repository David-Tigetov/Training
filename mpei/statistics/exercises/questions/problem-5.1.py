import numpy
from scipy import stats

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

observed = numpy.array([[34, 111], [4, 192]])
print(dg.Chi_independence(observed))
print(f'Threshold:  {stats.chi2.ppf(1-0.05, df=(2-1)*(2-1)):.5f}')
