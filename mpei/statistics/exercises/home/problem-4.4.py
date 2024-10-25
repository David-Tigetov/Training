import numpy
from scipy import stats
from functools import reduce

print('Домашнее задание 4')
print('Задача 4')


def report(result, estimate=''):
    # вывод результатов теста
    if estimate:
        print(f'{"Estimate:":12}' + estimate)
    print(f'{"Statistic:":12}{result.statistic:.5f}')
    print(f'{"P-value:":12}{result.pvalue:.5f}')
    print(f'{"Location:":12}{result.statistic_location:.3f}')


# реализация выборки из показательного распределения
exponential = stats.expon.rvs(loc=0, scale=2, size=20)
# реализация выборки из задачи
exponential = numpy.array([0.768, 1.31, 2.11, 1.29, 0.868, 1.59, 1.49, 3.24,
                           7.17, 2.1, 0.0434, 1.82, 0.278, 2.1, 1.06, 7.95, 1.69, 0.809, 1.63, 1.15])
print('Exponential: '
      + reduce(lambda x, y: x + ', ' + f'{y:1.3}', exponential[1:], str(f'{exponential[0]:1.3}')))

print('*** Kolmogorov test against exponential ***')
# оценка параметра показательного распределения
t = numpy.mean(exponential)
# тест Колмогорова для показательного распределения
result = stats.kstest(exponential,
                      lambda x: stats.expon.cdf(x, scale=t), alternative='two-sided')
report(result, f'{t:.3f}')

print('*** Kolmogorov test against uniform ***')
# оценка границ равномерного распределения
a = min(exponential)
b = max(exponential)
# тест Колмогорова для равномерного распределения
result = stats.kstest(exponential,
                      lambda x: stats.uniform.cdf(x, loc=a, scale=b-a), alternative='two-sided')
report(result, f'[{a:.3f}, {b:.3f}]')

# реализация выборки из равномерного распределения
uniform = stats.uniform.rvs(loc=0, scale=6, size=15)
# реализация выборки из задачи
uniform = numpy.array([3.72, 0.49, 1.59, 1.21, 0.811, 2.63,
                     2.42, 0.265, 2.24, 0.596, 0.725, 3.5, 1.38, 0.0537, 3.86])
print('Uniform: '
      + reduce(lambda x, y: x + ', ' + f'{y:1.3}', uniform[1:], str(f'{uniform[0]:1.3}')))

print('*** Kolmogorov-Smirnov test ***')
# тест Колмогорова-Смирнова
result = stats.kstest(exponential, uniform, alternative='two-sided')
report(result)
