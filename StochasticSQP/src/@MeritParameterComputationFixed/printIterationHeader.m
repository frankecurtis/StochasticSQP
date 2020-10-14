% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Strategies: printIterationHeader
function printIterationHeader(M,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '  Merit Param.  Ratio Param.');

end % printIterationHeader