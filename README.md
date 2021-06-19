StochasticSQP
=============

This software is under development.  Please check back later.

Overview
--------

StochasticSQP is a software package for solving optimization problems involving a stochastic objective and deterministic constraint functions.  (Problems with deterministic objective functions can also be solved, although the code has not been optimized for that purpose.)  At present, it is designed to locate a minimizer of

```
min     f(x) subject to c(x) = 0, with f(x) = E[F(x,ω)],
x ∈ Rⁿ
```

where ```f``` and ```c``` are continuously differentiable, ```ω``` is a random variable, and ```E[]``` denotes expectation with respect to the distribution of ```ω```.  Note that the expectation could be in the form of an average of a finite number of terms.  *Functionality for solving problems with inequality constraints is under development.*

StochasticSQP is written in Matlab.  The main author is [Frank E. Curtis](http://coral.ise.lehigh.edu/frankecurtis/).  For a list of all contributors, please see the [AUTHORS file](StochasticSQP/AUTHORS).

Citing StochasticSQP
--------------------

StochasticSQP is provided free of charge so that it might be useful to others.  Please send e-mail to [Frank E. Curtis](http://coral.ise.lehigh.edu/frankecurtis/) with success stories or other feedback.  If you use StochasticSQP in your research, then please cite the following paper:

- [Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, and Baoyu Zhou. "Sequential Quadratic Optimization for Nonlinear Equality Constrained Stochastic Optimization." *SIAM Journal on Optimization*. 31(2):1352–1379, 2021.](https://epubs.siam.org/doi/abs/10.1137/20M1354556)
