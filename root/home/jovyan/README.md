# Fibertree Emulation Environment

This Jupyter environment provides the code and examples of the
emulation of actions involving **fibertrees**. The **fibertree**
abstraction is a representation-agnostic way of thinking about sparse
and dense tensors and the operators that manipulate those tensors. By
**representation agnostic** we mean a generic representation of a
tensor that is independent of the specifics of a particular in-memory
format, such as CSR or CSF. Thus although the costs of operations will
be a function of the specific representation, one can think of the
operations on them generically. Thus, using this representation one
can explore the algorithmic processing and operations uses by various
accelerator architectures. More background on this abstraction for
representing tensors can be found sections 8.2 and 8.3 of the book
[Efficient Processing of Deep Neural
Networks](https://tinyurl.com/EfficientDNNBook).

A table of content for the various notebooks can be found [here](./fibertree-notebooks/notebooks/start-here.ipynb)
or you can just start with the [basic tutorial](./fibertree-notebooks/notebooks/basic/fibertree.ipynb) notebook.

The container-based directories here are:

- [Fibertree notebooks](./fibertree-notebooks/notebooks) - A copy of the fibertree-notebooks fibertree git repository

- [Fibertree source](./src/fibertree) - A copy of the fibertree git repository

- [Fibertree documentation - core](./doc/fibertree/core/index.html) - Fibertree core library documentation

- [Fibertree documentation - graphics](./doc/fibertree/graphics/index.html) - Fibertree graphics library documentation

Other directories here have probably been mounted as volumes in the container.

