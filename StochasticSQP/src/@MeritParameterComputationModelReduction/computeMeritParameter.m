% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: computeMeritParameter
function computeMeritParameter(M,options,quantities,reporter,strategies)

% Compute objective model value
objective_model_value = quantities.currentIterate.objectiveGradient'*quantities.direction + ...
  (1/2)*max(quantities.direction' * quantities.direction,...
  M.curvature_threshold_ * norm(quantities.direction)^2);

% Evaluate constraint violation norm
if quantities.currentIterate.constraintNorm1 > 0.0
  
  % Initialize trial value
  tau_trial = inf;
  
  % Check sign of objective model value
  if objective_model_value > 0.0
    
    % Update trial value
    tau_trial = (1 - M.model_reduction_factor_) * quantities.currentIterate.constraintNorm1 / objective_model_value;
    
  end
  
  % Check trial value
  if quantities.meritParameter > tau_trial
    
    % Set merit parameter
    quantities.setMeritParameter((1 - M.parameter_reduction_factor_) * tau_trial);
    
  end
  
end % quantities.constraintNorm1 > 0.0

% Set model reduction
quantities.setModelReduction(-quantities.meritParameter * objective_model_value + quantities.currentIterate.constraintNorm1);

end % computeMeritParameter