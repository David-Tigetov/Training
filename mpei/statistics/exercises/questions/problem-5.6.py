import numpy
import chi

volume = 50
observed = numpy.array([20, volume-20])
probabilities = numpy.array([1/2, 1/2])
chi.chi2_test(observed, probabilities)
