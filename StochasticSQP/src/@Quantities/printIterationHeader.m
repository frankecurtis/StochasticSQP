% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Quantities: printIterationHeader
function printIterationHeader(Q,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' Iter.   Objective    |Constraint|     Merit    ');

end % printIterationHeader