import numpy
from scipy import stats

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

print('*** Вариант 1 ***')

print('Задача 1')
print(dg.Chi_squared(numpy.array([25, 45, 30]), numpy.array([0.3, 0.5, 0.2])))
print(f'Threshold:  {stats.chi2.ppf(1-0.05, df=2):.5f}')

print('Задача 2')
print(f'Left: {stats.t.ppf(0.05, df=14)}')
print(f'Right: {stats.t.ppf(1-0.05, df=14)}')

print('Задача 3')
print(f'Threshold: {stats.kstwo.ppf(1-0.01, n=10)}')
print(f'Threshold: {stats.kstwobign.ppf(1-0.01)}')

print('Задача 4')
print(dg.Chi_homogeneity(numpy.array([[32, 23, 12],[18, 7, 8]])))
print(f'Threshold:  {stats.chi2.ppf(1-0.1, df=2)}')

print('Задача 5')
probabilities = stats.binom.pmf([0, 1, 2], 2, 0.5)
print(dg.Chi_squared(numpy.array([30, 40, 30]), probabilities, 1))
print(f'Threshold:  {stats.chi2.ppf(1-0.05, df=1)}')

print('*** Вариант 2 ***')
print('Задача 1')
print(f'{"Statistic:":10}{9.0*3.0/(14.0*2.0)}')
print(f'{"Left:":10}{stats.f.ppf(0.25, dfd=9, dfn=14)}')
print(f'{"Right:":10}{stats.f.ppf(0.975, dfd=9, dfn=14)}')

print('Задача 2')
print(dg.Chi_squared(numpy.array([15, 15, 50, 20]), numpy.array([0.2, 0.1, 0.4, 0.3])))
print(f'Threshold:  {stats.chi2.ppf(1-0.05, df=3):.5f}')

print('Задача 3')
print(f'Threshold: {stats.kstwobign.ppf(1-0.01)}')

print('Задача 4')
print(dg.Chi_independence(numpy.array([[20, 25], [15, 40]])))
print(f'Threshold:  {stats.chi2.ppf(1-0.1, df=1):.5f}')
