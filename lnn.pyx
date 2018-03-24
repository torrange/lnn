from csv import reader as rdr
from libc.math cimport pow, sqrt


def load_dataset(path):
    rows = [r for r in rdr(open(path,'rb'))]

    dataset, targets = (
        [[float(x) for x in row[0:-1]] for row in rows][:-1],
        [row[-1:] for row in rows][:-1]
    )

    def compress_dataset(dataset, targets):
        cdef int i
        model = {}
        counts = {}

        for t, d in zip(targets, dataset):
            if t[0] not in model.keys():
                model[t[0]] = d
                counts[t[0]] = 1
            else:
                for i in xrange(len(d)):
                    model[t[0]][i] += d[i]
                counts[t[0]] += 1

        _model = {}

        for label in model.keys():
            data = model[label]
            for i in xrange(len(data)):
                data[i] = data[i] / float(counts[label])
            _model[label] = data

        targets = []
        dataset = []

        for t, d in _model.iteritems():
            targets.append([t])
            dataset.append(d)

        return dataset, targets

    return compress_dataset(dataset, targets)


cdef magnitude(list a, list b):
    cdef float x, y, distance

    distance = 0.0

    for x, y in zip(a,b):
        distance += pow(x-y, 2)

    distance = sqrt(distance)

    return distance


def classify(vector, dataset, outputs):
    if not (vector and dataset and outputs):
        raise ValueError("input data must not be empty")

    if not (len(vector) == len(dataset[0]) and 
            len(dataset) == len(outputs)):
        raise TypeError("data shape must be consistent")

    cdef int i
    indexes = [i for i in xrange(len(dataset))]
    distances = [magnitude(vector, x) for x in dataset]
    i = distances.index(min(distances))

    return outputs[i]
