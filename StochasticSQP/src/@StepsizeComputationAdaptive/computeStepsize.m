% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Set scaling
stepsize_scaling = S.stepsize_scaling_;
if S.stepsize_diminishing_ == true
  stepsize_scaling = stepsize_scaling / quantities.iterationCounter;
end

% Compute preliminary values
denominator = (quantities.meritParameter * quantities.objectiveLipschitzConstants + quantities.constraintLipschitzConstants) * norm(quantities.directionPrimal)^2;
alpha_hat = stepsize_scaling * quantities.modelReduction / denominator;
alpha_tilde = alpha_hat - 4 * quantities.currentIterate.constraintNorm1 / denominator;

% Set projection bounds
lower_bound = stepsize_scaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * quantities.objectiveLipschitzConstants + quantities.constraintLipschitzConstants);
upper_bound = lower_bound + S.projection_width_ * stepsize_scaling^2;

% Project values
alpha_hat = max(lower_bound,min(alpha_hat,upper_bound));
alpha_tilde = max(lower_bound,min(alpha_tilde,upper_bound));

% Compute stepsize
if alpha_hat < 1.0
  alpha = alpha_hat;
elseif alpha_tilde <= 1.0
  alpha = 1;
else
  alpha = alpha_tilde;
end

% Set stepsize
quantities.setStepsize(alpha);

% Create trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize