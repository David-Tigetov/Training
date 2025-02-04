import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

volume = 50
observed = numpy.array([20, volume-20])
probabilities = numpy.array([1/2, 1/2])
print(dg.Chi_squared(observed, probabilities))
