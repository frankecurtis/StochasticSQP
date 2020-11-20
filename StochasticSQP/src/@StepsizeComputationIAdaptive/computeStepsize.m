% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationIAdaptive: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Set scaling
stepsize_scaling = S.stepsize_scaling_;
if S.stepsize_diminishing_ == true
  stepsize_scaling = stepsize_scaling / quantities.iterationCounter;
end

%%%%%%%%%%%%
% Add new adaptive stepsize policy here...
%%%%%%%%%%%%

% Check whether primal space update being zero or not
if norm(quantities.directionPrimal,inf) < 1e-16
    
    alpha = 1;
    
else
    
    % Compute preliminary values
    denominator = (quantities.meritParameter * quantities.objectiveLipschitzConstants + quantities.constraintLipschitzConstants) * norm(quantities.directionPrimal)^2;
    alpha_hat = stepsize_scaling * quantities.modelReduction / denominator;
    alpha_tilde = alpha_hat - 2 * quantities.currentIterate.constraintNorm1 / denominator;
    alpha_opt = max(min(alpha_hat,1) , alpha_tilde);
    alpha_1 = min(min(alpha_opt,1) , 2 * (1 - S.sufficient_decrease_) * stepsize_scaling * quantities.modelReduction / denominator);
    
    % Set projection bounds
    lower_bound = 2 * (1 - S.sufficient_decrease_) * stepsize_scaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * quantities.objectiveLipschitzConstants + quantities.constraintLipschitzConstants);
    upper_bound = lower_bound + S.projection_width_ * stepsize_scaling^2;
    
    % Project values
    alpha = max(lower_bound,min(alpha_1,upper_bound));
    
end

% Set stepsize
quantities.setStepsize(alpha);

% Create trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize