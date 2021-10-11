% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationModelReduction: computeParameters
function computeParameters(P,options,quantities,reporter,strategies)

% Compute linear objective model value
objective_model_value = quantities.currentIterate.objectiveGradient(quantities,'stochastic')'*quantities.directionPrimal('full');

% Compute quadratic term
if P.quadratic_model_for_merit_update_
  quadratic_term = max(P.curvature_threshold_ * norm(quantities.directionPrimal('tangential'))^2, quantities.curvature('tangential'));
else
  quadratic_term = 0;
end

% Compute linear constraint reduction
constraint_model_reduction = quantities.currentIterate.constraintNorm1 - ...
  norm(quantities.currentIterate.constraintFunctionEqualities(quantities) + quantities.currentIterate.constraintJacobianEqualities(quantities)*quantities.directionPrimal('full'),1);

%%%%%%%%%%%%%%%%%%%
% MERIT PARAMETER %
%%%%%%%%%%%%%%%%%%%

% Evaluate constraint violation norm
if quantities.currentIterate.constraintNorm1 > 0.0
  
  % Initialize trial value
  merit_parameter_trial = inf;
  
%   % Check sign of objective model value
%   if objective_model_value + quadratic_term > 0.0 && (quantities.terminationTest == 0 || quantities.terminationTest == 2)
%     
%     % Update trial value
%     merit_parameter_trial = (1 - P.model_reduction_factor_) * constraint_model_reduction / (objective_model_value + quadratic_term);
%     
%   end
  
  % Check trial value
  if quantities.meritParameter > merit_parameter_trial
    
    % Set merit parameter
    quantities.setMeritParameter(max(P.parameter_minimum_,min((1 - P.parameter_reduction_factor_) * quantities.meritParameter, merit_parameter_trial)));
    
  end
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECOMPOSITION AND CURVATURE PARAMETERS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check update conditions
if norm(quantities.directionPrimal('tangential'))^2 >= quantities.decompositionParameter * norm(quantities.directionPrimal('normal'))^2 && ...
    quantities.curvature('full') < 0.5 * quantities.curvatureParameter * norm(quantities.directionPrimal('tangential'))^2
  
  % Set parameters
  quantities.setDecompositionParameter((1 + P.parameter_increase_factor_) * quantities.decompositionParameter);
  quantities.setCurvatureParameter(max(P.parameter_minimum_,(1 - P.parameter_reduction_factor_) * quantities.curvatureParameter));
  
end

% Set curvature indicator
quantities.setCurvatureIndicator(norm(quantities.directionPrimal('tangential'))^2 >= quantities.decompositionParameter * norm(quantities.directionPrimal('normal'))^2);

%%%%%%%%%%%%%%%%%%%
% MODEL REDUCTION %
%%%%%%%%%%%%%%%%%%%

% Check whether to add quadratic
if P.quadratic_model_for_stepsize_
  
  % Set model reduction
  quantities.setModelReduction(-quantities.meritParameter * (objective_model_value + (1/2)*quadratic_term) + constraint_model_reduction);
  
else
  
  % Set model reduction
  quantities.setModelReduction(-quantities.meritParameter * objective_model_value + constraint_model_reduction);
  
end

%%%%%%%%%%%%%%%%%%%
% RATIO PARAMETER %
%%%%%%%%%%%%%%%%%%%

% Initialize trial value
if quantities.modelReduction > 0
  if quantities.curvatureIndicator
    ratio_parameter_trial = quantities.modelReduction / (quantities.meritParameter * norm(quantities.directionPrimal('full'))^2);
  else
    ratio_parameter_trial = quantities.modelReduction / norm(quantities.directionPrimal('full'))^2;
  end
else
  ratio_parameter_trial = P.parameter_minimum_;
end

% Check trial value
if quantities.ratioParameter > ratio_parameter_trial
  
  % Set ratio parameter
  quantities.setRatioParameter(max(P.parameter_minimum_,min((1 - P.parameter_reduction_factor_) * quantities.ratioParameter, ratio_parameter_trial)));
  
end

end % computeParameters