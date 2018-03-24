from distutils.core import setup
from Cython.Build import cythonize

module = 'LNN'

setup(
  name = module,
  ext_modules = cythonize("%s.pyx" % module),
)
