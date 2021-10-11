% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP: terminationTests
function out = terminationTests(D,A,b,k,x,quantities)

  % Initialize output
  out.flag = 0;
  out.tt   = 0;

  % Check whether to check termination tests
  if k >= D.termination_test_iteration_minimum_ && ...
      mod(k - D.termination_test_iteration_minimum_, D.termination_test_iteration_frequency_) == 0
    
    % Evaluate residual
    residual = A*x - b;
    
    % Evaluate residual norms
    res_norm = norm(residual,inf);
    res_norm_dual = norm(residual(1:quantities.currentIterate.numberOfVariables),inf);
    res_norm_primal = norm(residual(quantities.currentIterate.numberOfVariables+1:end),inf);
    
    % Evaluate norm of right-hand side
    rhs_norm = norm(b,inf);
    
    % Check whether overall residual is sufficiently small
    if res_norm <= max(D.residual_tolerance_factor_ * rhs_norm, D.residual_tolerance_minimum_)
    
      % Evaluate steps
      if ~D.decompose_step_
        d = x(1:quantities.currentIterate.numberOfVariables);
        u = d - quantities.directionPrimal('normal');
      else
        u = x(1:quantities.currentIterate.numberOfVariables);
        d = u + quantities.directionPrimal('normal');
      end
      delta = x(quantities.currentIterate.numberOfVariables+1:end);
      
      % Evaluate curvature
      curvature = u' * A(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * u;
      
      % Evaluate objective directional derivative
      objective_directional_derivative = quantities.currentIterate.objectiveGradient(quantities,'stochastic')'*d;
      
      % Evaluate linearized infeasibility reduction
      infeasibility_reduction = quantities.currentIterate.constraintNorm1 - norm(quantities.currentIterate.constraintFunctionEqualities + quantities.currentIterate.constraintJacobianEqualities * d,1);
      
      % Evaluate model reduction
      model_reduction = -quantities.meritParameter * objective_directional_derivative + infeasibility_reduction;
      
      % Check model reduction condition
      model_reduction_condition = (model_reduction >= D.model_reduction_tolerance_objective_ * quantities.meritParameter * max(curvature, D.curvature_threshold_ * norm(u))^2 + ...
          D.model_reduction_tolerance_constraints_ * (quantities.currentIterate.constraintNorm1 - norm(quantities.currentIterate.constraintFunctionEqualities + quantities.currentIterate.constraintJacobianEqualities * quantities.directionPrimal('normal'),1)));

      % Dual residual condition
      dual_residual_condition = (res_norm_dual <= D.residual_dual_tolerance_ * ...
        min(norm([quantities.currentIterate.objectiveGradient(quantities,'stochastic') + ((quantities.currentIterate.multipliers('stochastic') + delta)'*quantities.currentIterate.constraintJacobianEqualities)'; quantities.currentIterate.constraintFunctionEqualities],inf), ...
        norm([quantities.previousIterate.objectiveGradient(quantities,'stochastic') + ((quantities.previousIterate.multipliers('stochastic'))'*quantities.previousIterate.constraintJacobianEqualities)'; quantities.previousIterate.constraintFunctionEqualities],inf)));
      
      % Stepsize residual conditions
      stepsize_residual_conditions = ((res_norm_dual <= quantities.stepsizeScaling * D.stepsize_residual_dual_tolerance_) && ...
        (res_norm_primal <= quantities.stepsizeScaling * D.stepsize_residual_primal_tolerance_));
      
      % Tangential component condition
      tangential_component_condition = (norm(u) <= D.decomposition_threshold_ * norm(quantities.directionPrimal('normal'))) || ...
        ((curvature >= D.curvature_threshold_ * norm(u)^2) && ...
        ((quantities.currentIterate.objectiveGradient(quantities,'stochastic') + A(1:quantities.currentIterate.numberOfVariables,1:quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('normal'))'*u + 0.5*curvature <= D.tangential_objective_tolerance_ * norm(quantities.directionPrimal('normal'))));

      % Hessian modification condition
      hessian_modification_condition = (norm(u) > D.decomposition_threshold_ * norm(quantities.directionPrimal('normal')) && ...
        curvature < D.curvature_threshold_ * norm(u)^2);
      
      % Constraint reduction condition
      constraint_reduction_condition = (quantities.currentIterate.constraintNorm1 - norm(quantities.currentIterate.constraintFunctionEqualities + quantities.currentIterate.constraintJacobianEqualities * d,1) >= ...
        D.constraint_reduction_tolerance_ * quantities.currentIterate.constraintNorm1 - norm(quantities.currentIterate.constraintFunctionEqualities + quantities.currentIterate.constraintJacobianEqualities * quantities.directionPrimal('normal'),1));
      
      % Stationarity imbalance condition
      stationarity_imbalance_condition = (norm((quantities.currentIterate.constraintFunctionEqualities'*quantities.currentIterate.constraintJacobianEqualities)',inf) <= ...
        D.stationarity_imbalance_tolerance_ * norm(quantities.currentIterate.objectiveGradient(quantities,'stochastic') + (quantities.currentIterate.multipliers('stochastic')'*quantities.currentIterate.constraintJacobianEqualities)',inf));
      
      % Dual update condition
      dual_update_condition = (norm(quantities.currentIterate.objectiveGradient(quantities,'stochastic') + ((quantities.currentIterate.multipliers('stochastic') + delta)'*quantities.currentIterate.constraintJacobianEqualities)',inf) <= D.residual_dual_tolerance_ * ...
        min(norm(quantities.currentIterate.objectiveGradient(quantities,'stochastic') + ((quantities.currentIterate.multipliers('stochastic'))'*quantities.currentIterate.constraintJacobianEqualities)',inf), ...
        norm([quantities.previousIterate.objectiveGradient(quantities,'stochastic') + ((quantities.previousIterate.multipliers('stochastic'))'*quantities.previousIterate.constraintJacobianEqualities)'; quantities.previousIterate.constraintFunctionEqualities],inf)));
      
      % Check termination tests
      if hessian_modification_condition

        % Set flag and termination test number and return
        out.flag = 1;
        out.tt = 0;

      elseif model_reduction_condition && dual_residual_condition && stepsize_residual_conditions && (~D.decompose_step_ || tangential_component_condition)
        
        % Set flag and termination test number and return
        out.flag = 1;
        out.tt = 1;
        
      elseif dual_residual_condition && stepsize_residual_conditions && tangential_component_condition && constraint_reduction_condition
          
        % Set flag and termination test number and return
        out.flag = 1;
        out.tt = 2;
        
      elseif stationarity_imbalance_condition && dual_update_condition
        
        % Set flag and termination test number and return
        out.flag = 1;
        out.tt = 3;
                
      end
      
    end
    
  end
  
end