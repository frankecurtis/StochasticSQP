% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Stochastic SQP: printFooter
function printFooter(S)

% Get global variables
global R_SOLVER R_PER_ITERATION

% Print software name
S.reporter.printf(R_SOLVER,R_PER_ITERATION,'add stuff to printFooter!\n');

end
