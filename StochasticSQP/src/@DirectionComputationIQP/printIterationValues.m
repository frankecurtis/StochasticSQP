% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP: printIterationValues
function printIterationValues(D,quantities,reporter)

% Print normal step information?
if D.decompose_step_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    ' %e %e',...
    norm(quantities.directionPrimal('normal'),inf),...
    norm(quantities.residualFeasibility('normal'),inf));
end

% Print termination test information
if D.use_iterative_solver_
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    ' %2d %8d',...
    quantities.terminationTest,...
    quantities.MINRESIterationCounter);
end

% Print full stochastic step information
[yE,yI] = quantities.currentIterate.multipliers('stochastic');
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' %+e %+e %+e %+e',...
  norm(quantities.directionPrimal('full'),inf),...
  norm([yE;yI],inf),...
  quantities.currentIterate.KKTError(quantities,'stochastic'),...
  norm(quantities.residualFeasibility('full'),inf));


% Print full true step information?
if D.compute_true_
  [yE_true,yI_true] = quantities.currentIterate.multipliers('true');
  reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
    ' %+e %+e %+e %+e',...
    norm(quantities.directionPrimal('true'),inf),...
    norm([yE_true;yI_true],inf),...
    quantities.currentIterate.KKTError(quantities,'true'),...
    norm(quantities.residualFeasibility('true'),inf));
end

end % printIterationValues