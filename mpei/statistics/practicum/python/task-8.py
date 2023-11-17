import numpy
from sklearn.linear_model import LinearRegression

generator = numpy.random.default_rng()
regressor = numpy.array(
    [-1.8, -1.3, -0.35, -0.1, 0.8, 1.45, 2.8, 3.7, 4.2, 4.9])
errors = generator.uniform(-0.5, 0.5, size=10)
response = 3-0.5*regressor+errors
regressor = regressor.reshape(-1,1)
model = LinearRegression().fit(regressor, response)
R2 = model.score(regressor, response)
print(f'intercept: {model.intercept_}, slope: {model.coef_}, R2: {R2}')

import numpy
import statsmodels.api

generator = numpy.random.default_rng()
regressor = numpy.array(
    [-1.8, -1.3, -0.35, -0.1, 0.8, 1.45, 2.8, 3.7, 4.2, 4.9])
errors = generator.uniform(-0.5, 0.5, size=10)
response = 3 - 0.5*regressor + errors
constant = numpy.array([1]*10)
first = regressor
second = numpy.square(regressor)
plan = numpy.array([constant, first, second]).T
model = statsmodels.api.OLS(response, plan)
results = model.fit()
print(results.summary())
