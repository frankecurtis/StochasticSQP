% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationFixed: printIterationHeader
function printIterationHeader(P,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '  Curv. Param. Decom. Param. C?  Merit Param.  Ratio Param.');

end % printIterationHeader