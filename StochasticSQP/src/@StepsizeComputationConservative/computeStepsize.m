% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Set scaling
scaling = S.scaling_;
if S.diminishing_ == true
  scaling = scaling / (quantities.iterationCounter + 1);
end

% Compute stepsize
alpha = scaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint);

% Set stepsize
quantities.setStepsize(alpha);

% Create trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize