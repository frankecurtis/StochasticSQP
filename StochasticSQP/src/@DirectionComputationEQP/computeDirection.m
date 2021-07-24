% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

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
  k = 0;
  
  % CG loop
  while 1
    
    % Increment counter
    k = k + 1;
    quantities.incrementCGIterationCounter;
    
    % Check residual
    if rr <= D.cg_residual_tolerance_^2 * max(1, Jc_norm^2), break; end
    
    % Check iteration limit
    if k > max(1,D.cg_iteration_relative_limit_ * quantities.currentIterate.numberOfConstraintsEqualities), break; end
    
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
matrix_set = false;
if D.use_hessian_of_lagrangian_
  matrix = [quantities.currentIterate.hessianOfLagrangian(quantities) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) sparse(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
  if sum(sum(isnan(matrix))) == 0 && sum(sum(isinf(matrix))) == 0
    matrix_set = true;
  end
end
if ~matrix_set
  matrix = [speye(quantities.currentIterate.numberOfVariables) quantities.currentIterate.constraintJacobianEqualities(quantities)';
    quantities.currentIterate.constraintJacobianEqualities(quantities) sparse(quantities.currentIterate.numberOfConstraintsEqualities,quantities.currentIterate.numberOfConstraintsEqualities)];
end

% Check for Nan or inf
if sum(sum(isnan(matrix))) > 0 || sum(sum(isinf(matrix))) > 0
  
  % Indicate error
  err = true;
  
  % Set null direction
  quantities.setDirectionPrimal(quantities.directionPrimal('normal'),'full');
  
  % Set null multipliers
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'stochastic');
  quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'true');
  
else
  
  % Use iterative solver?
  if ~D.use_iterative_solver_
    
    % Initialize counter
    counter = 0;
    
    % Loop until Hessian modification not required
    while 1
      
      % Decompose step?
      if ~D.decompose_step_
        
        % Compute full direction
        rhs = -[quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
        dy = matrix \ rhs;
        dy = full(dy);
        
      else
        
        % Compute tangential direction
        rhs = -[quantities.currentIterate.objectiveGradient(quantities,'stochastic') + matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('normal'); zeros(quantities.currentIterate.numberOfConstraintsEqualities,1)]; 
        dy = matrix \ rhs;
        dy = full(dy);
        
        % Compute full direction
        dy(1:quantities.currentIterate.numberOfVariables) = dy(1:quantities.currentIterate.numberOfVariables) + quantities.directionPrimal('normal');
        
      end
      
      % Increment counter
      quantities.incrementMatrixFactorizationCounter;
      
      % Set direction
      quantities.setDirectionPrimal(dy(1:quantities.currentIterate.numberOfVariables),'full');
      
      % Check if modification not required
      if sum(isnan(dy)) == 0 && sum(isinf(dy)) == 0 && ...
          (norm(quantities.directionPrimal('tangential')) <= D.decomposition_threshold_ * norm(quantities.directionPrimal('normal')) || ...
          quantities.directionPrimal('tangential')' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('tangential') >= D.curvature_threshold_ * norm(quantities.directionPrimal('tangential'))^2)
        break;
      end
      
      % Increment counter
      counter = counter + 1;
      
      % Perform modification or break
      if counter < D.modification_limit_
        matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = D.modification_factor_ * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) + (1 - D.modification_factor_) * speye(quantities.currentIterate.numberOfVariables);
      elseif counter == D.modification_limit_
        matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = speye(quantities.currentIterate.numberOfVariables);
        matrix(quantities.currentIterate.numberOfVariables+1:end,quantities.currentIterate.numberOfVariables+1:end) = -D.constraint_regularization_ * speye(quantities.currentIterate.numberOfConstraintsEqualities);
      else
        if sum(isnan(dy)) > 0 || sum(isinf(dy)) > 0
          err = true;
          quantities.setDirectionPrimal(quantities.directionPrimal('normal'),'full');
          quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'stochastic');
          quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'true');
        end
        break;
      end
      
    end % while
    
    % Set termination test
    quantities.setTerminationTest(0);
    
    % Increment counters
    quantities.incrementTerminationTestCounter(0);
    
  else
    
    % Grab required data
    SS_in.quantities = quantities;
    SS_in.directionComputation = D;
    
    % Initialize counter
    counter = 0;
    
    % Loop until Hessian modification not required
    while 1
      
      % Decompose step?
      if ~D.decompose_step_

        % Compute full direction
        rhs = -[quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
        [dy,~,iters,~,~,~,~,~,SS_out] = minres(matrix,rhs,[],0,false,false,2*length(rhs),1e-12,SS_in);
        dy = full(dy);
        
      else
        
        % Compute tangential direction
        rhs = -[quantities.currentIterate.objectiveGradient(quantities,'stochastic') + matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('normal'); zeros(quantities.currentIterate.numberOfConstraintsEqualities,1)];
        [dy,~,iters,~,~,~,~,~,SS_out] = minres(matrix,rhs,[],0,false,false,2*length(rhs),1e-12,SS_in);
        dy = full(dy);
        
        % Compute full direction
        dy(1:quantities.currentIterate.numberOfVariables) = dy(1:quantities.currentIterate.numberOfVariables) + quantities.directionPrimal('normal');
        
      end
      
      % Increment counter
      quantities.incrementMINRESIterationCounter(iters);

      % Set direction
      quantities.setDirectionPrimal(dy(1:quantities.currentIterate.numberOfVariables),'full');
      
      % Check if modification not required
      if sum(isnan(dy)) == 0 && sum(isinf(dy)) == 0 && SS_out.tt > 0
        if SS_out.tt == 3
          dy(1:quantities.currentIterate.numberOfVariables) = 0;
        end
        break;
      end
      
      % Increment counter
      counter = counter + 1;
      
      % Perform modification or break
      if counter < D.modification_limit_
        matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = D.modification_factor_ * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) + (1 - D.modification_factor_) * speye(quantities.currentIterate.numberOfVariables);
      elseif counter == D.modification_limit_
        matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) = speye(quantities.currentIterate.numberOfVariables);
        matrix(quantities.currentIterate.numberOfVariables+1:end,quantities.currentIterate.numberOfVariables+1:end) = -D.constraint_regularization_ * speye(quantities.currentIterate.numberOfConstraintsEqualities);
      else
        if sum(isnan(dy)) > 0 || sum(isinf(dy)) > 0
          err = true;
          quantities.setDirectionPrimal(quantities.directionPrimal('normal'),'full');
          quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'stochastic');
          quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),[],'true');
        end
        break;
      end
      
    end % while
    
    % Set termination test
    quantities.setTerminationTest(SS_out.tt);
    
    % Increment counters
    quantities.incrementTerminationTestCounter(SS_out.tt);
    
  end
  
  % Compute residual
  r = matrix * dy + [quantities.currentIterate.objectiveGradient(quantities,'stochastic'); quantities.currentIterate.constraintFunctionEqualities(quantities)];

  % Set linear system residual norm
  quantities.setLinearSystemResidualNorm(norm(r,inf));
    
  % Set multiplier
  quantities.currentIterate.setMultipliers(dy(quantities.currentIterate.numberOfVariables+1:end),[],'stochastic');
  
  % Set residuals
  quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end),'full');
  
  % Compute direction true?
  if D.compute_true_
    
    % Decomposed step?
    if ~D.decompose_step_
      
      % Compute full direction
      dy_true = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'true'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
      dy_true = full(dy_true);
      
    else
      
      % Compute tangential direction
      dy_true = -matrix \ [quantities.currentIterate.objectiveGradient(quantities,'true') + matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('normal'); zeros(quantities.currentIterate.numberOfConstraintsEqualities,1)];
      dy_true = full(dy_true);
      
      % Compute full direction
      dy_true(1:quantities.currentIterate.numberOfVariables) = dy_true(1:quantities.currentIterate.numberOfVariables) + quantities.directionPrimal('normal');
      
    end
    
    % Increment counter
    quantities.incrementMatrixFactorizationCounter;
    
    % Set to stochastic direction if any issues
    if sum(isnan(dy_true)) > 0 || sum(isinf(dy_true)) > 0, dy_true = dy; end
    
    % Set direction
    quantities.setDirectionPrimal(dy_true(1:quantities.currentIterate.numberOfVariables),'true');
    
    % Compute residual
    r = matrix * dy_true + [quantities.currentIterate.objectiveGradient(quantities,'true'); quantities.currentIterate.constraintFunctionEqualities(quantities)];
    
    % Set multiplier
    quantities.currentIterate.setMultipliers(dy_true(quantities.currentIterate.numberOfVariables+1:end),[],'true');
    
    % Set residual
    quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end),'true');
    
  else
    
    % Set multiplier
    quantities.currentIterate.setMultipliers(dy(quantities.currentIterate.numberOfVariables+1:end),[],'true');
    
    % Set residual
    quantities.setResidualFeasibility(r(quantities.currentIterate.numberOfVariables+1:end),'true');
    
  end
  
  % Set curvature
  quantities.setCurvature(quantities.directionPrimal('full')' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('full'),'full');
  quantities.setCurvature(quantities.directionPrimal('tangential')' * matrix(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('tangential'),'tangential');
  
end
  
end % computeDirection