import numpy
from scipy import stats
from matplotlib import pyplot
from functools import reduce

print(stats.norm.ppf(0.975))
exit()

# аргумент
x = numpy.linspace(0, 10, 41)
# точные значения
precise = x**2.7 * numpy.exp(-1.2*x)
# ошибки
errors = stats.norm.rvs(loc=0, scale=0.01, size=x.shape[0])

y = precise + errors

def to_string(values):
    return reduce(lambda s, v: s + ' & ' + f'{v:.2f}', values[1:], f'{values[0]:.2f}')

print("x")
print(to_string(x))
print("y")
print(to_string(y))

pyplot.figure()
pyplot.scatter(x, precise + errors)
pyplot.show()