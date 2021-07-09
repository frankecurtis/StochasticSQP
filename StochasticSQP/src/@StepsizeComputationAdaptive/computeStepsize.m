% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StepsizeComputationAdaptive: computeStepsize
function computeStepsize(S,options,quantities,reporter,strategies)

% Check for small step
if norm(quantities.directionPrimal('full'),inf) < S.direction_norm_tolerance_
  
  % Set full stepsize
  alpha = 1;
  
else
  
  % Compute stepsize denominator
  denominator = (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint) * norm(quantities.directionPrimal('full'))^2;
  
  % Compute stepsize for "sufficient decrease"
  alpha_suff = min(1, 2*(1 - S.sufficient_decrease_) * quantities.stepsizeScaling * quantities.modelReduction / denominator);
  
  % Compute lower and upper bounds
  if quantities.curvatureIndicator
    alpha_min = 2*(1 - S.sufficient_decrease_) * quantities.stepsizeScaling * quantities.ratioParameter * quantities.meritParameter / (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint);
  else
    alpha_min = 2*(1 - S.sufficient_decrease_) * quantities.stepsizeScaling * quantities.ratioParameter / (quantities.meritParameter * quantities.lipschitzObjective + quantities.lipschitzConstraint);
  end
  alpha_max = alpha_min + S.projection_width_ * quantities.stepsizeScaling^2;
  
  % Compute stepsize
  alpha = min(alpha_suff, alpha_min);
  
  % Check whether to lengthen
  if S.lengthening_
    
    % Loop while less than 1
    while alpha < alpha_max
      
      % Set trial stepsize
      alpha_trial = min(alpha_max, S.lengthening_ratio_ * alpha);
      
      % Evaluate reduction value
      reduction = alpha_trial * (S.sufficient_decrease_ - 1) * quantities.stepsizeScaling * quantities.modelReduction ...
        + norm(quantities.currentIterate.constraintFunctionEqualities(quantities) + alpha_trial * quantities.currentIterate.constraintJacobianEqualities(quantities) * quantities.directionPrimal('full'),1) ...
        - quantities.currentIterate.constraintNorm1(quantities) ...
        + alpha_trial * (quantities.currentIterate.constraintNorm1(quantities) - norm(quantities.residualFeasibility('full'),1)) ...
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
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + quantities.stepsize * quantities.directionPrimal('full'));

% Set trial iterate
quantities.setTrialIterate(trial_iterate);

end % computeStepsize