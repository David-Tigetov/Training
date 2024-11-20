import numpy
from scipy import stats
from matplotlib import pyplot

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

actual_power = 3.75
# аргументы
x = numpy.linspace(0.1, 1, 99)
# веса
W = 1 + 3*numpy.diag(1/(x**2))
# измерения
e = numpy.vstack(1.5 + x**actual_power + stats.norm.rvs(size=x.shape[0], loc=0, scale=1) * 1/W.diagonal())

# базисные функции
def fill_Z(x, power):
    return numpy.transpose(numpy.vstack([numpy.ones(x.shape[0]), x**power]))

pyplot.figure()
pyplot.scatter(x, e)

for power in numpy.linspace(1, 5, 17):
    # базисные функции
    Z = fill_Z(x, power)
    # регрессия
    regression = dg.Regression(e, Z, W)
    print(f'{power:10.3f}{regression.e_Zp_norm:10.3f}')
    prediction = regression.estimate[0] + regression.estimate[1] * x**power
    pyplot.scatter(x, prediction)

pyplot.show()