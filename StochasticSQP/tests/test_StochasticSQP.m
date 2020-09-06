function test_StochasticSQP

% Add source code to path
addpath('../problems/');
addpath('../src/');
addpath('/usr/local/opt/cutest/libexec/src/matlab');

S = StochasticSQP;
P = ProblemSimple;
S.optimize(P);