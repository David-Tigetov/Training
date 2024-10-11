import numpy
from scipy import stats


def analysis(observations, significance):
    # сумма квадратов
    squares_sums = [numpy.sum(numpy.square(sample)) for sample in observations]
    total_squares = numpy.sum(squares_sums)
    # сумма элементов
    elements_sums = [sample.sum() for sample in observations]
    total_elements = numpy.sum(elements_sums)
    # количества
    counts = [sample.shape[0] for sample in observations]
    total_counts = numpy.sum(counts)

    # квадраты сумм
    sum_p2 = numpy.square(elements_sums)
    # усредненные квадраты сумм
    sum_p2_means = [square/count for (square, count) in zip(sum_p2, counts)]
    # сумма усредненных квадратов сумм
    total_sum_p2_means = numpy.sum(sum_p2_means)

    print('Squares | Elements | Counts | Sq. Sums | Sq. Sums Means')
    for row in zip(squares_sums, elements_sums, counts, sum_p2, sum_p2_means):
        print(
            f'{row[0]:7g} | {row[1]:8g} | {row[2]:6g} | {row[3]:8g} | {row[4]:14g}')
    print('============================************===============')
    print(f'{total_squares:7g} | {total_elements:8g} | {total_counts:6g} | {"":8} | {total_sum_p2_means:14g}')

    # средний квадрат суммы элементов
    total_squared_mean = numpy.square(total_elements) / total_counts
    # общая выборочная дисперсия, умноженная на количество
    common_variance_n = total_squares - total_squared_mean
    # межгрупповая дисперсия, умноженная на количество
    outer_variance_n = total_sum_p2_means - total_squared_mean
    # внутригрупповая дисперсия, умноженная на количество
    inner_variance_n = common_variance_n - outer_variance_n

    # количество уровней
    levels_count = len(observations)
    # статистика
    statistic = outer_variance_n / \
        (levels_count-1) * (total_counts - levels_count) / inner_variance_n
    # уровень значимости
    survival = stats.f.sf(statistic, levels_count-1,
                          total_counts - levels_count)
    # порог
    threshold = stats.f.ppf(
        1 - significance, levels_count-1, total_counts - levels_count)

    print(f'{"Total squared mean:":<25}{total_squared_mean:6.3f}')
    print(f'{"(Common variance)*n:":<25}{common_variance_n:6.3f}')
    print(f'{"(Outer variance)*n:":<25}{outer_variance_n:6.3f}')
    print(f'{"(Inner variance)*n:":<25}{inner_variance_n:6.3f}')
    print(f'{"Statistic:":<25}{statistic:6.3f}')
    left_fisher = f'1-F({levels_count-1:g},{total_counts - levels_count:g})'
    print(f'{left_fisher:<25}{survival:6.3f}')
    print(f'{"Threshold:":<25}{threshold:6.3f}')


# количества и средние
input = [
    {"size": 3, "mean": 10},
    {"size": 3, "mean": 5}
]
# дисперсия
variance = 16

# формируем реализацию наблюдений
observations = list()
for experiment in input:
    observations.append(
        numpy.round(
            numpy.random.normal(loc=experiment["mean"], scale=numpy.sqrt(variance), size=experiment["size"]))
    )

# пример для практического занятия
# observations = [
#     numpy.array([3, 7, 7]),
#     numpy.array([4, 1, 7, 5, 9]),
#     numpy.array([5, 2, 9, 6])
# ]

# пример из Ефимова, страница 281
# observations = [
#     numpy.array([1, 3, 2, 1, 0, 2, 1]),
#     numpy.array([2, 3, 2, 1, 4]),
#     numpy.array([4, 5, 3])
# ]

# задача 278 из Ефимова, страница 286
# observations = [
#     numpy.array([5.9, 6.0, 7.0, 6.5, 5.5, 7.0, 8.1, 7.5, 6.2, 6.4, 7.1, 6.9]),
#     numpy.array([4.0, 5.1, 6.2, 5.3, 4.5, 4.4, 5.3, 5.4, 5.6, 5.2]),
#     numpy.array([8.2, 6.8, 8.0, 7.5, 7.0, 7.2, 7.9, 8.1, 8.5, 7.8, 8.1])
# ]

# выводим реализацию наблюдений
for sample in observations:
    print(sample)

# выполняем анализ
analysis(observations, 0.1)

# библиотечная функция
test = stats.f_oneway(*observations)
print(f'Statistic: {test.statistic}, P-value: {test.pvalue}')
