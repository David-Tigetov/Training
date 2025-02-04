import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

observed = numpy.array([110, 130, 70, 90, 100])
probabilities = numpy.array([1/5]*5)
print(dg.Chi_squared(observed, probabilities))