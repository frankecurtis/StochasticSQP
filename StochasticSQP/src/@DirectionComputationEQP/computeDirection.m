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

% Check whether to decompose step
if ~D.decompose_step_
  
  % Set null normal step
  quantities.setDirectionPrimal(zeros(quantities.currentIterate.numberOfVariables,1),'normal');
  
  % Set linearized feasibility for normal step
  quantities.setResidualFeasibility(quantities.currentIterate.constraintFunctionEqualities(quantities),'normal');
  
else
  
  % Initialize conjugate gradient (CG) algorithm
  v = zeros(quantities.currentIterate.numberOfVariables,1);
  Jc = (quantities.currentIterate.constraintFunctionEqualities(quantities)'*quantities.currentIterate.constraintJacobianEqualities(quantities))';
  Jc_norm = norm(Jc);
  delta = D.cg_trust_region_factor_*Jc_norm;
  r = Jc;
  p = -r;
  rr = r'*r;
  
  % CG loop
  while 1
    
    % Check residual
    if rr <= D.cg_residual_tolerance_^2 * max(1, Jc_norm^2)
      break;
    end
    
    % Compute products
    JJp = ((quantities.currentIterate.constraintJacobianEqualities(quantities)*p)'*quantities.currentIterate.constraintJacobianEqualities(quantities))';
    pJJp = p'*JJp;
    
    % Compute stepsize
    a = rr/pJJp;
    
    % Check trust region constraint
    if norm(v + a*p) >= delta
      a = max(roots([norm(p)^2, 2*v'*p, norm(v)^2 - delta^2]));
      v = v + a*p;
      break;
    end
    
    % Update
    v = v + a*p;
    r = r + a*JJp;
    rr_new = r'*r;
    b = rr_new/rr;
    rr = rr_new;
    p = -r + b*p;
    
  end
  
  % Set normal step
  quantities.setDirectionPrimal(v,'normal');
  
  % Set linearized feasibility for normal step
  quantities.setResidualFeasibility(quantities.currentIterate.constraintFunctionEqualities(quantities) + quantities.currentIterate.constraintJacobianEqualities(quantities)*v,'normal');
  
end

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
  quantities.setDirectionPrimal(quantities.directionPrimalNormal,'full');
  
  % Set null multipliers
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'stochastic');
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'true');
  
else
  
  % Decomposed step?
  if ~D.decompose_step_
    
    % Compute full direction
    dy = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
    
  else
    
    % Compute tangential direction
    uy = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'stochastic') + matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('normal'); zeros(quantities.currentIterate.numberOfConstraintsEqualities,1)];
    
    % Compute full direction
    dy = full(uy);
    dy(1:quantities.currentIterate.numberOfVariables) = dy(1:quantities.currentIterate.numberOfVariables) + quantities.directionPrimal('normal');
    
  end
  
  % Set direction
  quantities.setDirectionPrimal(dy(1:quantities.currentIterate.numberOfVariables),'full');
  
  % Compute residual
  r = matrix * dy + [quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
  
  % Set multiplier
  quantities.currentIterate.setMultipliers(dy(quantities.currentIterate.numberOfVariables+1:end),[],'stochastic');
  
  % Set residuals
  quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end),'full');
  
  % Compute direction true?
  if D.compute_true_
    
    % Decomposed step?
    if ~D.decompose_step_
      
      % Compute full direction
      dy = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'true'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
      
    else
      
      % Compute direction
      uy = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'true') + matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('normal'); zeros(quantities.currentIterate.numberOfConstraintsEqualities,1)];
      
      % Compute full direction
      dy = full(uy);
      dy(1:quantities.currentIterate.numberOfVariables) = dy(1:quantities.currentIterate.numberOfVariables) + quantities.directionPrimal('normal');
      
    end
    
    % Set direction
    quantities.setDirectionPrimal(dy(1:quantities.currentIterate.numberOfVariables),'true');
  
    % Compute residual
    r = matrix * dy + [quantities.currentIterate.objectiveGradient(quantities,'true'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
    
    % Set multiplier
    quantities.currentIterate.setMultipliers(dy(quantities.currentIterate.numberOfVariables+1:end),[],'true');
    
    % Set residual
    quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end),'true');
    
  else
    
    % Set multiplier
    quantities.currentIterate.setMultipliers(dy(quantities.currentIterate.numberOfVariables+1:end),[],'true');
    
    % Set residual
    quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end),'true');
    
  end
  
  % Set curvature
  quantities.setCurvature(quantities.directionPrimal('full')' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('full'));
  
end

end % computeDirection