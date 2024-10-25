import numpy
from scipy import stats

print('Домашнее задание 4')
print('Задача 5')

sigma = 2
# 1)
m_0 = 40
n = 36
h = m_0 + sigma/numpy.sqrt(n)*stats.norm.ppf(1-0.05)
print(f'1) h: {h:.5f}')
# 2)
m_0 = 40
m_1 = 39.2
n = 36
alpha = 0.1
h = m_0 + sigma / numpy.sqrt(n) * stats.norm.ppf(alpha)
beta = 1 - stats.norm.cdf((h - m_1)/(sigma / numpy.sqrt(n)))
print(f'2) h: {h:.5f}, beta: {beta:.5f}')
# 3)
m_0 = 40
m_1 = 41
m_2 = 41.5
n = 100
alpha = 0.05
gamma = 0.03
h_0 = m_0 + sigma/numpy.sqrt(n) * stats.norm.ppf(1-alpha)
h_1 = m_2 + sigma/numpy.sqrt(n) * stats.norm.ppf(gamma)
beta = stats.norm.cdf((h_0 - m_1)/(sigma / numpy.sqrt(n))) + 1 - stats.norm.cdf((h_1 - m_1)/(sigma / numpy.sqrt(n)))
print(f'3) h_0: {h_0:.5f}, h_1: {h_1:.5f}, beta: {beta:.5f}')
# 4)
print('4)')
h = 40.2
columns = 4
rows = 10
expectation = numpy.linspace(39, 41, columns * rows + 1)
power = lambda m : 1 - stats.norm.cdf((h - m)/(sigma / numpy.sqrt(n)))
for row in range(rows):
    line = str('')
    for column in range(columns):
        index = column*rows + row
        if column > 0:
            line += ' & '
        line += f'{expectation[index]:5.2f} & {power(expectation[index]):.6f}'
        if column == columns-1:
            line += ' \\\\'
    print(line)
print(f'{expectation[-1]:5.2f} & {power(expectation[-1]):.6f}')