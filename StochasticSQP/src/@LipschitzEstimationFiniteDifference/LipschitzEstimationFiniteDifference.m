% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% LipschitzEstimationFiniteDifference class
classdef LipschitzEstimationFiniteDifference < LipschitzEstimation
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%
    % NAME %
    %%%%%%%%
    n = 'FiniteDifference'
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    coordinate_directions_
    displacement_
    estimate_always_until_
    estimate_frequency_
    lipschitz_constraint_initial_
    lipschitz_constraint_minimum_
    lipschitz_objective_initial_
    lipschitz_objective_minimum_
    random_direction_
    seed_ = 0
    use_true_gradient_
    
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
    function L = LipschitzEstimationFiniteDifference
      
      % Do Nothing
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(L,reporter)
    
    % Print iteration values
    printIterationValues(L,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(L,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(L,options,quantities,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Name
    function n = name(L)
      
      % Set return value
      n = L.n;
      
    end % name
    
    %%%%%%%%%%%%%%%%%%%
    % COMPUTE METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Compute Lipschitz constants
    estimateLipschitzConstants(L,options,quantities,reporter,strategies)
    
  end % methods (public access)
  
end % LipschitzEstimationFiniteDifference