% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationSubgradient: printIterationValues
function printIterationValues(D,quantities,reporter)

% Print full stochastic step information
[yE,yI] = quantities.currentIterate.multipliers('stochastic');
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' %+e %+e %+e',...
  norm(quantities.directionPrimal('full'),inf),...
  norm([yE;yI],inf),...
  quantities.currentIterate.KKTError(quantities,'stochastic'));

% Print full true step information?
if D.compute_true_
  [yE_true,yI_true] = quantities.currentIterate.multipliers('true');
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    ' %+e %+e %+e',...
    norm(quantities.directionPrimal('true'),inf),...
    norm([yE_true;yI_true],inf),...
    quantities.currentIterate.KKTError(quantities,'true'));
end

end % printIterationValues