% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Compute preliminary values
denominator = (quantities.meritParameter * S.objective_Lipschitz_ + S.constraint_Lipschitz_) * norm(quantities.direction)^2;
alpha_hat = 2 * (1 - S.sufficient_decrease_) * quantities.modelReduction / denominator;
alpha_tilde = alpha_hat - 4 * quantities.currentIterate.constraintNorm1 / denominator;

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
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.direction);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize