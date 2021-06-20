% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQP: computeDirection
function err = computeDirection(D,options,quantities,reporter,strategies)

% Initialize error
err = false;

% Assert that number of inequalities is zero
assert(quantities.currentIterate.numberOfConstraintsInequalities == 0,'ComputeDirection: For this strategy, number of inequalities should be zero!');

% Set matrix
if D.use_hessian_of_lagrangian_
  matrix = [quantities.currentIterate.hessianOfLagrangian(quantities) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) sparse(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
  factor = D.curvature_threshold_;
  while 1
    if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0 || sum(eig(matrix) >= D.curvature_threshold_) >= quantities.currentIterate.numberOfVariables, break; end
    matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = ...
      matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) + factor * speye(quantities.currentIterate.numberOfVariables,quantities.currentIterate.numberOfVariables);
    factor = factor * 10;
  end
else
  matrix = [speye(quantities.currentIterate.numberOfVariables) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) sparse(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
end

% Check for nonsingularity
if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0 || sum(abs(eig(matrix)) >= D.curvature_threshold_) < quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities
  
  % Indicate error (violation of LICQ or second-order sufficiency)
  err = true;
  
  % Set null direction
  quantities.setDirectionPrimal(zeros(quantities.currentIterate.numberOfVariables,1));
  
  % Set null multipliers
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[]);
  
else
  
  % Compute direction
  v = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
  v = full(v);
  
  % Compute residual
  r = matrix*v + [quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
  
  % Set residuals
  quantities.setResidualStationarity(r(1:quantities.currentIterate.numberOfVariables));
  quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end));
  
  % Set direction
  quantities.setDirectionPrimal(v(1:quantities.currentIterate.numberOfVariables));
  
  % Set multiplier
  quantities.currentIterate.setMultipliers(v(quantities.currentIterate.numberOfVariables+1:end),[],'stochastic');
  
  % Set curvature
  quantities.setCurvature(v(1:quantities.currentIterate.numberOfVariables)' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * v(1:quantities.currentIterate.numberOfVariables));
  
end

end % computeDirection