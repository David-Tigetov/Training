import numpy
from scipy import stats
from functools import reduce

print('Домашнее задание 4')
print('Задача 1')


def chi2_test(observed, probabilities, parameter):
    # объём
    volume = observed.sum()
    # ожидаемые количества
    expected = probabilities * volume
    # отклонения
    deviations = (observed - expected)**2 / expected
    # статистика
    statistic = deviations.sum()
    # количество степеней свободы
    freedom = observed.shape[0] - 1 - parameter
    # уровень значимости
    alpha = 1 - stats.chi2.cdf(statistic, df=freedom)
    # таблица
    print(f'{"Observed":>10} & {"Probability":>15} & {"Expected":>10} & {"Deviation":>10}')
    for row in range(observed.shape[0]):
        print(
            f'{observed[row]:10} & {probabilities[row]:15.3f} & {expected[row]:10.3f} & {deviations[row]:10.3f} \\\\')
    print(f'{volume:10} & {probabilities.sum():15.3f} & {"":10} & {statistic:10.3f} \\\\')
    # вывод
    print(f'{"":2}{"Freedom":12}{freedom}')
    print(f'{"":2}{"P-value":12}{alpha:.5f}')


def shrink(data, decrement):
    # сжатие данных с конца
    shrinked = numpy.array(data[:decrement])
    for element in data[decrement:]:
        shrinked[-1] += element
    return shrinked


# реализация выборки
sample = stats.poisson.rvs(2, size=187)
# значения и количества
values, counts = numpy.unique(sample, return_counts=True)
# реализация из задачи
values = range(9)
counts = numpy.array([28, 49, 57, 25, 16, 4, 4, 3, 1])
print(f'Число \\par отказов: & '
      + reduce(lambda s, e: s + ' & ' + str(e), values[1:], str(values[0])) + ' \\\\')
print(f'Число \\par испытаний & '
      + reduce(lambda s, e: s + ' & ' + str(e), counts[1:], str(counts[0])) + ' \\\\')

print('*** Poisson ***')
# оценка параметра
mu = reduce(lambda s, e: s + e[0]*e[1], zip(values, counts), 0) \
    / numpy.sum(counts)
print(f'{"Estimate:":12}{mu:.5f}')
probabilities = stats.poisson.pmf(values, mu)
# прямой тест
print('* Straight test')
chi2_test(counts, probabilities, 1)
# тест после объединения
print('* Joint test')
joint_counts = shrink(counts, -3)
joint_probabilities = shrink(probabilities, -3)
chi2_test(joint_counts, joint_probabilities, 1)

print('*** Binomial ***')
p = reduce(lambda s, e: s + e[0]*e[1], zip(values, counts), 0) \
    / (numpy.sum(counts) * counts.shape[0])
print(f'{"Estimate:":12}{p:.5f}')
probabilities = stats.binom.pmf(values, counts.shape[0], p)
# прямой тест
print('* Straight test')
chi2_test(counts, probabilities, 1)
# тест после объединения
print('* Joint test 1')
joint_counts = shrink(counts, -3)
joint_probabilities = shrink(probabilities, -3)
chi2_test(joint_counts, joint_probabilities, 1)
