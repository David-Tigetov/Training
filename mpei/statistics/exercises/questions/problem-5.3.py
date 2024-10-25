import numpy
from scipy import stats

# реализация выборки
sample = numpy.array([476, 1017, 527])
# эмпирическая функция распределения
volume = sample.sum()
observed = numpy.array(
    [sample[0], sample[0:2].sum(), sample[0:3].sum()]) / volume
# оценка вероятности
p = (0.5 * sample[1] + sample[2]) / volume
# функция распределения
expected = stats.binom.cdf([0, 1, 2], 2, p)
# разность
difference = observed - expected
maximum_absolute = numpy.max(numpy.abs(difference))
statistic = numpy.sqrt(volume) * maximum_absolute
alpha = stats.kstwobign.ppf(statistic)
threshold = stats.kstwobign.ppf(1-0.1)

print(f'{"Observed CDF:":15}' + str(observed))
print(f'{"Expected CDF:":15}' + str(expected))
print(f'{"Difference:":15}' + str(difference))
print(f'{"Max. Abs.:":15}{maximum_absolute}')
print(f'{"Statistic:":15}{statistic}')
print(f'{"P-value:":15}{alpha}')
print(f'{"Threshold:":15}{threshold}')
