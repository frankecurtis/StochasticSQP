function test_StochasticSQP

% Add source code to path
addpath('../src/');

S = StochasticSQP;
P = Problem;
S.optimize(P);