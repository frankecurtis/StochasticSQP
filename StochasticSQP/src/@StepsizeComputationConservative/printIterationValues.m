% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StepsizeComputationConservative: printIterationValues
function printIterationValues(S,quantities,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,' %+e',quantities.stepsize);

end % printIterationValues