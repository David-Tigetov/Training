import numpy
from scipy import stats

import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + '/..')
import dg

print('Домашнее задание 4')
print('Задача 2')

# данные
observed = numpy.array(
    [
        [13, 2, 6, 3],
        [0, 1, 13, 11],
        [1, 2, 7, 3],
        [5, 2, 4, 4],
        [10, 3, 6, 4]
    ]
)

print(dg.Chi_homogeneity(observed))