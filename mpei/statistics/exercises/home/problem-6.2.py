import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

x = numpy.array([[1], [2], [3], [4], [5], [6], [7], [8], [9], [10]])
e = numpy.array([[0.5], [0.9], [0.4], [2.2], [0.6], [1.1], [0.8], [2.4], [1.2], [4.3]])
Z = numpy.hstack((numpy.ones((10,1), dtype=float), x, numpy.pow(x,2)))

W = numpy.diag([1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8, 1/9, 1/10])
print(W)
regression = dg.Regression(e, Z, W)
print(regression)
regression.estimate_confidence(0.95)
regression.estimate_confidence(1-0.1)
regression.error_confidence(0.9)