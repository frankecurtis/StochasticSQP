% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Quantities: printIterationHeader
function printIterationHeader(Q,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' Iter.   Objective    |Constraint|     Merit    ');

end % printIterationHeader