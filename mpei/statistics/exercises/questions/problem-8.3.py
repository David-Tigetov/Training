import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

t = numpy.array([[2.0], [-1.0]])
x = numpy.array([[1.0], [4.0], [9.0]])
Z = numpy.hstack((x, x**0.5))
e = numpy.matmul(Z, t)
e[2,0] = 16
print(f'e = ' + dg.unroll(*e.transpose(), ', '))

W = numpy.array([[0.5, 0, 0], [0, 0.5, 0], [0, 0, 0.1]])
regression = dg.Regression(e, Z, W)
print(regression)
regression.error_confidence(0.8)
