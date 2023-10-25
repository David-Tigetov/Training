import numpy
from sklearn.linear_model import LinearRegression

generator = numpy.random.default_rng()
regressor = generator.uniform(-2, 5, size=10)
errors = generator.uniform(-0.5, 0.5, size=10)
response = 3-0.5*regressor+errors
model = LinearRegression().fit(regressor, response)
