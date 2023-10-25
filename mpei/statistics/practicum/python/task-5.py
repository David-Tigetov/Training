import numpy
import scipy.stats as stats

# простая гипотеза принимается
expected = [50, 30, 20]
observed = [48, 33, 19]
test = stats.chisquare(observed, expected)
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')

# простая гипотеза отклоняется
expected = [50, 30, 20]
observed = [27, 35, 38]
test = stats.chisquare(observed, expected)
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')

# гипотеза о независимости
observed = [[110, 50, 70], [90, 85, 80]]
test = stats.chi2_contingency(observed)
print(f'Statistic: {test[0]}, P-value: {test[1]}')

generator = numpy.random.default_rng()
n_sample = generator.normal(2.5, 3, size=1000)
t_sample = 2.5 + 3*generator.standard_t(10, size=1000)
# критерий Колмогорова
test = stats.kstest(n_sample, 'norm', (2.5, 3))
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')
# критерий Колмогорова-Смирнова
test = stats.kstest(n_sample, t_sample)
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')
# критерий Стьюдента
test = stats.ttest_ind(n_sample, t_sample)
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')
