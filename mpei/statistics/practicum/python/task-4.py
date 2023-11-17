import numpy
from scipy import stats

generator = numpy.random.default_rng()
sample = generator.normal(2.5, 3, size=1000)

quantiles = numpy.array(stats.norm.interval(0.95))
interval = sample.mean() + quantiles*3/numpy.sqrt(sample.size)
print(interval)

# доверительный интервал - распределение Стьюдента
quantiles = numpy.array(stats.t.interval(0.95, sample.size-1))
interval = sample.mean() + quantiles*sample.std()/numpy.sqrt(sample.size)
print(interval)

# доверительный интервал - хи-квадрат
quantiles = numpy.array(stats.chi2.interval(0.95, sample.size))
interval = [(sample.size-1)*sample.std()/quantiles[1], (sample.size-1)*sample.std()/quantiles[0]]
print(interval)
