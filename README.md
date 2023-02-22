# LNN - Light Nearest Neighbour


Light Nearest Neighbour is a clustering algorithm for classification purposes, written in Cython. It works by compressing the input data into a set of cluster centers, where each center represents the mean of the data points assigned to that cluster.

Compared to KNN, this algorithm is _much_ faster as it only needs to compute distances between the input vector and the cluster centers. However, on small to medium-size datasets it may not be as accurate as KNN as it ignores the majority class of the nearest neighbors. For large datasets where the KNN algorithm becomes computationally expensive, or when the input data has many irrelevant features that can be compressed into a smaller set of features, this algorithm is preferable.

## About this library

The `load_dataset` function reads in a CSV file and returns the compressed dataset and targets. The `compress_dataset` function clusters the data points by their target label, and replaces each cluster with its mean value.

The `classify` function takes in a data point (vector), the compressed dataset, and the target labels, and returns the target label of the closest cluster center. The distance between the vector and each cluster center is calculated using the magnitude function, which computes the Euclidean distance between two vectors.




Currently, LNN only classifies data with _continuous_ features from CSV data, including Ordinal categorical features (if they have been encoded).Please see the example dataset located in:
in `data/iris.csv`.
 

## Building LNN 

### Prerequisites

- Make/CMake
- GCC
- Cython
- Python 2.7

### Building Module

From the project root:

1. `python setup.py build_ext --inplace`

### Using LNN
The resulting `LNN.so` file from the build step can now be imported and used as any other Python
module.

```
[In][1] from LNN import load_dataset, classify

[In][2] dataset, targets = load_dataset('data/iris.csv')

[In][3] vector = [5.3, 2.2, 5.4, 7.9]

[In][4] classify(vector, dataset, targets)
[Out][4] ['Iris-virginica']

```

### TODO

Python 2.7 has been deprecated for some time now, and this library will be replaced with a Python3 implementation soon-ish. A Go, Rust and C implementation will likely be provided down the line too.


