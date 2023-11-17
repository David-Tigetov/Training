class Sequence :
    A = 17
    B = 11
    C = 33

    def __init__(self, a):
        self.a = a

    def random(self):
        self.a = (self.A*self.a + self.B) % self.C
        return  self.a

sequence = Sequence(7)
print([sequence.random() for _ in range(5)])

import numpy
generator = numpy.random.default_rng()
sample = generator.normal(loc=2.5, scale=3.0, size=10)
print(sample)
