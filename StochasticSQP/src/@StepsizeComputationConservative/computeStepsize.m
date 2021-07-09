% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StepsizeComputationConservative: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Compute stepsize
if quantities.curvatureIndicator
  alpha = quantities.stepsizeScaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint);
else
  alpha = quantities.stepsizeScaling * quantities.ratioParameter / (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint);
end

% Set stepsize
quantities.setStepsize(alpha);

% Create trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal('full'));

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize