% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQP: computeDirection
function computeDirection(D,options,quantities,reporter,strategies)

% Compute direction
v = -[eye(quantities.currentIterate.numberOfVariables) quantities.currentIterate.constraintJacobian(quantities)';
  quantities.currentIterate.constraintJacobian(quantities) zeros(quantities.currentIterate.numberOfConstraints,quantities.currentIterate.numberOfConstraints)] \ ...
  [quantities.currentIterate.objectiveGradient(quantities);
  quantities.currentIterate.constraintFunction(quantities)];

% Set direction
quantities.setDirection(v(1:quantities.currentIterate.numberOfVariables));

% Set multiplier
quantities.setMultiplier(v(quantities.currentIterate.numberOfVariables+1:end));

end % computeDirection