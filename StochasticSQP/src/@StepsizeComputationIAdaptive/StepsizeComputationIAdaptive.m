% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationIAdaptive class
classdef StepsizeComputationIAdaptive < StepsizeComputation
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%
    % NAME %
    %%%%%%%%
    n = 'IAdaptive'
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    objective_Lipschitz_
    constraint_Lipschitz_
    projection_width_
    stepsize_diminishing_
    stepsize_scaling_
    sufficient_decrease_
    forward_lengthening_
    
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
    function S = StepsizeComputationIAdaptive
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(S,reporter)
    
    % Print iteration values
    printIterationValues(S,quantities,reporter)
    
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
    
    % Compute stepsize
    computeStepsize(D,options,quantities,reporter,strategies)
    
  end % methods (public access)
  
end % StepsizeComputationIAdaptive