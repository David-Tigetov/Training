import numpy as np
from scipy import stats

# Проверка гипотезы в опыте Менделя.
# наблюдаемые
observed = np.array([315, 101, 108, 32])
# ожидаемые
n = observed.sum()
expected = n * np.array([9/16, 3/16, 3/16, 1/16])
# статистика
X2 = np.sum((observed - expected)**2 / expected)
print(f'X2 = {X2:.5f}')
# уровень значимости
a = 1 - stats.chi2.cdf(X2, df = observed.shape[0] - 1)
print(f'alpha = {a:.5f}')