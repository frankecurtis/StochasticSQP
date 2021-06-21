% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Quantities class
classdef Quantities < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ALGORITHM QUANTITIES %
    %%%%%%%%%%%%%%%%%%%%%%%%
    batch_size_
    best_iterate_
    current_iterate_
    curvature_
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
    termination_test_
    trial_iterate_
    
    %%%%%%%%%%%%
    % COUNTERS %
    %%%%%%%%%%%%
    constraint_function_equalities_evaluation_counter_ = 0
    constraint_function_inequalities_evaluation_counter_ = 0
    constraint_Jacobian_equalities_evaluation_counter_ = 0
    constraint_Jacobian_inequalities_evaluation_counter_ = 0
    hessian_of_lagrangian_evaluation_counter_ = 0
    iteration_counter_ = 0
    iterative_solver_counter_ = 0
    inner_iteration_counter_ = 0
    objective_function_evaluation_counter_ = 0
    objective_gradient_evaluation_counter_ = 0
    objective_gradient_true_evaluation_counter_ = 0
    diminishing_stepsize_level_counter_ = 0
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    compute_stationarity_true_
    scale_problem_
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    constraint_function_evaluation_limit_
    constraint_Jacobian_evaluation_limit_
    cpu_time_limit_
    feasibility_tolerance_
    hessian_of_lagrangian_evaluation_limit_
    inner_iteration_relative_limit_
    iteration_limit_
    kkt_error_tolerance_
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
    function c = curvature(Q)
      
      % Set return value
      c = Q.curvature_;
      
    end % curvature
    
    % Diminishing stepsize level counter
    function c = diminishingStepsizeLevelCounter(Q)
      
      % Set return value
      c = Q.diminishing_stepsize_level_counter_;
      
    end % diminishingStepsizeLevelCounter
    
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
    
    % Inner iteration counter
    function k = innerIterationCounter(Q)
      
      % Set return value
      k = Q.inner_iteration_counter_;
      
    end % innerIterationCounter
    
    % Inner iteration relative limit
    function k_max = innerIterationRelativeLimit(Q)
      
      % Set return value
      k_max = Q.inner_iteration_relative_limit_;
      
    end % iterationLimit
    
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
    
    % Stepsize
    function a = stepsize(Q)
      
      % Set return value
      a = Q.stepsize_;
      
    end % stepsize
    
    % Termination test
    function termination_test = terminationTest(Q)
      
      % Set return value
      termination_test = Q.termination_test_;
      
    end % terminationTest
    
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
    function setCurvature(Q,curvature)
      
      % Set curvature information
      Q.curvature_ = curvature;
      
    end % setCurvature
    
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
    
    % Increment diminishing stepsize level counter
    function incrementDiminishingStepsizeLevelCounter(Q)
      
      % Increment diminishing stepsize level counter
      Q.diminishing_stepsize_level_counter_ = Q.diminishing_stepsize_level_counter_ + 1;
      
    end % incrementDiminishingStepsizeLevelCounter
    
    % Increment iteration counter
    function incrementIterationCounter(Q)
      
      % Increment iteration counter
      Q.iteration_counter_ = Q.iteration_counter_ + 1;
      
    end % incrementIterationCounter
    
    % Increment inner iteration counter
    function incrementInnerIterationCounter(Q,iterations)
      
      % Increment inner iteration counter
      Q.inner_iteration_counter_ = Q.inner_iteration_counter_ + iterations;
      
    end % incrementInnerIterationCounter
    
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
    
  end % methods (public access)
  
end % Quantities