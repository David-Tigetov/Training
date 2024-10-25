import numpy
import chi

observed = numpy.array([110, 130, 70, 90, 100])
probabilities = numpy.array([1/5]*5)
chi.chi2_test(observed, probabilities)