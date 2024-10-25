from scipy import stats
n_1 = 15
n_2 = 20
s_1 = 1.3
s_2 = 1.4

statistic = s_1/s_2
threshold = stats.f.ppf(1-0.1, dfn=n_1-1, dfd=n_2-1)

print(f'{"Statistic":15}{statistic:.5f}')
print(f'{"Threshold":15}{threshold:.5f}')
