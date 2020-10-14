% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Set scaling
stepsize_scaling = S.stepsize_scaling_;
if S.stepsize_diminishing_ == true
  stepsize_scaling = stepsize_scaling / quantities.iterationCounter;
end

% Compute stepsize
alpha = stepsize_scaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * S.objective_Lipschitz_ + S.constraint_Lipschitz_);

% Set stepsize
quantities.setStepsize(alpha);

% Create trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize