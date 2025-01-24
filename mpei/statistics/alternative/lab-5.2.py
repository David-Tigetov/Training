import numpy as np
from scipy import stats
from matplotlib import pyplot as plt

# Проверка гипотезы о распределении Пуассона.
# данные
sample = stats.poisson.rvs(mu=12, size=10000)
# оценка параметра
mu_est = sample.mean()
# границы
edges = stats.poisson.ppf(np.linspace(0.2, 0.8, 4), mu=mu_est)
edges = [sample.min(), *edges, sample.max()]
# наблюдаемые количества
observed, _ = np.histogram(sample, edges)
# ожидаемые количества
cumulative = np.array([0, *stats.poisson.cdf(edges[1:-1], mu=mu_est) - stats.poisson.pmf(edges[1:-1], mu=mu_est), 1])
probabilities = cumulative[1:] - cumulative[:-1]
expected = sample.shape[0] * probabilities
# статистика
X2 = np.sum((observed - expected)**2 / expected)
print(f'X2 = {X2:.5f}')
# уровень значимости
a = 1 - stats.chi2.cdf(X2, df = observed.shape[0] - 1 - 1)
print(f'alpha = {a:.5f}')
# приближение
fit = stats.fit(stats.poisson, sample, [(10, 14)])
print(fit)
fit.plot()
plt.grid()
plt.show()