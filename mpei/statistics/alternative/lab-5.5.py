import numpy as np
from scipy import stats

# Проверка гипотезы об однородности.
# наблюдаемые
observed = np.array([
    [82, 535, 1173, 1714],
    [63, 429, 995, 1307],
])
# оценка вероятностей
n = observed.sum().sum()
factories = observed.sum(1)
sulfur = observed.sum(0)
# ожидаемые количества
expected = np.outer(factories, sulfur)
# статистика
X2 = n * ((observed**2 / expected).sum((0,1)) - 1)
print(f'X2 = {X2:.5f}')
# порог
h = stats.chi2.ppf(1-0.05, df=(observed.shape[0]-1)*(observed.shape[1]-1))
print(f'h = {h:.5f}')