% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP class
classdef DirectionComputationIQP < DirectionComputation
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%
    % NAME %
    %%%%%%%%
    n = 'IQP'
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    cg_iteration_relative_limit_
    cg_residual_tolerance_
    cg_trust_region_factor_
    compute_true_
    constraint_reduction_tolerance_
    constraint_regularization_
    curvature_threshold_
    decompose_step_
    decomposition_threshold_
    model_reduction_tolerance_constraints_
    model_reduction_tolerance_objective_
    modification_factor_
    modification_limit_
    residual_dual_tolerance_
    residual_tolerance_factor_
    residual_tolerance_minimum_
    stationarity_imbalance_tolerance_
    stepsize_residual_dual_tolerance_
    stepsize_residual_primal_tolerance_
    tangential_objective_tolerance_
    termination_test_iteration_frequency_
    termination_test_iteration_minimum_
    use_hessian_of_lagrangian_
    use_iterative_solver_
    trust_region_feasibility_factor_
    trust_region_optimality_factor_
    
  end % properties (private access)
  
  % Methods (static)
  methods (Static)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(options,reporter)
    
  end % methods (static)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function D = DirectionComputationIQP
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(D,reporter)
    
    % Print iteration values
    printIterationValues(D,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(D,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(D,options,quantities,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Name
    function n = name(D)
      
      % Set return value
      n = D.n;
      
    end % name
    
    %%%%%%%%%%%%%%%%%%%
    % COMPUTE METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Compute direction
    err = computeDirection(D,options,quantities,reporter,strategies)
    
  end % methods (public access)
  
end % DirectionComputationEQP