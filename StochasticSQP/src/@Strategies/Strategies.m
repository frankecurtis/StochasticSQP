% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Strategies class
classdef Strategies < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    direction_computation_
    lipschitz_estimation_
    merit_parameter_computation_
    stepsize_computation_
    
  end
  
  % Methods (static)
  methods (Static)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(options,reporter)
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function S = Strategies
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(S,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(S,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(S,options,quantities,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Direction computation
    function d = directionComputation(S)
      
      % Set return value
      d = S.direction_computation_;
      
    end % directionComputation
    
    % Lipschitz Estimation
    function s = lipschitzEstimation(S)
      
      % Set return value
      s = S.lipschitz_estimation_;
      
    end % LipschitzEstimation
    
    % Merit parameter computation
    function m = meritParameterComputation(S)
      
      % Set return value
      m = S.merit_parameter_computation_;
      
    end % meritParameterComputation
    
    % Stepsize computation
    function s = stepsizeComputation(S)
      
      % Set return value
      s = S.stepsize_computation_;
      
    end % stepsizeComputation
    
  end % methods (public access)
  
end % Strategies