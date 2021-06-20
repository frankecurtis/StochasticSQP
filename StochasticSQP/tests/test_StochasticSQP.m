function test_StochasticSQP

% Add source code to path
addpath('../problems/');
addpath('../src/');
addpath('/usr/local/opt/cutest/libexec/src/matlab');

% Declare algorithm
S = StochasticSQP;

% Declare problem
P = ProblemSimple;

% Optimize
S.optimize(P);