% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationModelReduction: computeParameters
function computeParameters(P,options,quantities,reporter,strategies)

% Compute linear objective model value
objective_model_value = quantities.currentIterate.objectiveGradient(quantities,'stochastic')'*quantities.directionPrimal('full');

% Compute quadratic term
if P.quadratic_model_
  quadratic_term = max(P.curvature_threshold_ * norm(quantities.directionPrimal('full'))^2, quantities.curvature);
else
  quadratic_term = 0;
end

% Compute linear constraint reduction
constraint_model_reduction = quantities.currentIterate.constraintNorm1 - ...
  norm(quantities.currentIterate.constraintFunctionEqualities(quantities) + quantities.currentIterate.constraintJacobianEqualities(quantities)*quantities.directionPrimal('full'),1);

% Set curvature indicator
quantities.setCurvatureIndicator(norm(quantities.directionPrimal('tangential'))^2 >= quantities.decompositionParameter * norm(quantities.directionPrimal('normal'))^2);

% Check whether to add quadratic
if P.quadratic_model_
  
  % Set model reduction
  quantities.setModelReduction(-quantities.meritParameter * (objective_model_value + (1/2)*quadratic_term) + constraint_model_reduction);
  
else
  
  % Set model reduction
  quantities.setModelReduction(-quantities.meritParameter * objective_model_value + constraint_model_reduction);
  
end

end % computeParameters