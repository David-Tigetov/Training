import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

t = numpy.array([[-2.0], [3.0]])
x = numpy.array([[-1.0], [0.5], [1.0]])
Z = numpy.hstack((x, 1/x))
e = numpy.matmul(Z, t)
e[2,0] = 2.0
print(f'e = ' + dg.unroll(*e.transpose(), ', '))

W = numpy.array([[0.5, 0.0, 0.0], [0.0, 0.5, 0.0], [0.0, 0.0, 1]])
regression = dg.Regression(e, Z, W)
print(regression)