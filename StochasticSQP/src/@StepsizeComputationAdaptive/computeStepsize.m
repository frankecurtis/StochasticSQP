% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Check for small step
if norm(quantities.directionPrimal,inf) < S.direction_norm_tolerance_
  
  % Set full stepsize
  alpha = 1;
  
else
  
  % Set scaling
  scaling = S.scaling_;
  if S.diminishing_ == true
    scaling = scaling / (quantities.iterationCounter + 1);
  end
  
  % Compute stepsize denominator
  denominator = (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint) * norm(quantities.directionPrimal)^2;
  
  % Compute stepsize values
  alpha_suff = min(1, 2*(1 - S.sufficient_decrease_) * scaling * quantities.modelReduction / denominator);
  alpha_min = 2*(1 - S.sufficient_decrease_) * scaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint);
  alpha = min(alpha_suff, alpha_min);
  alpha_max = alpha_min + S.projection_width_ * scaling^2;
  
  % Check whether to lengthen
  if S.lengthening_
    
    % Loop while less than 1
    while alpha < alpha_max
      
      % Set trial stepsize
      alpha_trial = min(alpha_max, S.lengthening_ratio_ * alpha);
      
      % Evaluate reduction value
      reduction = alpha_trial * (S.sufficient_decrease_ - 1) * scaling * quantities.modelReduction ...
        + norm(quantities.currentIterate.constraintFunctionEqualities(quantities) + alpha_trial * quantities.currentIterate.constraintJacobianEqualities(quantities) * quantities.directionPrimal,1) ...
        - quantities.currentIterate.constraintNorm1(quantities) ...
        + alpha_trial * (quantities.currentIterate.constraintNorm1(quantities) - norm(quantities.residualFeasibility,1)) ...
        + 0.5 * alpha_trial^2 * denominator;
      
      % Check reduction
      if reduction > 0
        break;
      else
        alpha = alpha_trial;
        if alpha >= alpha_max
          break;
        end
      end
      
    end
    
    % Project stepsize
    alpha = max(alpha_min,min(alpha,alpha_max));
    
  end
  
end

% Set stepsize
quantities.setStepsize(alpha);

% Create trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize