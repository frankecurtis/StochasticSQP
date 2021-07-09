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

StochasticSQP is written in Matlab.  The main authors are [Albert S. Berahas](https://aberahas.engin.umich.edu/), [Frank E. Curtis](http://coral.ise.lehigh.edu/frankecurtis/), [Daniel P. Robinson](https://coral.ise.lehigh.edu/danielprobinson/), and [Baoyu Zhou](https://coral.ise.lehigh.edu/baz216/).  For a list of all contributors, please see the [AUTHORS file](StochasticSQP/AUTHORS).

Citing StochasticSQP
--------------------

StochasticSQP is provided free of charge so that it might be useful to others.  Please send e-mail to [Albert S. Berahas](mailto:albertberahas@gmail.com), [Frank E. Curtis](mailto:frank.e.curtis@lehigh.edu), [Daniel P. Robinson](mailto:daniel.p.robinson@lehigh.edu), and [Baoyu Zhou](mailto:baz216@lehigh.edu) with success stories or other feedback.  If you use StochasticSQP in your research, then please cite the following papers:

- [Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, and Baoyu Zhou. "Sequential Quadratic Optimization for Nonlinear Equality Constrained Stochastic Optimization." *SIAM Journal on Optimization*. 31(2):1352–1379, 2021.](https://epubs.siam.org/doi/abs/10.1137/20M1354556)
- [Albert S. Berahas, Frank E. Curtis, Michael J. O'Neill, and Daniel P. Robinson.  "A Stochastic Sequential Quadratic Optimization Algorithm for Nonlinear Equality Constrained Optimization with Rank-Deficient Jacobians." arXiv preprint 2106.13015, 2021.](https://arxiv.org/abs/2106.13015)
- [Frank E. Curtis, Daniel P. Robinson, and Baoyu Zhou.  "Inexact Sequential Quadratic Optimization for Minimizing a Stochastic Objective Function Subject to Deterministic Nonlinear Equality Constraints." arxiv preprint 2107.03512, 2021.](https://arxiv.org/abs/2107.03512)