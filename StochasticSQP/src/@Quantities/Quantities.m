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
    best_iterate_
    current_iterate_
    direction_primal_
    direction_dual_
    merit_parameter_
    model_reduction_
    previous_iterate_
    ratio_parameter_
    stepsize_
    trial_iterate_
    primal_residual_
    dual_residual_
    dual_residual_norm1_
    termination_test_number_
    
    
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
    diminishing_stepsize_level_counter_ = 0
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    scale_problem_
    compute_iterate_stationarity_
    objective_Lipschitz_
    constraint_Lipschitz_
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    Comparison_ratio_
    constraint_function_evaluation_limit_
    constraint_Jacobian_evaluation_limit_
    cpu_time_limit_
    curv_info_
    feasibility_tolerance_
    hessian_of_lagrangian_evaluation_limit_
    inner_iteration_relative_limit_
    iteration_limit_
    Lipschitz_estimate_iter_first_
    Lipschitz_estimate_iter_later_
    objective_function_evaluation_limit_
    objective_gradient_evaluation_limit_
    Progress_check_iter_
    Progress_ratio_
    scale_factor_gradient_limit_
    size_limit_
    stationarity_tolerance_
    batch_size_
    
    
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
    function s = CPUTimeLimit(Q)
      
      % Set return value
      s = Q.cpu_time_limit_;
      
    end % CPUTimeLimit
    
    % Check Stationarity Measure
    function s = checkStationarityMeasure(Q)
        
        % Set return value
        s = Q.compute_iterate_stationarity_;
        
    end % checkStationarityMeasure
    
    % Current iterate
    function iterate = currentIterate(Q)
      
      % Set return value
      iterate = Q.current_iterate_;
      
    end % currentIterate
    
    % Previous iterate
    function iterate = previousIterate(Q)
        
        % Set return value
        iterate = Q.previous_iterate_;
        
    end % previousIterate
    
    % Direction, primal
    function d = directionPrimal(Q)
      
      % Set return value
      d = Q.direction_primal_;
      
    end % directionPrimal
    
    % Direction, dual
    function d = directionDual(Q)
      
      % Set return value
      d = Q.direction_dual_;
      
    end % directionDual
    
    % Residual, primal
    function rho = residualPrimal(Q)
        
        % Set return value
        rho = Q.primal_residual_;
        
    end % residualPrimal
    
    % Residual, dual
    function r = residualDual(Q)
        
        % Set return value
        r = Q.dual_residual_;
        
    end % residualDual
    
    % Residual, dual, norm1
    function r_norm1 = residualDualNorm1(Q)
       
        % Set return value
        r_norm1 = Q.dual_residual_norm1_;
        
    end % residualDuanNorm1
    
    % Termination test number
    function termination_test_number = terminationTestNumber(Q)
        
        % Set return value
        termination_test_number = Q.termination_test_number_;
        
    end % terminationTestNumber
    
    % Diminishing stepsize level counter
    function level_counter = diminishingStepsizeLevelCounter(Q)
        
        % Set return value
        level_counter = Q.diminishing_stepsize_level_counter_;
        
    end % diminishingStepsizeLevelCounter
    
    % Iteration counter
    function k = iterationCounter(Q)
      
      % Set return value
      k = Q.iteration_counter_;
      
    end % iterationCounter
    
    % Iterative Solver Counter
    function k = iterativeSolverCounter(Q)
        
        % Set return value
        k = Q.iterative_solver_counter_;
        
    end % iterativeSolverCounter
    
    % Inner iteration counter
    function k = innerIterationCounter(Q)
      
      % Set return value
      k = Q.inner_iteration_counter_;
      
    end % innerIterationCounter
    
    % Iteration limit
    function k_max = iterationLimit(Q)
      
      % Set return value
      k_max = Q.iteration_limit_;
      
    end % iterationLimit
    
    % Inner iteration relative limit
    function k_max = innerIterationRelativeLimit(Q)
      
      % Set return value
      k_max = Q.inner_iteration_relative_limit_;
      
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
    
    % Ratio parameter
    function t = ratioParameter(Q)
      
      % Set return value
      t = Q.ratio_parameter_;
      
    end % ratioParameter
    
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
    
    % Feasibility tolerance
    function t = feasibilityTolerance(Q)
      
      % Set return value
      t = Q.feasibility_tolerance_;
      
    end % stationarityTolerance

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
    
    % Trial iterate
    function iterate = trialIterate(Q)
      
      % Set return value
      iterate = Q.trial_iterate_;
      
    end % trialIterate
    
    % Objective Lipschitz constants
    function objectiveLipschitz = objectiveLipschitzConstants(Q)
        
        % Set objective Lipschitz constants
        objectiveLipschitz = Q.objective_Lipschitz_;
        
    end % objectiveLipschitzConstants
    
    % Constraint Lipschitz constants
    function constraintLipschitz = constraintLipschitzConstants(Q)
        
        % Set constraint Lipschitz constants
        constraintLipschitz = Q.constraint_Lipschitz_;
        
    end % constraintLipschitzConstants
    
    % Lipschitz Estimate Itertion 1
    function iter_1 = lipschitzEstimateIterationFirst(Q)
        
        % Set Lipschitz Estimate Iteration 1
        iter_1 = Q.Lipschitz_estimate_iter_first_;
        
    end % lipschitzEstimateIterationFirst
    
    % Lipschitz Estimate Itertion 2
    function iter_2 = lipschitzEstimateIterationLater(Q)
        
        % Set Lipschitz Estimate Iteration 2
        iter_2 = Q.Lipschitz_estimate_iter_later_;
        
    end % lipschitzEstimateIterationLater
    
    % Progress Check Iteration
    function iter = progressCheckIteration(Q)
        
        % Set Progress Check Iteration
        iter = Q.Progress_check_iter_;
        
    end % progressCheckIteration
    
    % Progress Ratio
    function ratio = progressRatio(Q)
        
        % Set Progress Ratio
        ratio = Q.Progress_ratio_;
        
    end % progressRatio
    
    % Comparison Ratio
    function ratio = comparisonRatio(Q)
        
        % Set Comparison Ratio
        ratio = Q.Comparison_ratio_;
        
    end % comparisonRatio
    
    % Curvature Information
    function curv_info = curvatureInfo(Q)
        
        % Set curvature information
        curv_info = Q.curv_info_;
        
    end % curvatureInfo
    
    %%%%%%%%%%%%%%%
    % SET METHODS %
    %%%%%%%%%%%%%%%
    
    % Set batch size
    function setBatchSize(Q,batchSize)
        
        % Set batch size
        Q.batch_size_ = batchSize;
        
    end % setBatchSize
    
    % Set Lipschitz constants
    function setLipschitzConstants(Q,objectiveLipschitz,constraintLipschitz)
        
        % Set Lipschitz constants
        Q.objective_Lipschitz_ = objectiveLipschitz;
        Q.constraint_Lipschitz_ = constraintLipschitz;
        
    end % setLipschitzConstants
    
    % Set Inner Iteration Relative Limit
    function setInnerIterationRelativeLimit(Q,num)
        
        % Set Inner Iteration Relative Limit
        Q.inner_iteration_relative_limit_ = num;
        
    end % setInnerIterationRelativeLimit
    
    % Set direction, primal
    function setDirectionPrimal(Q,direction)
      
      % Set direction
      Q.direction_primal_ = direction;
      
    end % setDirectionPrimal
    
    % Set direction, dual
    function setDirectionDual(Q,direction)
      
      % Set direction
      Q.direction_dual_ = direction;
      
    end % setDirectionDual
    
    % Set residal, primal
    function setPrimalResidual(Q,primal_residual)
       
        % Set primal residual
        Q.primal_residual_ = primal_residual;
        
    end %setPrimalResidual
    
    % Set residal, dual
    function setDualResidual(Q,dual_residual)
       
        % Set primal residual
        Q.dual_residual_ = dual_residual;
        
    end %setDualResidual
    
    % Set residal, dual with 1-norm
    function setDualResidualNorm1(Q,dual_residual_norm1)
       
        % Set primal residual
        Q.dual_residual_norm1_ = dual_residual_norm1;
        
    end %setDualResidualNorm1
    
    % Set iterative solver counter
    function setIterativeSolverCounter(Q,iter)
        
        % Increment iterative solver counter
        Q.iterative_solver_counter_ = iter;
        
    end % setIterativeSolverCounter
    
    % Set termination test number
    function setTerminationTestNumber(Q,TTnum)
        
        % Set termination test number
        Q.termination_test_number_ = TTnum;
        
    end %setTerminationTestNumber
    
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
    
    % Set curvature information
    function setCurvature(Q,curv)
        
        % Set curvature information
        Q.curv_info_ = curv;
        
    end % setCurvature
    
    % Update iterate
    function updateIterate(Q)
        
        % check whether needs to update the best itearate
        if Q.compute_iterate_stationarity_
            
            % Update best iterate
            if (Q.best_iterate_.constraintNormInf(Q) > Q.feasibilityTolerance && ...
                    Q.current_iterate_.constraintNormInf(Q) < Q.best_iterate_.constraintNormInf(Q)) || ...
                    (Q.best_iterate_.constraintNormInf(Q) <= Q.feasibilityTolerance && ...
                    Q.current_iterate_.stationarityMeasure(Q,'true') <= Q.best_iterate_.stationarityMeasure(Q,'true'))
                Q.best_iterate_ = Q.current_iterate_;
            end
            
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
      
    end % incrementConstraintFunctionEqualitiesEvaluationCounter
    
    % Increment constraint Jacobian, equalities, evaluation counter
    function incrementConstraintJacobianEqualitiesEvaluationCounter(Q)
      
      % Increment constraint Jacobian, equalities, evaluation counter
      Q.constraint_Jacobian_equalities_evaluation_counter_ = Q.constraint_Jacobian_equalities_evaluation_counter_ + 1;
      
    end % incrementConstraintJacobianEqualitiesEvaluationCounter
    
    % Increment constraint Jacobian, inequalities, evaluation counter
    function incrementConstraintJacobianInequalitiesEvaluationCounter(Q)
      
      % Increment constraint Jacobian, inequalities, evaluation counter
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
    function incrementInnerIterationCounter(Q,iter)
      
      % Increment inner iteration counter
      Q.inner_iteration_counter_ = Q.inner_iteration_counter_ + iter;
      
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
    
  end % methods (public access)
  
end % Quantities