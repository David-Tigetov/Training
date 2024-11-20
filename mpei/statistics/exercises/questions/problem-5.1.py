import numpy
from scipy import stats

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

observed = numpy.array([34, 111, 4, 192])
volume = observed.sum()
p_a = numpy.array([observed[0] + observed[2], observed[1] + observed[3]]) / volume
p_b = numpy.array([observed[0] + observed[1], observed[2] + observed[3]]) / volume
print(f'Probabilities of A: {p_a}')
print(f'Probabilities of B: {p_b}')

probabilities = numpy.array([p_a[0]*p_b[0], p_a[0]*p_b[1], p_a[1]*p_b[0], p_a[1]*p_b[1]])
print(dg.Chi_squared(observed, probabilities, 2))

threshold = stats.chi2.ppf(1-0.05, df=(2-1)*(2-1))
print(f'Threshold: {threshold:.5f}')
