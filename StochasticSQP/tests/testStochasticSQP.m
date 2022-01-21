% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

function testStochasticSQP

% Add source code to path
addpath('../problems/');
addpath('../src/');
addpath('/usr/local/opt/cutest/libexec/src/matlab');
addpath('../../external');

% Declare algorithm
S = StochasticSQP;

% Declare problem
P = ProblemCUTEst;

% Optimize
S.optimize(P);