% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

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