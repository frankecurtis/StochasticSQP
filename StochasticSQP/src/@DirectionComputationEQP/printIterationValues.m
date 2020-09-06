% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQP: printIterationValues
function printIterationValues(S,quantities,reporter)

% Print information
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' %+e %+e %+e',...
  norm(quantities.direction,inf),...
  norm(quantities.multiplier,inf),...
  quantities.currentIterate.stationarityMeasure(quantities,quantities.multiplier));

end % printIterationValues