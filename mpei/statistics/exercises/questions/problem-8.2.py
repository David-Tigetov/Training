import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

t = numpy.array([[-1.0], [1.0]])
x = numpy.array([[-1.0], [1.0], [2.0]])
Z = numpy.hstack((x, x**2))
e = numpy.matmul(Z, t)
e[1,0] = 0.5
print(f'e = ' + dg.unroll(*e.transpose(), ', '))

W = numpy.array([[1, 0, 0], [0, 2, 0], [0, 0, 1]])
regression = dg.Regression(e, Z, W)
print(regression)
regression.estimate_confidence(0.95)
regression.estimate_confidence(1-0.2)