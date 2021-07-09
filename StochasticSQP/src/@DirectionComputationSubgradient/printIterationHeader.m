% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationSubgradient: printIterationHeader
function printIterationHeader(D,reporter)

% Print full stochastic step information
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '  |Direction|   |Multiplier|   KKT Error  ');

% Print iteration header
if D.compute_true_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    '  |Dir. True|   |Mult. True|    KKT True   ');
end

end % printIterationHeader