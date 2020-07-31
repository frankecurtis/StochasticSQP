% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Iterate class
classdef Iterate < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % PROBLEM %
    %%%%%%%%%%%
    P % Problem object
    
    %%%%%%%%%%%%%%
    % QUANTITIES %
    %%%%%%%%%%%%%%
    n % number of variables
    m % number of constraints
    x % primal point
    f % objective function value
    g % objective gradient value
    c % constraint function value
    J % constraint Jacobian value
    
    %%%%%%%%%%%%%%%%%
    % SCALE FACTORS %
    %%%%%%%%%%%%%%%%%
    f_scale
    c_scale

    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    f_evaluated = false
    g_evaluated = false
    c_evaluated = false
    J_evaluated = false
    scales_set  = false
        
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function I = Iterate(P)
      
      % Set problem
      I.P = P;
      
      % Set initial point
      I.x = I.P.initialPoint;
      
      % Set number of variables
      I.n = I.P.numberOfVariables;
      
      % Set number of constraints
      I.m = I.P.numberOfConstraints;
      
      % Initialize scale factors
      I.f_scale = 1.0;
      I.c_scale = ones(I.m,1);
      
    end % Constructor
    
    % Constraint function
    function c = constraintFunction(I)
      
      % Check if scales have been set
      if ~I.scales_set
        error('Iterate: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~I.c_evaluated
        
        % Evaluate
        I.c = I.c_scale .* I.P.evaluateConstraintFunction(I.x);
        
        % Set indicator
        I.c_evaluated = true;
        
      end
      
      % Set constraint function value
      c = I.c;
      
    end % constraintFunction
    
    % Objective Jacobian
    function J = constraintJacobian(I)
      
      % Check if scales have been set
      if ~I.scales_set
        error('Iterate: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~I.J_evaluated
        
        % Evaluate
        I.J = I.c_scale .* I.P.evaluateConstraintJacobian(I.x);
        
        % Set indicator
        I.J_evaluated = true;
        
      end
      
      % Set constraint Jacobian value
      J = I.J;
      
    end % end constraintJacobian
    
    % Determine scale factors
    function determineScaleFactors(I,gradient_norm_limit)
      
      % Evaluate objective gradient
      gradient = I.P.evaluateObjectiveGradient(I.x);
      
      % Set objective scale factor
      I.f_scale = gradient_norm_limit/max(gradient_norm_limit,norm(gradient,inf));
      
      % Evaluate constraint Jacobian
      Jacobian = I.P.evaluateConstraintJacobian(I.x);
      
      % Set constraint scale factor
      I.c_scale = gradient_norm_limit/max(gradient_norm_limit,vecnorm(Jacobian,inf,2));
      
      % Scales set
      I.scales_set = true;
      
    end
    
    % Objective function
    function f = objectiveFunction(I)
      
      % Check if scales have been set
      if ~I.scales_set
        error('Iterate: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~I.f_evaluated
        
        % Evaluate
        I.f = I.f_scale * I.P.evaluateObjectiveFunction(I.x);
        
        % Set indicator
        I.f_evaluated = true;
        
      end
      
      % Set objective function value
      f = I.f;
      
    end % objectiveFunction
    
    % Objective gradient
    function g = objectiveGradient(I)

      % Check if scales have been set
      if ~I.scales_set
        error('Iterate: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~I.g_evaluated
        
        % Evaluate
        I.g = I.f_scale * I.P.evaluateObjectiveGradient(I.x);
        
        % Set indicator
        I.g_evaluated = true;
        
      end
      
      % Set objective gradient value
      g = I.g;
      
    end % end objectiveGradient
    
    % Point
    function x = point(I)
      
      % Set point
      x = I.x;
      
    end
    
    % Set point
    function setPoint(I,x)
      
      % Check length
      if length(x) ~= I.n
        error('Iterate: Argument to setPoint has incorrect length!');
      end
      
      % Set point
      I.x = x;
      
      % Reset indicators
      I.f_evaluated = false;
      I.g_evaluated = false;
      I.c_evaluated = false;
      I.J_evaluated = false;
      
    end
    
  end
  
end