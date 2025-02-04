import numpy

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

print('Практическое занятие 6')
print('Задача 1')
e = numpy.array([[2.5], [3.2], [3.6]])
Z = numpy.array([[1, 1], [1, 2], [1, 3]])
W = numpy.diag([1, 1/4, 1/9])
regression = dg.Regression(e, Z, W)
print(regression)
regression.estimate_confidence(0.95)
regression.error_confidence(0.9)