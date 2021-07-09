% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationFixed class
classdef ParameterComputationFixed < ParameterComputation
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%
    % NAME %
    %%%%%%%%
    n = 'Fixed'

    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    quadratic_model_

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
    function P = ParameterComputationFixed
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(P,reporter)
    
    % Print iteration values
    printIterationValues(P,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(P,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(P,options,quantities,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Name
    function n = name(P)
      
      % Set return value
      n = P.n;
      
    end % name
    
    %%%%%%%%%%%%%%%%%%%
    % COMPUTE METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Compute parameters
    computeParameter(P,options,quantities,reporter,strategies)
    
  end % methods (public access)
  
end % ParameterComputationFixed