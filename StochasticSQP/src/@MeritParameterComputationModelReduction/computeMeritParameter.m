% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: computeMeritParameter
function computeMeritParameter(M,options,quantities,reporter,strategies)

%%%%%%%%%%%%%%%%%%%
% MERIT PARAMETER %
%%%%%%%%%%%%%%%%%%%

% Compute linear objective model value
objective_model_value = quantities.currentIterate.objectiveGradient(quantities,'stochastic')'*quantities.directionPrimal('full');

% Compute quadratic term
if M.quadratic_model_for_merit_update_
  quadratic_term = max(M.curvature_threshold_ * norm(quantities.directionPrimal('full'))^2, quantities.curvature);
else
  quadratic_term = 0;
end

% Compute linear constraint reduction
constraint_model_reduction = quantities.currentIterate.constraintNorm1 - ...
  norm(quantities.currentIterate.constraintFunctionEqualities(quantities) + quantities.currentIterate.constraintJacobianEqualities(quantities)*quantities.directionPrimal('full'),1);

% Evaluate constraint violation norm
if quantities.currentIterate.constraintNorm1 > 0.0
  
  % Initialize trial value
  merit_parameter_trial = inf;
  
  % Check sign of objective model value
  if objective_model_value + quadratic_term > 0.0 && ...
      (strcmp(quantities.terminationTest,'exact') || strcmp(quantities.terminationTest,'TT2'))
    
    % Update trial value
    merit_parameter_trial = (1 - M.model_reduction_factor_) * constraint_model_reduction / (objective_model_value + quadratic_term);
    
  end
  
  % Check trial value
  if quantities.meritParameter > merit_parameter_trial
    
    % Set merit parameter
    quantities.setMeritParameter(min((1 - M.parameter_reduction_factor_) * quantities.meritParameter, merit_parameter_trial));
    
  end
  
end

%%%%%%%%%%%%%%%%%%%
% MODEL REDUCTION %
%%%%%%%%%%%%%%%%%%%

% Check whether to add quadratic
if M.quadratic_model_for_stepsize_
  
  % Set model reduction
  quantities.setModelReduction(-quantities.meritParameter * (objective_model_value + (1/2)*quadratic_term) + quantities.currentIterate.constraintNorm1);
  
else
  
  % Set model reduction
  quantities.setModelReduction(-quantities.meritParameter * objective_model_value + quantities.currentIterate.constraintNorm1);
  
end

%%%%%%%%%%%%%%%%%%%
% RATIO PARAMETER %
%%%%%%%%%%%%%%%%%%%

% Initialize trial value
ratio_parameter_trial = quantities.modelReduction / (quantities.meritParameter * norm(quantities.directionPrimal('full'))^2);

% Check trial value
if quantities.ratioParameter > ratio_parameter_trial
  
  % Set ratio parameter
  quantities.setRatioParameter(min((1 - M.parameter_reduction_factor_) * quantities.ratioParameter, ratio_parameter_trial));
  
end

end % computeMeritParameter