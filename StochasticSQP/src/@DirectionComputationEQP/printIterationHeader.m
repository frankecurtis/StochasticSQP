% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQP: printIterationHeader
function printIterationHeader(D,reporter)

% Print normal step header?
if D.decompose_step_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    '   |Normal|   N. Lin. Inf.');
end

% Print full stochastic step information
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '  |Direction|   |Multiplier|   KKT Error     Lin. Inf.  ');

% Print iteration header
if D.compute_true_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    '  |Dir. True|   |Mult. True|    KKT True     Lin. Inf.  ');
end

end % printIterationHeader