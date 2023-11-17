import numpy
from matplotlib import pyplot
from scipy import stats

generator = numpy.random.default_rng()
sample = generator.normal(loc=2.5, scale=3.0, size=100)
distribution = stats.norm
estimates = stats.fit(distribution, sample)
print(estimates)
estimates.plot()
pyplot.show()
