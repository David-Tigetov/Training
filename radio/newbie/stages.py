import numpy
import math
import matplotlib.pyplot as pyplot

VOLUME = 50

# формируем полярные координаты
generator = numpy.random.default_rng()
radia = generator.normal(loc=math.sqrt(5**2 + 2**2), scale=0.2, size=VOLUME)
angles = generator.normal(loc=math.radians(22), scale=0.075, size=VOLUME)

# вычисляем декартовы координаты
x = [p[0]*math.cos(p[1]) for p in zip(radia, angles)]
y = [p[0]*math.sin(p[1]) for p in zip(radia, angles)]

# рисуем точки
pyplot.figure()
pyplot.scatter(x, y)
pyplot.axis('equal')
pyplot.show()

# выводим команды
for p in zip(x, y):
    print(f'\\filldraw [magenta#1] ({p[0]:5.3f}, {p[1]:5.3f}) circle (1pt);')
