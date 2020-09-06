% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Strategies: printIterationValues
function printIterationValues(M,quantities,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' %+e %+e',...
  quantities.meritParameter,...
  quantities.modelReduction);

end % printIterationValues