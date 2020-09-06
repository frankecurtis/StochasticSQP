% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% ProblemSimple class
classdef ProblemSimple < Problem
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemSimple
      
      % DO NOTHING
      
    end % Constructor
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Evaluate objective function
      f = x(1)^2 + x(2)^2;
      
      % No error
      err = false;
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x)
      
      % Evaluate objective gradient
      g = 2*[x(1); x(2)];
      
      % No error
      err = false;
      
    end % evaluateObjectiveGradient
    
    % Constraint function
    function [c,err] = evaluateConstraintFunction(P,x)
      
      % Evaluate constraint function
      c = x(1) + x(2) - 1;
      
      % No error
      err = false;
      
    end % evaluateConstraintFunction
    
    % Constraint Jacobian
    function [J,err] = evaluateConstraintJacobian(P,~)
      
      % Evaluate constraint Jacobian
      J = [1 1];
      
      % No error
      err = false;
      
    end % evaluateConstraintJacobian
    
    % Hessian of the Lagrangian
    function [H,err] = evaluateHessianOfLagrangian(P,~,~)
      
      % Evaluate Hessian of Lagrangian
      H = eye(2);
      
      % No error
      err = false;
      
    end % evaluateHessianOfLagrangian
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = [4; 2];
      
    end % initialPoint
    
    % Number of constraints
    function m = numberOfConstraints(P)
      
      % Set number of constraints
      m = 1;
      
    end % numberOfConstraints
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = 2;
      
    end % numberOfVariables
    
  end % methods (public access)
  
end % ProblemSimple