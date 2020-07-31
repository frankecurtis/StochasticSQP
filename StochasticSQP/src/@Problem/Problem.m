% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Problem class
classdef Problem < handle
    
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function P = Problem
      
      % Initialize here
      
    end
        
  end
  
  % Methods (static)
  methods (Static)
    
    % Objective function
    function f = evaluateObjectiveFunction(x)
      
      % Evaluate objective function
      f = x(1)^2 + x(2)^2;
      
    end % evaluateObjectiveFunction

    % Objective gradient
    function g = evaluateObjectiveGradient(x)
      
      % Evaluate objective gradient
      g = 2*[x(1); x(2)];
      
    end % evaluateObjectiveGradient

    % Constraint function
    function c = evaluateConstraintFunction(x)
      
      % Evaluate constraint function
      c = x(1) + x(2) - 1;
      
    end % evaluateConstraintFunction

    % Constraint Jacobian
    function J = evaluateConstraintJacobian(~)
      
      % Evaluate constraint Jacobian
      J = [1 1];
      
    end % evaluateConstraintJacobian
    
    % Initial point
    function x = initialPoint
      
      % Set initial point
      x = [4; 2];
      
    end % initialPoint
    
    % Number of constraints
    function m = numberOfConstraints
      
      % Set number of constraints
      m = 1;
      
    end % numberOfConstraints
    
    % Number of variables
    function n = numberOfVariables
      
      % Set number of variables
      n = 2;
      
    end % numberOfVariables
    
  end
  
end