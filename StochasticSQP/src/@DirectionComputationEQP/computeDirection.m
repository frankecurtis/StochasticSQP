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
matrix = sparse(quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities,...
  quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities);
if D.use_hessian_of_lagrangian_
  matrix = [quantities.currentIterate.hessianOfLagrangian(quantities) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) zeros(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
  factor = D.curvature_threshold_;
  while 1
    if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0 || sum(eig(matrix) >= D.curvature_threshold_) >= quantities.currentIterate.numberOfVariables, break; end
    matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = ...
      matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) + factor * speye(quantities.currentIterate.numberOfVariables,quantities.currentIterate.numberOfVariables);
    factor = factor * 10;
  end
else
  matrix = [eye(quantities.currentIterate.numberOfVariables) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) zeros(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
end

% Check for nonsingularity
%%%%%% Add 1e-08 as a new option...
if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0 || ...
    sum(abs(eig(matrix)) >= D.curvature_threshold_) < quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities
  
  % Indicate error (violation of LICQ or second-order sufficiency)
  err = true;
  
  % Set null direction
  quantities.setDirectionPrimal(zeros(quantities.currentIterate.numberOfVariables,1));
  
  % Set null multipliers
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[]);
  
else
  
  % Compute direction
  v = -matrix \ [quantities.currentIterate.objectiveGradient(quantities);
    quantities.currentIterate.constraintFunctionEqualities(quantities)];
  
  % Set direction
  quantities.setDirectionPrimal(v(1:quantities.currentIterate.numberOfVariables));
  
  % Set residual
  quantities.setPrimalResidual(sparse(quantities.currentIterate.numberOfVariables,1));
  quantities.setDualResidual(sparse(quantities.currentIterate.numberOfConstraintsEqualities,1));
  quantities.setDualResidualNorm1(0);
  
  % Set curvature
  quantities.setCurvature(v(1:quantities.currentIterate.numberOfVariables)' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * v(1:quantities.currentIterate.numberOfVariables));

  
  % Set multiplier
  quantities.currentIterate.setMultipliers(v(quantities.currentIterate.numberOfVariables+1:end),[]);
  
end

end % computeDirection