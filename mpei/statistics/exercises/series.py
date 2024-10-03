import numpy
from scipy import stats
from matplotlib import pyplot

# выборка из показательного распределения
sample = stats.expon.rvs(loc = 0, scale=2, size=20)
print('Exponential')
for e in sample:
    print(f'{e:1.3}')

sample = numpy.array([0.768, 1.31, 2.11, 1.29, 0.868, 1.59, 1.49, 3.24, 7.17, 2.1, 2.1, 0.0434, 1.82, 0.278, 1.06, 7.95, 1.69, 0.809, 1.63, 1.15])

fitting = stats.expon.fit(sample)
print(fitting)

pyplot.hist(sample, bins=30)

# выборка из равномерного распределения
sample = stats.uniform.rvs(loc = 0, scale=4, size=15)
print('Uniform')
for e in sample:
    print(f'{e:1.3}')
sample = numpy.array([3.72, 0.49, 1.59, 1.21, 0.811, 2.63, 2.42, 0.265, 2.24, 0.596, 0.725, 3.5, 1.38, 0.0537, 3.86])
fitting = stats.uniform.fit(sample)
print(fitting)

pyplot.hist(sample, bins=30)
pyplot.show()
