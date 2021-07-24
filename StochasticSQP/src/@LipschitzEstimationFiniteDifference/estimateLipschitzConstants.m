% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% LipschitzEstimationFiniteDifference: estimateLipschitzConstants
function estimateLipschitzConstants(L,options,quantities,reporter,strategies)

% Check whether to estimate
if quantities.iterationCounter <= L.estimate_always_until_ || mod(quantities.iterationCounter - L.estimate_always_until_, L.estimate_frequency_) == 0
  
  % Initialize Lipschitz estimates
  lipschitz_constraint = 0;
  lipschitz_objective = 0;
  
  % Check whether to use coordinate directions
  if L.coordinate_directions_
    for i = 1:quantities.currentIterate.numberOfVariables
      samplePoint = quantities.currentIterate.primalPoint;
      samplePoint(i) = samplePoint(i) + L.displacement_;
      [lip_con, lip_obj] = computeEstimates(quantities,samplePoint,L.use_true_gradient_,quantities.batchSize);
      lipschitz_constraint = max(lipschitz_constraint,lip_con);
      lipschitz_objective = max(lipschitz_objective,lip_obj);
    end
  end
  
  % Check whether to use random direction
  if L.random_direction_
    rng(L.seed_);
    sampleDirection = randn(quantities.currentIterate.numberOfVariables,1);
    L.seed_ = rng;
    samplePoint = quantities.currentIterate.primalPoint + L.displacement_ * sampleDirection/norm(sampleDirection);
    [lip_con, lip_obj] = computeEstimates(quantities,samplePoint,L.use_true_gradient_,quantities.batchSize);
    lipschitz_constraint = max(lipschitz_constraint,lip_con);
    lipschitz_objective = max(lipschitz_objective,lip_obj);
  end
  
  % Ensure estimates are nonzero!
  if lipschitz_constraint <= 0, lipschitz_constraint = L.lipschitz_constraint_minimum_; end
  if lipschitz_objective <= 0, lipschitz_objective = L.lipschitz_objective_minimum_; end
  
  % Set Lipschitz constant estimates
  quantities.setLipschitz(lipschitz_constraint,lipschitz_objective);
  
end

end % estimateLipschitzConstants

% computeEstimates
function [lip_con,lip_obj] = computeEstimates(quantities,samplePoint,use_true,batch_size)

% Get scale factors
[f_scale,cE_scale,~] = quantities.currentIterate.scaleFactors;

% Evaluate constraint Jacobian at sample point
sampleJacobian = cE_scale .* quantities.currentIterate.problem.evaluateConstraintJacobianEqualities(samplePoint);

% Estimate constraint Jacobian Lipschitz constant
lip_con = normest(quantities.currentIterate.constraintJacobianEqualities(quantities) - sampleJacobian) / norm(quantities.currentIterate.primalPoint - samplePoint);

% Evaluate objective gradient at sample point
if use_true
  sampleGradient = f_scale * quantities.currentIterate.problem.evaluateObjectiveGradient(samplePoint,'true');
  lip_obj = norm(quantities.currentIterate.objectiveGradient(quantities,'true') - sampleGradient) / norm(quantities.currentIterate.primalPoint - samplePoint);
else
  sampleGradient = f_scale * quantities.currentIterate.problem.evaluateObjectiveGradient(samplePoint,'stochastic',batch_size);
  lip_obj = norm(quantities.currentIterate.objectiveGradient(quantities,'stochastic') - sampleGradient) / norm(quantities.currentIterate.primalPoint - samplePoint);
end

end