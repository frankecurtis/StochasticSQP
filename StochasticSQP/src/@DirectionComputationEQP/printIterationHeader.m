% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP: printIterationHeader
function printIterationHeader(D,reporter)

% Print normal step header?
if D.decompose_step_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    '   |Normal|   N. Lin. Inf.');
end

% Print termination test header
if D.use_iterative_solver_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    ' TT  MINRES ');
end

% Print full stochastic step information
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '  |Sys. Res.|   |Direction|   |Multiplier|   KKT Error     Lin. Inf.  ');

% Print iteration header
if D.compute_true_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    '  |Dir. True|   |Mult. True|    KKT True     Lin. Inf.  ');
end

end % printIterationHeader