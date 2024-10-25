import numpy
from scipy import stats

print('Домашнее задание 4')
print('Задача 2')

# данные
sample = numpy.array(
    [
        [13, 2, 6, 3],
        [0, 1, 13, 11],
        [1, 2, 7, 3],
        [5, 2, 4, 4],
        [10, 3, 6, 4]
    ]
)

# оценки
count = numpy.sum(numpy.sum(sample))
estimates = numpy.sum(sample, axis=0) / count
# статистика
X = 0.0
for row in range(sample.shape[0]):
    for column in range(sample.shape[1]):
        X += (sample[row][column] - estimates[column]
              * count)**2 / estimates[column]*count
# уровень значимости
alpha = 1 - stats.chi2.cdf(X, df=(sample.shape[0]-1)*(sample.shape[1]-1))

print(f'{"Count:":12}{count}')
print(f'{"Estimates:":12}' + str(estimates))
print(f'{"Statistic:":12}{X:.3f}')
print(f'{"P-value:":12}{alpha:.3f}')
