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
    current_iterate_
    direction_
    merit_parameter_
    model_reduction_
    multiplier_
    stepsize_
    trial_iterate_
    
    %%%%%%%%%%%%
    % COUNTERS %
    %%%%%%%%%%%%
    constraint_function_evaluation_counter_ = 0
    constraint_Jacobian_evaluation_counter_ = 0
    iteration_counter_ = 0
    inner_iteration_counter_ = 0
    objective_function_evaluation_counter_ = 0
    objective_gradient_evaluation_counter_ = 0
    total_inner_iteration_counter_ = 0
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    scale_problem_
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    cpu_time_limit_
    constraint_function_evaluation_limit_
    constraint_Jacobian_evaluation_limit_
    iteration_limit_
    objective_function_evaluation_limit_
    objective_gradient_evaluation_limit_
    scale_factor_gradient_limit_
    stationarity_tolerance_
    
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
    function s = CPUTime
      
      % Set return value
      s = toc;
      
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
    
    % Constraint function evaluation counter
    function c = constraintFunctionEvaluationCounter(Q)
      
      % Set return value
      c = Q.constraint_function_evaluation_counter_;
      
    end % constraintFunctionEvaluationCounter
    
    % Constraint function evaluation limit
    function c_max = constraintFunctionEvaluationLimit(Q)
      
      % Set return value
      c_max = Q.constraint_function_evaluation_limit_;
      
    end % constraintFunctionEvaluationLimit
    
    % Constraint Jacobian evaluation counter
    function J = constraintJacobianEvaluationCounter(Q)
      
      % Set return value
      J = Q.constraint_Jacobian_evaluation_counter_;
      
    end % constraintJacobianEvaluationCounter
    
    % ConstraintJacobian evaluation limit
    function J_max = constraintJacobianEvaluationLimit(Q)
      
      % Set return value
      J_max = Q.constraint_Jacobian_evaluation_limit_;
      
    end % constraintJacobianEvaluationLimit
    
    % CPU time limit
    function s = CPUTimeLimit(Q)
      
      % Set return value
      s = Q.cpu_time_limit_;
      
    end % CPUTimeLimit
    
    % Current iterate
    function iterate = currentIterate(Q)
      
      % Set return value
      iterate = Q.current_iterate_;
      
    end % currentIterate
    
    % Direction
    function d = direction(Q)
      
      % Set return value
      d = Q.direction_;
      
    end % direction
    
    % Inner iteration counter
    function k = innerIterationCounter(Q)
      
      % Set return value
      k = Q.inner_iteration_counter_;
      
    end % innerIterationCounter
    
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
    
    % Multiplier
    function y = multiplier(Q)
      
      % Set return value
      y = Q.multiplier_;
      
    end % multiplier
    
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
    
    % Objective gradient evaluation limit
    function g_max = objectiveGradientEvaluationLimit(Q)
      
      % Set return value
      g_max = Q.objective_gradient_evaluation_limit_;
      
    end % objectiveGradientEvaluationLimit
    
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
    
    % Stationarity tolerance
    function t = stationarityTolerance(Q)
      
      % Set return value
      t = Q.stationarity_tolerance_;
      
    end % stationarityTolerance
    
    % Stepsize
    function a = stepsize(Q)
      
      % Set return value
      a = Q.stepsize_;
      
    end % stepsize
    
    % Total inner iteration counter
    function k = totalInnerIterationCounter(Q)
      
      % Set return value
      k = Q.total_inner_iteration_counter_;
      
    end % totalInnerIterationCounter
    
    % Trial iterate
    function iterate = trialIterate(Q)
      
      % Set return value
      iterate = Q.trial_iterate_;
      
    end % trialIterate
    
    %%%%%%%%%%%%%%%
    % SET METHODS %
    %%%%%%%%%%%%%%%
    
    % Set direction
    function setDirection(Q,direction)
      
      % Set direction
      Q.direction_ = direction;
      
    end % setDirection
    
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
    
    % Set multiplier
    function setMultiplier(Q,multiplier)
      
      % Set multiplier
      Q.multiplier_ = multiplier;
      
    end % setMultiplier
    
    % Set stepsize
    function setStepsize(Q,stepsize)
      
      % Set stepsize
      Q.stepsize_ = stepsize;
      
    end % setStepsize
    
    % Set trial iterate
    function setTrialIterate(Q,iterate)
      
      % Set trial iterate
      Q.trial_iterate_ = iterate;
      
    end % setTrialIterate
    
    % Update iterate
    function updateIterate(Q)
      
      % Set current iterate to trial iterate
      Q.current_iterate_ = Q.trial_iterate_;
      
    end % updateIterate
    
    %%%%%%%%%%%%%%%%%%%%%
    % INCREMENT METHODS %
    %%%%%%%%%%%%%%%%%%%%%
    
    % Increment constraint function evaluation counter
    function incrementConstraintFunctionEvaluationCounter(Q)
      
      % Increment constraint function evaluation counter
      Q.constraint_function_evaluation_counter_ = Q.constraint_function_evaluation_counter_ + 1;
      
    end % incrementConstraintFunctionEvaluationCounter
    
    % Increment constraint Jacobian evaluation counter
    function incrementConstraintJacobianEvaluationCounter(Q)
      
      % Increment constraint Jacobian evaluation counter
      Q.constraint_Jacobian_evaluation_counter_ = Q.constraint_Jacobian_evaluation_counter_ + 1;
      
    end % incrementConstraintJacobianEvaluationCounter
    
    % Increment iteration counter
    function incrementIterationCounter(Q)
      
      % Increment iteration counter
      Q.iteration_counter_ = Q.iteration_counter_ + 1;
      
    end % incrementIterationCounter
    
    % Increment inner iteration counter
    function incrementInnerIterationCounter(Q)
      
      % Increment inner iteration counter
      Q.inner_iteration_counter_ = Q.inner_iteration_counter_ + 1;
      
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
    
    % Increment total inner iteration counter
    function incrementTotalInnerIterationCounter(Q)
      
      % Increment total inner iteration counter
      Q.total_inner_iteration_counter_ = Q.total_inner_iteration_counter_ + Q.inner_iteration_counter_;
      
    end % incrementTotalInnerIterationCounter
    
    % Reset inner iteration counter
    function resetInnerIterationCounter(Q)
      
      % Reset inner iteration counter
      Q.inner_iteration_counter_ = 0;
      
    end % resetInnerIterationCounter
    
  end % methods (public access)
  
end % Quantities