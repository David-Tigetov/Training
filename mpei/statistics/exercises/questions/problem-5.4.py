import numpy
import chi
from scipy import stats

volume = 600
observed = numpy.array([75, volume-75])
chi.chi2_test(observed, numpy.array([1/6, 5/6]))
print(f'Threshold: {stats.chi2.ppf(1-0.05, df=1):.5f}')
