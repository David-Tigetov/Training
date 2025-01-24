import numpy as np
from scipy import stats

# Проверка гипотезы о независимости.
# наблюдаемые
observed = np.array([
    [45, 26, 12],
    [32, 50, 21],
    [4, 10, 17]
])
# оценка вероятностей
n = observed.sum().sum()
P = observed.sum(1)
S = observed.sum(0)
# ожидаемые количества
expected = np.outer(P, S)
# статистика
X2 = n * ((observed**2 / expected).sum((0,1)) - 1)
print(f'X2 = {X2:.5f}')
# уровень значимости
a = 1 - stats.chi2.cdf(X2, df=(observed.shape[0]-1)*(observed.shape[1]-1))
print(f'alpha = {a:.9f}')