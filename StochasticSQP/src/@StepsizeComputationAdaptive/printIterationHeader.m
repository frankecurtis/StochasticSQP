% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StepsizeComputationAdaptive: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '    Stepsize  ');

end % printIterationHeader