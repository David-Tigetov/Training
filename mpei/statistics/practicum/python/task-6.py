import numpy
import scipy.stats as stats

generator = numpy.random.default_rng()
first = generator.normal(1, 3, 1000)
second = generator.normal(1.2, 5, 1000)
third = generator.normal(0.9, 7, 1000)
test = stats.f_oneway(first, second, third)
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')
