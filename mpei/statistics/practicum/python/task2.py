import numpy

generator = numpy.random.default_rng()
sample = generator.normal(loc=2.5, scale=3.0, size=10)
print(f'Mean: {sample.mean()}, Std: {sample.std()}')

moment = numpy.sqrt(numpy.sum(numpy.power(sample, 3))/sample.size)
print(moment)

print(numpy.histogram(sample, bins=20, density=True))

import pandas
series = pandas.Series(sample)
print(series.agg(['min', 'max', 'mean', 'std']))

import matplotlib.pyplot as pyplot

# диаграмма размаха
pyplot.figure()
pyplot.boxplot(sample, vert=False)
pyplot.grid()
pyplot.show()

# гистограмма
pyplot.figure()
pyplot.hist(sample, bins=20, density=True, cumulative=True)
pyplot.grid()
pyplot.show()


# # гистограмма
# pyplot.figure()
# #series.plot.kde()
# series.plot.hist(density=True, bins=20)
# #pyplot.grid()
# pyplot.show()

# ЭФР
sorted = sample
sorted.sort()
sorted = numpy.append(sorted, sorted[-1]+1)
print(sorted)
increments = numpy.array(range(0,sorted.size))
increments = increments / (sorted.size-1)
pyplot.figure()
pyplot.step(sorted, increments)
pyplot.grid()
pyplot.show()

# Отрезки, ступеньки, маркеры
x = [1, 2.2, 3]
y = [0, 0.3, 1]
pyplot.figure()
pyplot.subplot(311)
pyplot.plot(x, y, color='red')
pyplot.title('Line')
pyplot.grid()
pyplot.subplot(312)
pyplot.step(x, y)
pyplot.title('Steps')
pyplot.grid()
pyplot.subplot(313)
pyplot.scatter(x, y, color='green', s=100, marker='^')
pyplot.title('Markers')
pyplot.grid()
pyplot.show()
