from scipy import stats

def chi2_test(observed, probabilities, parameter=0):
    # объём
    volume = observed.sum()
    # ожидаемые количества
    expected = probabilities * volume
    # отклонения
    deviations = (observed - expected)**2 / expected
    # статистика
    statistic = deviations.sum()
    # количество степеней свободы
    freedom = observed.shape[0] - 1 - parameter
    # уровень значимости
    alpha = 1 - stats.chi2.cdf(statistic, df=freedom)
    # таблица
    print(f'{"Observed":>10} & {"Probability":>15} & {"Expected":>10} & {"Deviation":>10}')
    for row in range(observed.shape[0]):
        print(
            f'{observed[row]:10} & {probabilities[row]:15.3f} & {expected[row]:10.3f} & {deviations[row]:10.3f} \\\\')
    print(f'{volume:10} & {probabilities.sum():15.3f} & {"":10} & {statistic:10.3f} \\\\')
    # вывод
    print(f'{"":2}{"Freedom":12}{freedom}')
    print(f'{"":2}{"P-value":12}{alpha:.5f}')
