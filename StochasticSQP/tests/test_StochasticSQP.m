% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

function test_StochasticSQP

% Add source code to path
addpath('../problems/');
addpath('../src/');
addpath('../external');

% Declare algorithm
S = StochasticSQP;

% Declare problem
P = ProblemSimple;

% Optimize
S.optimize(P);