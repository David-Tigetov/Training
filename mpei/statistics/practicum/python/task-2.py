import numpy
from scipy import stats
from matplotlib import pyplot

distributions = (
    {'name': 'Равномерное',
        'cdf': lambda x: stats.uniform.cdf(x, -1, 3),
        'cdf arguments': numpy.array([-1, 2]),
        'sample': lambda volume: stats.uniform.rvs(-1, 3, size=volume),
        'bins': numpy.linspace(-1, 2, 30),
        'moments' : stats.uniform.stats(-1, 3, 'mvs')},
    {'name': 'Нормальное',
        'cdf': lambda x: stats.norm.cdf(x, 1, 2),
        'cdf arguments': numpy.linspace(-5, 6, 20),
        'sample': lambda volume: stats.norm.rvs(1, 2, size=volume),
        'bins': numpy.linspace(-5, 6, 40),
        'moments' : stats.norm.stats(1, 2, 'mvs')},
    {'name': 'Показательное',
        'cdf': lambda x: stats.expon.cdf(x, 0, 1/2),
        'cdf arguments': numpy.linspace(0, 4, 20),
        'sample': lambda volume: stats.expon.rvs(0, 1/2, size=volume),
        'bins': numpy.linspace(0, 3, 30),
        'moments' : stats.expon.stats(0, 1/2, 'mvs')},
    {'name': 'Биномиальное',
        'cdf': lambda x: stats.binom.cdf(x, 8, 0.3),
        'cdf arguments': range(9),
        'sample': lambda volume: stats.binom.rvs(8, 0.3, size=volume),
        'bins': numpy.array(range(9)),
        'moments' : [8*0.3, 8*0.3*0.7, 0]}
)

# Задача 1
sizes = [10]*3
for distribution in distributions:
    # наименование распределения
    print(distribution['name'])
    for size in sizes:
        # реализация выборки
        sample = distribution['sample'](size)
        # реализация вариационного ряда
        print(numpy.sort(sample))


# Задачи 2 и 3
# графики реализаций эмпирической функции распределения
def plot_empirical_functions(sizes):
    for distribution in distributions:
        pyplot.figure()
        for size in sizes:
            # реализация выборки
            sample = distribution['sample'](size)
            # реализация эмпирической функции распределения
            ecdf = stats.ecdf(sample)
            ecdf.cdf.plot(pyplot, label=size)
        # функция распределения
        if distribution['name'] == 'Биномиальное':
            pyplot.step(distribution['cdf arguments'],
                        distribution['cdf'](distribution['cdf arguments']),
                        where='pre',
                        label='cdf')
        else:
            pyplot.plot(distribution['cdf arguments'],
                        distribution['cdf'](distribution['cdf arguments']),
                        label='cdf')
        pyplot.title(distribution['name'])
        pyplot.legend()
        pyplot.grid()


plot_empirical_functions([10, 10, 10])
pyplot.show()
plot_empirical_functions([10, 100, 1000])
pyplot.show()

# Задача 4
volume = 100
for distribution in distributions:
    # выборка
    sample = distribution['sample'](volume)
    # количества
    counts, _ = numpy.histogram(sample, bins=distribution['bins'])
    # частоты
    counts = counts / sample.size
    # середины и размеры отрезков разбиения
    center = (distribution['bins'][:-1] + distribution['bins'][1:])/2
    width = distribution['bins'][:-1] - distribution['bins'][1:]
    # рисунок
    pyplot.figure()
    pyplot.bar(center, counts, width)
    pyplot.title(distribution['name'])
    pyplot.grid()
pyplot.show()

# Задача 5
volume = 10000
for distribution in distributions:
    sample = distribution['sample'](volume)
    print(distribution['name'])
    moments = distribution['moments']
    print(f'1 начальный: {stats.moment(sample, order=1, center=0):.3f} - {moments[0]:.3f}')
    print(f'2 начальный: {stats.moment(sample, order=2, center=0):.3f} - {moments[1]+moments[0]**2:.3f}')
    print(f'2 центральный: {stats.moment(sample, order=2):.3f} - {moments[1]:.3f}')
    print(f'3 центральный: {stats.moment(sample, order=3):.3f} - {moments[2]*moments[1]:.3f}')