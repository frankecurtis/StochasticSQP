% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Quantities class
classdef Quantities < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ALGORITHM QUANTITIES %
    %%%%%%%%%%%%%%%%%%%%%%%%
    best_iterate_
    current_iterate_
    curvature_
    curvature_tangential_
    curvature_indicator_
    curvature_parameter_
    decomposition_parameter_
    direction_dual_
    direction_primal_
    direction_primal_normal_
    direction_primal_true_
    lipschitz_constraint_
    lipschitz_objective_
    merit_parameter_
    model_reduction_
    previous_iterate_
    ratio_parameter_
    residual_feasibility_
    residual_feasibility_normal_
    residual_feasibility_true_
    residual_stationarity_
    stepsize_
    stepsize_scaling_
    termination_test_
    trial_iterate_
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    batch_size_
    stepsize_diminishing_
    stepsize_scaling_initial_
    
    %%%%%%%%%%%%
    % COUNTERS %
    %%%%%%%%%%%%
    cg_iteration_counter_ = 0
    constraint_function_equalities_evaluation_counter_ = 0
    constraint_function_inequalities_evaluation_counter_ = 0
    constraint_Jacobian_equalities_evaluation_counter_ = 0
    constraint_Jacobian_inequalities_evaluation_counter_ = 0
    hessian_of_lagrangian_evaluation_counter_ = 0
    iteration_counter_ = 0
    matrix_factorization_counter_ = 0
    minres_iteration_counter_ = 0
    objective_function_evaluation_counter_ = 0
    objective_gradient_evaluation_counter_ = 0
    objective_gradient_true_evaluation_counter_ = 0
    termination_test_exact_counter_ = 0
    termination_test_1_counter_ = 0
    termination_test_2_counter_ = 0
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    compute_stationarity_true_
    scale_problem_
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    cg_iteration_relative_limit_
    constraint_function_evaluation_limit_
    constraint_Jacobian_evaluation_limit_
    cpu_time_limit_
    feasibility_tolerance_
    hessian_of_lagrangian_evaluation_limit_
    iteration_limit_
    kkt_error_tolerance_
    matrix_factorization_limit_
    minres_iteration_relative_limit_
    objective_function_evaluation_limit_
    objective_gradient_evaluation_limit_
    objective_gradient_true_evaluation_limit_
    scale_factor_gradient_limit_
    size_limit_
    
  end
  
  % Methods (static)
  methods (Static)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(options,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % CPU time
    function cpu = CPUTime
      
      % Set return value
      cpu = toc;
      
    end % CPUTime
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function Q = Quantities(varargin)
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(Q,reporter)
    
    % Print iteration values
    printIterationValues(Q,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(Q,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(Q,problem)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Batch size
    function batch_size = batchSize(Q)
      
      % Set return value
      batch_size = Q.batch_size_;
      
    end % batchSize
    
    % Best iterate
    function iterate = bestIterate(Q)
      
      % Set return value
      iterate = Q.best_iterate_;
      
    end % bestIterate
    
    % CG iteration counter
    function c = CGIterationCounter(Q)
      
      % Set return value
      c = Q.cg_iteration_counter_;
      
    end % CGIterationCounter
    
    % CG iteration relative limit
    function c = CGIterationRelativeLimit(Q)
      
      % Set return value
      c = Q.cg_iteration_relative_limit_;
      
    end % CGIterationRelativeLimit

    % Compute stationarity true measure?
    function b = computeStationarityTrue(Q)
      
      % Set return value
      b = Q.compute_stationarity_true_;
      
    end % computeStationarityTrue
    
    % Constraint function, equalities, evaluation counter
    function c = constraintFunctionEqualitiesEvaluationCounter(Q)
      
      % Set return value
      c = Q.constraint_function_equalities_evaluation_counter_;
      
    end % constraintFunctionEqualitiesEvaluationCounter
    
    % Constraint function, inequalities, evaluation counter
    function c = constraintFunctionInequalitiesEvaluationCounter(Q)
      
      % Set return value
      c = Q.constraint_function_inequalities_evaluation_counter_;
      
    end % constraintFunctionInequalitiesEvaluationCounter
    
    % Constraint function evaluation limit
    function c_max = constraintFunctionEvaluationLimit(Q)
      
      % Set return value
      c_max = Q.constraint_function_evaluation_limit_;
      
    end % constraintFunctionEvaluationLimit
    
    % Constraint Jacobian, equalities, evaluation counter
    function J = constraintJacobianEqualitiesEvaluationCounter(Q)
      
      % Set return value
      J = Q.constraint_Jacobian_equalities_evaluation_counter_;
      
    end % constraintJacobianEqualitiesEvaluationCounter
    
    % Constraint Jacobian, inequalities, evaluation counter
    function J = constraintJacobianInequalitiesEvaluationCounter(Q)
      
      % Set return value
      J = Q.constraint_Jacobian_inequalities_evaluation_counter_;
      
    end % constraintJacobianInequalitiesEvaluationCounter
    
    % ConstraintJacobian evaluation limit
    function J_max = constraintJacobianEvaluationLimit(Q)
      
      % Set return value
      J_max = Q.constraint_Jacobian_evaluation_limit_;
      
    end % constraintJacobianEvaluationLimit
    
    % CPU time limit
    function cpu_max = CPUTimeLimit(Q)
      
      % Set return value
      cpu_max = Q.cpu_time_limit_;
      
    end % CPUTimeLimit
    
    % Current iterate
    function iterate = currentIterate(Q)
      
      % Set return value
      iterate = Q.current_iterate_;
      
    end % currentIterate
    
    % Curvature
    function c = curvature(Q,type)
      
      % Set return value
      if strcmp(type,'full')
        c = Q.curvature_;
      elseif strcmp(type,'tangential')
        c = Q.curvature_tangential_;
      else
        error('Quantities: Invalid type for curvature.');
      end
      
    end % curvature
    
    % Curvature indicator
    function c = curvatureIndicator(Q)
      
      % Set return value
      c = Q.curvature_indicator_;
      
    end % curvatureIndicator
    
    % Curvature parameter
    function c = curvatureParameter(Q)
      
      % Set return value
      c = Q.curvature_parameter_;
      
    end % curvatureParameter
    
    % Decomposition parameter
    function d = decompositionParameter(Q)
      
      % Set return value
      d = Q.decomposition_parameter_;
      
    end % decompositionParameter
    
    % Direction, dual
    function d = directionDual(Q)
      
      % Set return value
      d = Q.direction_dual_;
      
    end % directionDual
    
    % Direction, primal
    function d = directionPrimal(Q,type)
      
      % Set return value
      if strcmp(type,'full')
        d = Q.direction_primal_;
      elseif strcmp(type,'normal')
        d = Q.direction_primal_normal_;
      elseif strcmp(type,'tangential')
        d = Q.direction_primal_ - Q.direction_primal_normal_;
      elseif strcmp(type,'true')
        d = Q.direction_primal_true_;
      else
        error('Quantities: Invalid type for directionPrimal.');
      end
      
    end % directionPrimal

    % Feasibility tolerance
    function t = feasibilityTolerance(Q)
      
      % Set return value
      t = Q.feasibility_tolerance_;
      
    end % feasibilityTolerance
    
    % Iteration counter
    function k = iterationCounter(Q)
      
      % Set return value
      k = Q.iteration_counter_;
      
    end % iterationCounter
    
    % Iteration limit
    function k_max = iterationLimit(Q)
      
      % Set return value
      k_max = Q.iteration_limit_;
      
    end % iterationLimit

    % KKT error tolerance
    function t = KKTErrorTolerance(Q)
      
      % Set return value
      t = Q.kkt_error_tolerance_;
      
    end % KKTErrorTolerance
    
    % Exceeded limit, CPU
    function b = limitExceededCPU(Q)
      
      % Check limit
      b = (Q.CPUTime >= Q.cpu_time_limit_);
      
    end % limitExceededCPU
    
    % Exceeded limit, evaluations
    function b = limitExceededEvaluations(Q)
      
      % Check limit
      b = (Q.constraint_function_equalities_evaluation_counter_ > Q.constraint_function_evaluation_limit_ || ...
        Q.constraint_function_inequalities_evaluation_counter_ > Q.constraint_function_evaluation_limit_ || ...
        Q.constraint_Jacobian_equalities_evaluation_counter_ > Q.constraint_Jacobian_evaluation_limit_ || ...
        Q.constraint_Jacobian_inequalities_evaluation_counter_ > Q.constraint_Jacobian_evaluation_limit_ || ...
        Q.hessian_of_lagrangian_evaluation_counter_ > Q.hessian_of_lagrangian_evaluation_limit_ || ...
        Q.objective_function_evaluation_counter_ > Q.objective_function_evaluation_limit_ || ...
        Q.objective_gradient_evaluation_counter_ > Q.objective_gradient_evaluation_limit_ || ...
        Q.objective_gradient_true_evaluation_counter_ > Q.objective_gradient_true_evaluation_limit_);
      
    end % limitExceededEvaluations
    
    % Exceeded limit, iterations
    function b = limitExceededIterations(Q)
      
      % Check limit
      b = (Q.iteration_counter_ > Q.iteration_limit_ || ...
        Q.matrix_factorization_counter_ > Q.matrix_factorization_limit_ || ...
        Q.cg_iteration_counter_ > Q.cg_iteration_relative_limit_ * (Q.current_iterate_.numberOfConstraintsEqualities + Q.current_iterate_.numberOfConstraintsInequalities) || ...
        Q.minres_iteration_counter_ > Q.minres_iteration_relative_limit_ * (Q.current_iterate_.numberOfVariables + Q.current_iterate_.numberOfConstraintsEqualities + Q.current_iterate_.numberOfConstraintsInequalities));
      
    end % limitExceededIterations
    
    % Exceeded limit, size
    function b = limitExceededSize(Q)
      
      % Check limit
      b = (Q.current_iterate_.numberOfVariables + ...
        Q.current_iterate_.numberOfConstraintsEqualities + ...
        Q.current_iterate_.numberOfConstraintsInequalities > ...
        Q.size_limit_);
      
    end % limitExceededSize

    % Lipschitz constant, constraint
    function lipschitz = lipschitzConstraint(Q)
      
      % Set return value
      lipschitz = Q.lipschitz_constraint_;
      
    end % lipschitzConstraint
    
    % Lipschitz constant, objective
    function lipschitz = lipschitzObjective(Q)
      
      % Set return value
      lipschitz = Q.lipschitz_objective_;
      
    end % lipschitzObjective
    
    % Matrix factorization counter
    function c = matrixFactorizationCounter(Q)
      
      % Set return value
      c = Q.matrix_factorization_counter_;
      
    end % matrixFactorizationCounter
    
    % Matrix factorization limit
    function c_max = matrixFactorizationLimit(Q)
      
      % Set return value
      c_max = Q.matrix_factorization_limit_;
      
    end % matrixFactorizationLimit

    % MINRES iteration counter
    function c = MINRESIterationCounter(Q)
      
      % Set return value
      c = Q.minres_iteration_counter_;
      
    end % MINRESIterationCounter
    
    % MINRES iteration relative limit
    function c_max = MINRESIterationRelativeLimit(Q)
      
      % Set return value
      c_max = Q.minres_iteration_relative_limit_;
      
    end % MINRESIterationRelativeLimit

    % Merit parameter
    function t = meritParameter(Q)
      
      % Set return value
      t = Q.merit_parameter_;
      
    end % meritParameter
    
    % Model reduction
    function q = modelReduction(Q)
      
      % Set return value
      q = Q.model_reduction_;
      
    end % modelReduction
    
    % Objective function evaluation counter
    function f = objectiveFunctionEvaluationCounter(Q)
      
      % Set return value
      f = Q.objective_function_evaluation_counter_;
      
    end % objectiveFunctionEvaluationCounter
    
    % Objective function evaluation limit
    function f_max = objectiveFunctionEvaluationLimit(Q)
      
      % Set return value
      f_max = Q.objective_function_evaluation_limit_;
      
    end % objectiveFunctionEvaluationLimit
    
    % Objective gradient evaluation counter
    function g = objectiveGradientEvaluationCounter(Q)
      
      % Set return value
      g = Q.objective_gradient_evaluation_counter_;
      
    end % objectiveGradientEvaluationCounter
    
    % Objective gradient, true, evaluation counter
    function g = objectiveGradientTrueEvaluationCounter(Q)
      
      % Set return value
      g = Q.objective_gradient_true_evaluation_counter_;
      
    end % objectiveGradientTrueEvaluationCounter
    
    % Objective gradient evaluation limit
    function g_max = objectiveGradientEvaluationLimit(Q)
      
      % Set return value
      g_max = Q.objective_gradient_evaluation_limit_;
      
    end % objectiveGradientEvaluationLimit
    
    % Objective gradient, true, evaluation limit
    function g_max = objectiveGradientTrueEvaluationLimit(Q)
      
      % Set return value
      g_max = Q.objective_gradient_true_evaluation_limit_;
      
    end % objectiveGradientTrueEvaluationLimit
    
    % Previous iterate
    function iterate = previousIterate(Q)
      
      % Set return value
      iterate = Q.previous_iterate_;
      
    end % previousIterate
    
    % Ratio parameter
    function t = ratioParameter(Q)
      
      % Set return value
      t = Q.ratio_parameter_;
      
    end % ratioParameter
    
    % Residual, feasibility
    function residual = residualFeasibility(Q,type)
      
      % Set return value
      if strcmp(type,'full')
        residual = Q.residual_feasibility_;
      elseif strcmp(type,'normal')
        residual = Q.residual_feasibility_normal_;
      elseif strcmp(type,'true')
        residual = Q.residual_feasibility_true_;
      else
        error('Quantities: Invalid type for residualFeasibility.');
      end
      
    end % residualFeasibility
    
    % Residual, stationarity
    function residual = residualStationarity(Q)
      
      % Set return value
      residual = Q.residual_stationarity_;
      
    end % residualStationarity
    
    % Scale factor gradient limit
    function s_max = scaleFactorGradientLimit(Q)
      
      % Set return value
      s_max = Q.scale_factor_gradient_limit_;
      
    end % scaleFactorGradientLimit
    
    % Scale problem
    function b = scaleProblem(Q)
      
      % Set return value
      b = Q.scale_problem_;
      
    end % scaleProblem
    
    % Size limit
    function s_max = sizeLimit(Q)
      
      % Set return value
      s_max = Q.size_limit_;
      
    end % sizeLimit
    
    % Stationarity satisfied
    function b = stationaritySatisfied(Q)
      
      % Check condition
      b = (Q.best_iterate_.constraintNormInf(Q) <= Q.feasibility_tolerance_ && ...
        Q.best_iterate_.KKTError(Q,'true') <= Q.kkt_error_tolerance_);
      
    end % stationaritySatisfied
    
    % Stepsize
    function a = stepsize(Q)
      
      % Set return value
      a = Q.stepsize_;
      
    end % stepsize
    
    % Stepsize scaling
    function a = stepsizeScaling(Q)
      
      % Set return value
      a = Q.stepsize_scaling_initial_;
      if Q.stepsize_diminishing_ == true
        a = a / (Q.iteration_counter_ + 1);
      end
      
    end % stepsizeScaling
    
    % Termination test
    function termination_test = terminationTest(Q)
      
      % Set return value
      termination_test = Q.termination_test_;
      
    end % terminationTest
    
    % Termination test
    function c = terminationTestCounter(Q,i)
      
      % Set return value
      if i == 0
        c = Q.termination_test_exact_counter_;
      elseif i == 1
        c = Q.termination_test_1_counter_;
      elseif i == 2
        c = Q.termination_test_2_counter_;
      else
        error('Quantities: Invalid index for terminationTestCounter.');
      end
      
    end % terminationTestCounter
    
    % Trial iterate
    function iterate = trialIterate(Q)
      
      % Set return value
      iterate = Q.trial_iterate_;
      
    end % trialIterate
    
    %%%%%%%%%%%%%%%
    % SET METHODS %
    %%%%%%%%%%%%%%%
    
    % Set batch size
    function setBatchSize(Q,batch_size)
      
      % Set batch size
      Q.batch_size_ = batch_size;
      
    end % setBatchSize
    
    % Set curvature
    function setCurvature(Q,curvature,type)
      
      % Set curvature information
      if strcmp(type,'full')
        Q.curvature_ = curvature;
      elseif strcmp(type,'tangential')
        Q.curvature_tangential_ = curvature;
      else
        error('Quantities: Invalid type for setCurvature.');
      end
      
    end % setCurvature
    
    % Set curvature indicator
    function setCurvatureIndicator(Q,indicator)
      
      % Set indicator
      Q.curvature_indicator_ = indicator;
      
    end % setCurvatureIndicator
    
    % Set direction, primal
    function setDirectionPrimal(Q,direction,type)
      
      % Set direction
      if strcmp(type,'full')
        Q.direction_primal_ = direction;
      elseif strcmp(type,'normal')
        Q.direction_primal_normal_ = direction;
      elseif strcmp(type,'true')
        Q.direction_primal_true_ = direction;
      else
        error('Quantities: Invalid type for setDirectionPrimal.');
      end
      
    end % setDirectionPrimal
    
    % Set Lipschitz
    function setLipschitz(Q,lipschitz_constraint,lipschitz_objective)
      
      % Set Lipschitz
      Q.lipschitz_constraint_ = lipschitz_constraint;
      Q.lipschitz_objective_ = lipschitz_objective;
      
    end % setLipschitz
    
    % Set merit parameter
    function setMeritParameter(Q,merit_parameter)
      
      % Set merit parameter
      Q.merit_parameter_ = merit_parameter;
      
    end % setMeritParameter
    
    % Set model reduction
    function setModelReduction(Q,model_reduction)
      
      % Set model reduction
      Q.model_reduction_ = model_reduction;
      
    end % setModelReduction
    
    % Set ratio parameter
    function setRatioParameter(Q,ratio_parameter)
      
      % Set ratio parameter
      Q.ratio_parameter_ = ratio_parameter;
      
    end % setRatioParameter
    
    % Set residal, feasibility
    function setResidualFeasibility(Q,residual,type)
      
      % Set residual, feasibility
      if strcmp(type,'full')
        Q.residual_feasibility_ = residual;
      elseif strcmp(type,'normal')
        Q.residual_feasibility_normal_ = residual;
      elseif strcmp(type,'true')
        Q.residual_feasibility_true_ = residual;
      else
        error('Quantities: Invalid type for setResidualFeasibility.');
      end
      
    end %setResidualFeasibility
    
    % Set residal, stationarity
    function setResidualStationarity(Q,residual)
      
      % Set residual, stationarity
      Q.residual_stationarity_ = residual;
      
    end %setResidualStationarity
    
    % Set stepsize
    function setStepsize(Q,stepsize)
      
      % Set stepsize
      Q.stepsize_ = stepsize;
      
    end % setStepsize
    
    % Set termination test
    function setTerminationTest(Q,tt)
      
      % Set termination test
      Q.termination_test_ = tt;
      
    end %setTerminationTest
    
    % Set trial iterate
    function setTrialIterate(Q,iterate)
      
      % Set trial iterate
      Q.trial_iterate_ = iterate;
      
    end % setTrialIterate
    
    % Update iterate
    function updateIterate(Q)
      
      % Update best iterate
      if (Q.best_iterate_.constraintNormInf(Q) > Q.feasibilityTolerance && ...
          Q.current_iterate_.constraintNormInf(Q) < Q.best_iterate_.constraintNormInf(Q)) || ...
          (Q.best_iterate_.constraintNormInf(Q) <= Q.feasibilityTolerance && ...
          Q.current_iterate_.KKTError(Q,'true') <= Q.best_iterate_.KKTError(Q,'true'))
        Q.best_iterate_ = Q.current_iterate_;
      end
      
      % Set previous iterate to current iterate
      Q.previous_iterate_ = Q.current_iterate_;
      
      % Set current iterate to trial iterate
      Q.current_iterate_ = Q.trial_iterate_;
      
    end % updateIterate
    
    %%%%%%%%%%%%%%%%%%%%%
    % INCREMENT METHODS %
    %%%%%%%%%%%%%%%%%%%%%
    
    % Increment CG iteration counter
    function incrementCGIterationCounter(Q)
      
      % Increment CG iteration counter
      Q.cg_iteration_counter_ = Q.cg_iteration_counter_ + 1;
      
    end % incrementCGIterationCounter
    
    % Increment constraint function, equalities, evaluation counter
    function incrementConstraintFunctionEqualitiesEvaluationCounter(Q)
      
      % Increment constraint function, equalities, evaluation counter
      Q.constraint_function_equalities_evaluation_counter_ = Q.constraint_function_equalities_evaluation_counter_ + 1;
      
    end % incrementConstraintFunctionEqualitiesEvaluationCounter
    
    % Increment constraint function, inequalities, evaluation counter
    function incrementConstraintFunctionInequalitiesEvaluationCounter(Q)
      
      % Increment constraint function, inequalities, evaluation counter
      Q.constraint_function_inequalities_evaluation_counter_ = Q.constraint_function_inequalities_evaluation_counter_ + 1;
      
    end % incrementConstraintFunctionInequalitiesEvaluationCounter
    
    % Increment constraint Jacobian, equalities, evaluation counter
    function incrementConstraintJacobianEqualitiesEvaluationCounter(Q)
      
      % Increment constraint Jacobian, equalities, evaluation counter
      Q.constraint_Jacobian_equalities_evaluation_counter_ = Q.constraint_Jacobian_equalities_evaluation_counter_ + 1;
      
    end % incrementConstraintJacobianEqualitiesEvaluationCounter
    
    % Increment constraint Jacobian, inequalities, evaluation counter
    function incrementConstraintJacobianInequalitiesEvaluationCounter(Q)
      
      % Increment constraint Jacobian inequalities, evaluation counter
      Q.constraint_Jacobian_inequalities_evaluation_counter_ = Q.constraint_Jacobian_inequalities_evaluation_counter_ + 1;
      
    end % incrementConstraintJacobianInequalitiesEvaluationCounter
    
    % Increment Hessian of Lagrangian evaluation counter
    function incrementHessianOfLagrangianEvaluationCounter(Q)
      
      % Increment Hessian of Lagrangian evaluation counter
      Q.hessian_of_lagrangian_evaluation_counter_ = Q.hessian_of_lagrangian_evaluation_counter_ + 1;
      
    end % incrementHessianOfLagrangianEvaluationCounter
    
    % Increment iteration counter
    function incrementIterationCounter(Q)
      
      % Increment iteration counter
      Q.iteration_counter_ = Q.iteration_counter_ + 1;
      
    end % incrementIterationCounter
    
    % Increment matrix factorization counter
    function incrementMatrixFactorizationCounter(Q)
      
      % Increment matrix factorization counter
      Q.matrix_factorization_counter_ = Q.matrix_factorization_counter_ + 1;
      
    end % incrementMatrixFactorizationCounter
    
    % Increment MINRES iteration counter
    function incrementMINRESIterationCounter(Q)
      
      % Increment MINRES iteration counter counter
      Q.minres_iteration_counter_ = Q.minres_iteration_counter_ + 1;
      
    end % incrementMINRESIterationCounter
    
    % Increment objective function evaluation counter
    function incrementObjectiveFunctionEvaluationCounter(Q)
      
      % Increment objective function evaluation counter
      Q.objective_function_evaluation_counter_ = Q.objective_function_evaluation_counter_ + 1;
      
    end % incrementObjectiveFunctionEvaluationCounter
    
    % Increment objective gradient evaluation counter
    function incrementObjectiveGradientEvaluationCounter(Q)
      
      % Increment objective gradient evaluation counter
      Q.objective_gradient_evaluation_counter_ = Q.objective_gradient_evaluation_counter_ + 1;
      
    end % incrementObjectiveGradientEvaluationCounter
    
    % Increment objective gradient, true, evaluation counter
    function incrementObjectiveGradientTrueEvaluationCounter(Q)
      
      % Increment objective gradient, true, evaluation counter
      Q.objective_gradient_true_evaluation_counter_ = Q.objective_gradient_true_evaluation_counter_ + 1;
      
    end % incrementObjectiveGradientEvaluationCounter

    % Increment termination test counter
    function incrementTerminationTestCounter(Q,i)
      
      % Set return value
      if i == 0
        Q.termination_test_exact_counter_ = Q.termination_test_exact_counter_ + 1;
      elseif i == 1
        Q.termination_test_1_counter_ = Q.termination_test_1_counter_ + 1;
      elseif i == 2
        Q.termination_test_2_counter_ = Q.termination_test_2_counter_ + 1;
      else
        error('Quantities: Invalid index for incrementTerminationTestCounter.');
      end
      
    end % incrementTerminationTestCounter

  end % methods (public access)
  
end % Quantities