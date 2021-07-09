% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Strategies: printIterationValues
function printIterationValues(L,quantities,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' %+e %+e',...
  quantities.lipschitzObjective,...
  quantities.lipschitzConstraint);

end % printIterationValues