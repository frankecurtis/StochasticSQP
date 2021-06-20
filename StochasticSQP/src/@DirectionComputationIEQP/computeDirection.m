% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationIEQP: computeDirection
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
    if max(max(isnan(matrix))) > 0 || max(max(isinf(matrix))) > 0 || sum(eig(matrix) >= D.curvature_threshold_) >= quantities.currentIterate.numberOfVariables, break; end
    matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = ...
      matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) + factor * speye(quantities.currentIterate.numberOfVariables,quantities.currentIterate.numberOfVariables);
    factor = factor * 10;
  end
else
  matrix = [speye(quantities.currentIterate.numberOfVariables) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) zeros(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
end

% Check whether LICQ holds
if eigs(quantities.currentIterate.constraintJacobianEqualities(quantities) * quantities.currentIterate.constraintJacobianEqualities(quantities)',1,'sm') < D.curvature_threshold_ || max(max(isnan(matrix))) > 0 || max(max(isinf(matrix))) > 0
  err = true;
  fprintf('Violation of LICQ or second-order sufficiency!!! \n');
  return
end

if quantities.checkStationarityMeasure
  % Compute exact direction with the true gradient
  v_true = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'true');
    quantities.currentIterate.constraintFunctionEqualities(quantities)];
  
  % Set true multipliers
  quantities.currentIterate.setMultipliers(v_true(quantities.currentIterate.numberOfVariables+1:end),sparse([]),'true');
end

[current_multipliers , ~] = quantities.currentIterate.multipliers('stochastic');
previousIterateMeasure = norm([quantities.previousIterate.objectiveGradient(quantities,'stochastic') + quantities.previousIterate.constraintJacobianEqualities(quantities)' * current_multipliers ; quantities.previousIterate.constraintFunctionEqualities(quantities)]);
currentIterateInfo = [quantities.currentIterate.objectiveGradient(quantities,'stochastic') + quantities.currentIterate.constraintJacobianEqualities(quantities)' * current_multipliers; quantities.currentIterate.constraintFunctionEqualities(quantities)];
currentIterateMeasure = norm(currentIterateInfo);
c_norm1 = norm(quantities.currentIterate.constraintFunctionEqualities(quantities),1);
c_norm2 = norm(quantities.currentIterate.constraintFunctionEqualities(quantities));

addpath('/Users/baoyuzhou/Desktop/Software/StochasticSQP/StochasticSQP/external');

% Inexact solve by iterative solver
[v,TTnum,residual,innerIter] = minres_stanford(matrix, -currentIterateInfo, quantities.currentIterate.numberOfVariables, currentIterateMeasure, previousIterateMeasure, c_norm1, c_norm2, ...
  D.full_residual_norm_factor_, D.primal_residual_norm_factor_, D.dual_residual_norm_factor_, D.constraint_norm_factor_, D.lagrangian_primal_norm_factor_, ...
  D.curvature_threshold_, D.model_reduction_factor_, quantities.currentIterate.objectiveGradient(quantities,'stochastic'), quantities.meritParameter, ...
  quantities.currentIterate.constraintJacobianEqualities(quantities),[],0,false,true,max(size(matrix,1)*100,100),1e-10);

% Set Termination Test Number
quantities.setTerminationTestNumber(TTnum);

if TTnum < 0
  err = true;
  fprintf('No termination test is satisfied!!! \n');
  return;
end

% Transform dense to sparse format
v = sparse(v);
residual = sparse(residual);

% Set current inner iteration counter
quantities.setIterativeSolverCounter(innerIter);

% Increment inner iteration counter
quantities.incrementInnerIterationCounter(innerIter);

% Set residual
quantities.setPrimalResidual(residual(1:quantities.currentIterate.numberOfVariables));
quantities.setDualResidual(residual(quantities.currentIterate.numberOfVariables+1:end));
quantities.setDualResidualNorm1(norm(residual(quantities.currentIterate.numberOfVariables+1:end),1));

% Set direction
quantities.setDirectionPrimal(v(1:quantities.currentIterate.numberOfVariables));

% Set curvature
quantities.setCurvature(v(1:quantities.currentIterate.numberOfVariables)' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * v(1:quantities.currentIterate.numberOfVariables));

% Set multiplier
quantities.currentIterate.setMultipliers(current_multipliers + v(quantities.currentIterate.numberOfVariables+1:end),[],'stochastic');

end % computeDirection