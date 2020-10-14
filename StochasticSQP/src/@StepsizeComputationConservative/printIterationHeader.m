% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '    Stepsize  ');

end % printIterationHeader