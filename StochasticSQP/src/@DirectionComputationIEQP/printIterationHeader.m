% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationIEQP: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' |InnerIter|    |Direction|   |Multiplier|  |KKT Error|  |KKT TR Err|  |TTnum|  |Primal Res|  |Dual Res|   ');

end % printIterationHeader