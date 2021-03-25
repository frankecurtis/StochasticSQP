% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationFixed class
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
    FD_full_samples_
    FD_Lipschitz_estimate_iter_first_
    FD_Lipschitz_estimate_iter_later_
    FD_Lipschitz_estimate_sample_distance_
    FD_seed_ = 0 % random seed
    
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
  
end % Options