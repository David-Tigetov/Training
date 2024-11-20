import numpy
from scipy import stats
from functools import reduce

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

print('Домашнее задание 4')
print('Задача 1')


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
values = range(4)
counts = numpy.array([42, 10, 4, 3])
print(f'Число \\par отказов: & '
      + reduce(lambda s, e: s + ' & ' + str(e), values[1:], str(values[0])) + ' \\\\')
print(f'Число \\par испытаний & '
      + reduce(lambda s, e: s + ' & ' + str(e), counts[1:], str(counts[0])) + ' \\\\')

print('*** Poisson ***')
# оценка параметра
numerator = reduce(lambda s, e: s + e[0]*e[1], zip(values, counts), 0)
denominator = numpy.sum(counts)
mu =  numerator / denominator
print(f'{"Estimate:":12}{numerator} / {denominator} = {mu:.5f}')
probabilities = stats.poisson.pmf(values, mu)
# прямой тест
print('* Straight test')
print(dg.Chi_squared(counts, probabilities, 1))
# тест после объединения
print('* Joint test')
joint_counts = shrink(counts, -1)
joint_probabilities = shrink(probabilities, -1)
print(dg.Chi_squared(joint_counts, joint_probabilities, 1))

print('*** Binomial ***')
numerator = reduce(lambda s, e: s + e[0]*e[1], zip(values, counts), 0)
denominator_sum = numpy.sum(counts)
p = numerator / (denominator_sum * (counts.shape[0]-1))
print(f'{"Estimate:":12}{numerator} / ({denominator_sum} * {counts.shape[0]-1}) = {numerator} / {denominator_sum*(counts.shape[0]-1)} = {p:.5f}')
probabilities = stats.binom.pmf(values, counts.shape[0]-1, p)
# прямой тест
print('* Straight test')
print(dg.Chi_squared(counts, probabilities, 1))
# тест после объединения
print('* Joint test 1')
joint_counts = shrink(counts, -3)
joint_probabilities = shrink(probabilities, -3)
print(dg.Chi_squared(joint_counts, joint_probabilities, 1))
