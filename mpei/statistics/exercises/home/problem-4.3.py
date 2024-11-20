import numpy
from scipy import stats

n = 10
m_1 = 15.3
m_2 = 16.1
s_1 = 0.2
s_2 = 0.15
alpha = 0.1

print('Домашнее задание 4')
print('Задача 3')


def report(name, statistic, lower, upper):
    print('*** ' + name + ' ***')
    print(f'{"Statistic:":12}{statistic:.5f}')
    print(f'{"Lower:":12}{lower:.5f}')
    print(f'{"Upper:":12}{upper:.5f}')


# критерий Фишера
statistic = s_1/s_2
lower = stats.f.ppf(alpha/2, dfn=n-1, dfd=n-1)
upper = stats.f.ppf(1 - alpha/2, dfn=n-1, dfd=n-1)
print('*** Fisher ***')
print(f'{"Statistic:":12}{statistic:.5f}')
print(f'{"Lower:":12}{lower:.5f}')
print(f'{"Upper:":12}{upper:.5f}')

# критерий Стьюдента
statistic = numpy.sqrt(n*n/(n+n)) * (m_1 - m_2) / \
    numpy.sqrt(((n-1)*s_1 + (n-1)*s_2)/(n+n-2))

upper = stats.t.ppf(1 - alpha, df=n+n-1)
print('*** Student ***')
print(f'{"Statistic:":12}{statistic:.5f}')
print(f'{"Upper:":12}{upper:.5f}')
