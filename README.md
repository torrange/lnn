# LNN - Light Nearest Neighbour

This repository contains a tiny, lightweight implementation of the KNN algorithm
in Cython.

By passing a mean vector-representation of each target class (as opposed to a 
vector for each sample) the size of the input dataset is greatly reduced, as is
the classification time for unseen data. The accuracy will be lower than the KNN 
algorithm for datasets with a fewer number of samples, however, representations 
of much larger datasets can be handled by LNN, due to the fact the all samples of a
class are averaged and reduced onto to a single vector.


Currently, LNN only classifies data with continuous features from CSV data. Please see the example
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


