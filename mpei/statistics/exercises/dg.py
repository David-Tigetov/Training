import numpy
import math
from scipy import stats
from functools import reduce

class Chi_squared:
    def __init__(self, observed, probabilities, parameter=0):
        # наблюдаемые количества
        self.observed = observed
        # вероятности
        self.probabilities = probabilities
        # объём
        self.volume = observed.sum()
        # ожидаемые количества
        self.expected = probabilities * self.volume
        # отклонения
        self.deviations = (observed - self.expected)**2 / self.expected
        # статистика
        self.statistic = self.deviations.sum()
        # количество степеней свободы
        self.freedom = observed.shape[0] - 1 - parameter
        # уровень значимости
        self.p_value = 1 - stats.chi2.cdf(self.statistic, df=self.freedom)

    def __str__(self):
        # таблица
        output = '*** Chi-squared Test ***\n'
        output += f'{"Observed":>10} & {"Probability":>15} & {"Expected":>10} & {"Deviation":>10}\n'
        for row in range(self.observed.shape[0]):
            output += f'{self.observed[row]:10} & {self.probabilities[row]:15.3f} & {self.expected[row]:10.3f} & {self.deviations[row]:10.3f} \\\\\n'
        output += f'{self.volume:10} & {self.probabilities.sum():15.3f} & {"":10} & {self.statistic:10.3f} \\\\\n'
        # вывод
        output += f'{"Freedom:":12}{self.freedom}\n'
        output += f'{"P-value:":12}{self.p_value:.5f}'
        return output

class Chi_homogeneity:
    def __init__(self, observed):
        self.observed = observed
        # количество
        self.counts = numpy.sum(observed, axis=1)
        self.volume = numpy.sum(self.counts)
        # оценки вероятностей
        self.estimates = numpy.sum(observed, axis=0) / self.volume

        # ожидаемые количества
        self.expected = numpy.outer(self.counts, self.estimates)
        # отклонения
        self.deviations = (self.observed - self.expected)**2 / self.expected
        # статистика
        self.statistic = numpy.sum(numpy.sum(self.deviations))
        # уровень значимости
        self.p_value = 1 - stats.chi2.cdf(self.statistic, df=(observed.shape[0]-1)*(observed.shape[1]-1))

    def __str__(self):
        # ожидаемое количество
        output = f'{"Volume:":12}{self.volume}\n'
        output = f'{"Estimates:":12}' + str(self.estimates) + '\n'
        # таблица ожидаемых количеств и отклонений
        for row in range(self.expected.shape[0]):
            line = ''
            for column in range(self.expected.shape[1]):
                if column > 0:
                    line += ' & '
                line += f'{self.observed[row, column]:5g}{self.expected[row, column]:10.3f}{self.deviations[row, column]:10.3f}'
            line += ' \\\\'
            output += line + '\n'
        # статистика
        output += f'{"Statictic:":12}{self.statistic}\n'
        output += f'{"P-value:":12}{self.p_value}'
        return output


def advance(sample, count, predicate):
    next = True
    while next:
        # если есть следующий элемент
        if count < sample.shape[0]:
            # если следующий элемент удовлетворяет условию
            if predicate(sample[count]):
                count += 1
            else:
                next = False
        else:
            next = False
    return count


class Kolmogorov:
    def __init__(self, sample, cdf):
        # реализация вариационного ряда
        sample.sort()
        # точки
        self.locations = numpy.unique(sample)
        self.locations.sort()
        # значения функции распределения
        self.cdfs = cdf(self.locations)
        # вычисляем значения эмпирической функции распределения
        self.left_ecdfs = numpy.array([float(0.0)]*self.locations.shape[0])
        self.right_ecdfs = numpy.array([float(0.0)]*self.locations.shape[0])
        count = 0
        for number in range(self.locations.shape[0]):
            # значение слева эмпирической функции распределения
            self.left_ecdfs[number] = count/sample.shape[0]
            # предел справа эмпирической функции распределения
            count = advance(sample, count, lambda x: x <= self.locations[number])
            self.right_ecdfs[number] = count/sample.shape[0]

        # отклонения
        self.left_deviations = self.left_ecdfs - self.cdfs
        self.right_deviations = self.right_ecdfs - self.cdfs
        # определяем наибольшее отклонение
        maxima = numpy.maximum(numpy.abs(self.left_deviations), numpy.abs(self.right_deviations))
        position = numpy.argmax(maxima)
        self.deviation = maxima[position]
        self.location = self.locations[position]
        # значение статистики
        self.statistic = numpy.sqrt(sample.shape[0]) * self.deviation
        # уровень значимости - точное распределение
        self.p_value = 1 - stats.kstwo.cdf(self.deviation, sample.shape[0])
        # уровень значимости - предельное распределение
        self.p_value_limit = 1 - stats.kstwobign.cdf(self.statistic)

    def __repr__(self):
        return f'Kolmogorov: deviation {self.deviation:.5f}, location {self.location:.5f}, statistic {self.statistic:.5f}, p-value {self.p_value:.5f}, p-value-limit {self.p_value_limit:.5f}'

    def __str__(self):
        output = '*** Kolmogorov Test ***\n'
        for number in range(self.locations.shape[0]):
            output += f'{self.locations[number]:8.3f} & {self.cdfs[number]:10.5f} & {self.left_ecdfs[number]:10.5f} & {self.left_deviations[number]:10.5f} & {self.right_ecdfs[number]:10.5f} & {self.right_deviations[number]:10.5f} \\\\\n'
        output += f'{"Deviation:":20}{self.deviation:12.10f}\n'
        output += f'{"Location:":20}{self.location:12.10f}\n'
        output += f'{"Statistic:":20}{self.statistic:12.10f}\n'
        output += f'{"P-value:":20}{self.p_value:12.10f}\n'
        output += f'{"P-value (limit):":20}{self.p_value_limit:12.10f}'
        return output

class Kolmogorov_Smirnov:
    def __init__(self, f_sample, g_sample):
        # реализации вариационных рядов
        f_sample.sort()
        g_sample.sort()
        # эмпирические функции в промежутках
        f_ecdfs = numpy.linspace(0, 1, f_sample.shape[0]+1)
        g_ecdfs = numpy.linspace(0, 1, g_sample.shape[0]+1)
        g_number= 0
        f_number= 0
        # объединённый набор
        self.locations = numpy.hstack((f_sample, g_sample))
        self.locations = numpy.unique(self.locations)
        self.locations.sort()
        self.f_ecdfs = numpy.array([float(0.0)]*self.locations.shape[0])
        self.g_ecdfs = numpy.array([float(0.0)]*self.locations.shape[0])
        for number in range(self.locations.shape[0]):
            # смещаемся по первой реализации
            f_count = advance(f_sample, f_number, lambda x: x < self.locations[number])
            self.f_ecdfs[number] = f_ecdfs[f_count]
            # смещаемся по второй реализации
            g_count = advance(g_sample, g_number, lambda x: x < self.locations[number])
            self.g_ecdfs[number] = g_ecdfs[g_count]
        # отклонение слева - разность значений
        self.deviations = self.f_ecdfs - self.g_ecdfs
        absolute = numpy.abs(self.deviations)
        position = numpy.argmax(absolute)
        self.deviation = absolute[position]
        self.location = self.locations[position]
        # значение статистики
        self.statistic = \
            numpy.sqrt(f_sample.shape[0]*g_sample.shape[0] /
                    (f_sample.shape[0] + g_sample.shape[0])) * self.deviation
        # уровень значимости - предельное распределение
        self.p_value_limit = 1 - stats.kstwobign.cdf(self.statistic)

    def __str__(self):
        output = '*** Kolmogorov-Smirnov Test ***\n'
        for number in range(self.locations.shape[0]):
            output += f'{self.locations[number]:8.3f} & {self.f_ecdfs[number]:10.5f} & {self.g_ecdfs[number]:10.5f} & {self.deviations[number]:10.5f} \\\\\n'
        output += f'{"Deviation:":20}{self.deviation:12.10f}\n'
        output += f'{"Location:":20}{self.location:12.10f}\n'
        output += f'{"Statistic:":20}{self.statistic:12.10f}\n'
        output += f'{"P-value (limit):":20}{self.p_value_limit:12.10f}'
        return output

def unroll(values, separator='', ending=''):
    return reduce(lambda s, e: s + separator + f'{e:.5f}', values[1:], f'{values[0]:.5f}') + ending

class Regression:
    def __init__(self, e, Z, W):
        self.n, self.m = Z.shape
        # нормальная система
        self.G = Regression.dot(Z, Z, W)
        self.s = Regression.dot(Z, e, W)
        # оценка по методу наименьших квадратов
        self.estimate = numpy.linalg.solve(self.G, self.s)
        # проекция на линейную оболочку
        self.e_Z = numpy.matmul(Z, self.estimate)
        self.e_Z_norm = math.sqrt(Regression.squared_norm(self.e_Z, W)[0, 0])
        # проекция на ортогональное дополнение линейной оболочки
        self.e_Zp = e - self.e_Z
        self.e_Zp_norm = math.sqrt(Regression.squared_norm(self.e_Zp, W)[0, 0])
        # с.к.о. остатков
        self.error = self.e_Zp_norm / math.sqrt((self.n - self.m))

        # регрессия с константой
        U = numpy.ones((self.n, 1))
        self.U_mean = (Regression.dot(U, e, W) / Regression.squared_norm(U, W))[0, 0]
        self.e_Up = e - U * self.U_mean
        self.e_Up_norm = math.sqrt(Regression.squared_norm(self.e_Up, W)[0, 0])
        # коэффициент детерминации
        self.R = 1 - self.e_Zp_norm**2 / self.e_Up_norm**2
        # скорректированный коэффициент детерминации
        self.R_adjusted = 1 - (self.n - 1)/(self.n - self.m) * self.e_Zp_norm**2 / self.e_Up_norm**2

        # ковариационная матрица оценок
        self.G_inv = numpy.linalg.inv(self.G)
        # отступы доверительных интервалов
        self.estimate_spreads = numpy.transpose(numpy.array([[*numpy.sqrt(numpy.diagonal(self.G_inv) * self.e_Zp_norm**2 / ( self.n - self.m ))]]))

        # статистика критерия об отсутствии зависимости
        self.F = (self.n - self.m)/self.m * self.e_Z_norm**2 / self.e_Zp_norm**2
        # наименьший уровень значимости принятия гипотезы об отсутствии зависимости
        self.F_pvalue = 1 - stats.f.cdf(self.F, dfn = self.m, dfd = self.n - self.m)

    def dot(x, y, W):
        return numpy.matmul(numpy.transpose(x), numpy.matmul(W, y))

    def squared_norm(x, W):
        return Regression.dot(x, x, W)

    def estimate_confidence(self, alpha):
        quantile = stats.t.ppf((1+alpha)/2, df = self.n - self.m)
        spreads = quantile * self.estimate_spreads
        return quantile, spreads, numpy.hstack([self.estimate - spreads, self.estimate + spreads])

    def error_confidence(self, alpha):
        quantiles = stats.chi2.ppf([(1+alpha)/2, (1-alpha)/2], df = self.n - self.m)
        return quantiles, numpy.sqrt(numpy.array(self.e_Zp_norm**2 / quantiles))

    def __str__(self):
        output = "Normal system:\n"
        for row in range(self.m):
            output += unroll(self.G[row], ' ') + ' = ' + f'{self.s[row,0]:.5f}' + '\n'
        output += f'{"Estimates":15}' + '(' + unroll(*numpy.transpose(self.estimate), ', ') + ')\n'
        output += '***\n'
        output += f'{"e_Z norm:":15}{self.e_Z_norm:.5f}\n'
        output += f'{"e_Zp norm:":15}{self.e_Zp_norm:.5f}\n'
        output += f'{"n - m:":15}{self.n} - {self.m} = {self.n - self.m}\n'
        output += f'{"Error:":15}{self.error:.5f}\n'
        output += '***\n'
        output += f'{"U mean:":15}{self.U_mean:.5f}\n'
        output += f'{"e_Up norm:":15}{self.e_Up_norm:.5f}\n'
        output += f'{"R:":15}{self.R:.5f}\n'
        output += f'{"R adj.:":15}{self.R_adjusted:.5f}\n'
        output += '***\n'
        output += f'{"F stat.:":15}{self.F:.5f}\n'
        output += f'{"F p-value.:":15}{self.F_pvalue:.5f}\n'
        return output