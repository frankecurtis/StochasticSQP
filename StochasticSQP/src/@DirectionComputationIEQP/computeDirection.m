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
matrix = sparse(quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities,...
  quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities);
if D.use_hessian_of_lagrangian_
  matrix = [quantities.currentIterate.hessianOfLagrangian(quantities) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) zeros(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
  factor = 1e-08;
  while 1
    if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0 || sum(eig(matrix) >= 1e-08) >= quantities.currentIterate.numberOfVariables, break; end
    matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = ...
      matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) + factor * speye(quantities.currentIterate.numberOfVariables,quantities.currentIterate.numberOfVariables);
    factor = factor * 10;
  end
else
  matrix = [eye(quantities.currentIterate.numberOfVariables) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) zeros(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
end

% Check for nonsingularity
if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0 || ...
    sum(abs(eig(matrix)) >= 1e-08) < quantities.currentIterate.numberOfVariables + quantities.currentIterate.numberOfConstraintsEqualities
  
  % Indicate error (violation of LICQ or second-order sufficiency)
  fprintf('Violation of LICQ or second-order sufficiency!!! \n');
  err = true;
  
  % Set null direction
  quantities.setDirectionPrimal(zeros(quantities.currentIterate.numberOfVariables,1));
  
  % Set null multipliers
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[]);
  
else
    
  %%%%%%%%%%%%%%
  % Add iterative solver minres here...
  %%%%%%%%%%%%%%
  
  % Check whether LICQ holds
  if min(svd(quantities.currentIterate.constraintJacobianEqualities(quantities) * quantities.currentIterate.constraintJacobianEqualities(quantities)')) < 1e-8
      err = true;
      fprintf('LICQ does not hold!!! \n');
      return
  end
  
  
  [current_multipliers , ~] = quantities.currentIterate.multipliers;
  previousIterateMeasure = norm([quantities.previousIterate.objectiveGradient(quantities) + quantities.previousIterate.constraintJacobianEqualities(quantities)' * current_multipliers ; quantities.previousIterate.constraintFunctionEqualities(quantities)]);
  currentIterateInfo = [quantities.currentIterate.objectiveGradient(quantities) + quantities.currentIterate.constraintJacobianEqualities(quantities)' * current_multipliers; quantities.currentIterate.constraintFunctionEqualities(quantities)];
  currentIterateMeasure = norm(currentIterateInfo);
  c_norm1 = norm(quantities.currentIterate.constraintFunctionEqualities(quantities),1);
  c_norm2 = norm(quantities.currentIterate.constraintFunctionEqualities(quantities));
  
  addpath('/Users/baoyuzhou/Desktop/Software/StochasticSQP/StochasticSQP/external');
  
  % Inexact solve by iterative solver
  [v,TTnum,residual] = minres_stanford(matrix, -currentIterateInfo, quantities.currentIterate.numberOfVariables, currentIterateMeasure, previousIterateMeasure, c_norm1, c_norm2, ...
      D.full_residual_norm_factor_, D.primal_residual_norm_factor_, D.dual_residual_norm_factor_, D.constraint_norm_factor_, D.lagrangian_primal_norm_factor_, ...
      D.curvature_threshold_, D.model_reduction_factor_, quantities.currentIterate.objectiveGradient(quantities), quantities.meritParameter, ...
      quantities.currentIterate.constraintJacobianEqualities(quantities),[],0,false,true,max(size(matrix,1)*5,100),1e-10);
  
  % Set Termination Test Number
  quantities.setTerminationTestNumber(TTnum);
  
  if TTnum < 0
      TTnum = checkTerminationAgain(TTnum, v, residual, quantities.currentIterate.numberOfVariables, quantities.meritParameter, ...
          D.model_reduction_factor_, quantities.currentIterate.objectiveGradient(quantities), D.curvature_threshold_, c_norm1, ...
          D.full_residual_norm_factor_, currentIterateMeasure, previousIterateMeasure, D.dual_residual_norm_factor_, ...
          D.primal_residual_norm_factor_, c_norm2, D.constraint_norm_factor_, -currentIterateInfo, ...
          quantities.currentIterate.constraintJacobianEqualities(quantities), D.lagrangian_primal_norm_factor_, matrix);
      
      % Set Termination Test Number
      quantities.setTerminationTestNumber(TTnum);
  
      if TTnum < 0
        err = true;
        fprintf('No termination test is satisfied!!! \n');
        return;
      end
  end
  
  % Set residual
  quantities.setPrimalResidual(residual(1:quantities.currentIterate.numberOfVariables));
  quantities.setDualResidual(residual(quantities.currentIterate.numberOfVariables+1:end));
  quantities.setDualResidualNorm1(norm(residual(quantities.currentIterate.numberOfVariables+1:end),1));
  
%   % Compute direction
%   v = -matrix \ [quantities.currentIterate.objectiveGradient(quantities);
%     quantities.currentIterate.constraintFunctionEqualities(quantities)];
  
  % Set direction
  quantities.setDirectionPrimal(v(1:quantities.currentIterate.numberOfVariables));
  
  % Set multiplier
  quantities.currentIterate.setMultipliers(current_multipliers + v(quantities.currentIterate.numberOfVariables+1:end),[]);
  
end

end % computeDirection