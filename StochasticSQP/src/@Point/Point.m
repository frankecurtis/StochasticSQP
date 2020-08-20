% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Point class
classdef Point < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%
    % QUANTITIES %
    %%%%%%%%%%%%%%
    n % number of variables
    m % number of constraints
    x % primal point
    y % dual point
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
    
    % Constructor (problem input)
    function P = Point(varargin)
      
      % Check for correct number of input arguments
      if nargin < 1 || nargin > 2
        error('Point: Incorrect number of inputs to constructor.');
      end
      
      % Check for point input (1 argument)
      if nargin == 1
      
        % Set initial primal point
        P.x = varargin{1}.initialPoint;
      
        % Set number of variables
        P.n = varargin{1}.numberOfVariables;
      
        % Set number of constraints
        P.m = varargin{1}.numberOfConstraints;
      
        % Initialize scale factors
        P.f_scale = 1.0;
        P.c_scale = ones(P.m,1);
        
      else % point + vector input (2 arguments)
        
        % Copy members from input point
        P.n = varargin{1}.numberOfVariables;
        P.m = varargin{1}.numberOfConstraints;
        [P.f_scale,P.c_scale] = varargin{1}.scaleFactors;
        
        % Set indicator
        P.scales_set = true;

        % Set point
        P.x = varargin{2};
      
      end
      
    end % Constructor
        
    % Constraint function
    function c = constraintFunction(P,problem)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.c_evaluated
        
        % Evaluate
        P.c = P.c_scale .* problem.evaluateConstraintFunction(P.x);
        
        % Set indicator
        P.c_evaluated = true;
        
      end
      
      % Set constraint function value
      c = P.c;
      
    end % constraintFunction
    
    % Objective Jacobian
    function J = constraintJacobian(P,problem)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.J_evaluated
        
        % Evaluate
        P.J = P.c_scale .* problem.evaluateConstraintJacobian(P.x);
        
        % Set indicator
        P.J_evaluated = true;
        
      end
      
      % Set constraint Jacobian value
      J = P.J;
      
    end % end constraintJacobian
    
    % Determine scale factors
    function determineScaleFactors(P,problem,scaleFactorGradientLimit)
      
      % Evaluate objective gradient
      gradient = problem.evaluateObjectiveGradient(P.x);
      
      % Set objective scale factor
      P.f_scale = scaleFactorGradientLimit/max(scaleFactorGradientLimit,norm(gradient,inf));
      
      % Evaluate constraint Jacobian
      Jacobian = problem.evaluateConstraintJacobian(P.x);
      
      % Set constraint scale factor
      P.c_scale = scaleFactorGradientLimit/max(scaleFactorGradientLimit,vecnorm(Jacobian,inf,2));
      
      % Scales set
      P.scales_set = true;
      
    end
    
    % Make linear combination
    function P = makeLinearCombination(P_curr,alpha,d)
      
      % Create new point
      P = Point(P_curr,P_curr.primalPoint + alpha*d);
      
    end
    
    % Number of constraints
    function m = numberOfConstraints(P)
      
      % Set number of constraints
      m = P.m;
      
    end
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end
    
    % Objective function
    function f = objectiveFunction(P,problem)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        P.f = P.f_scale * problem.evaluateObjectiveFunction(P.x);
        
        % Set indicator
        P.f_evaluated = true;
        
      end
      
      % Set objective function value
      f = P.f;
      
    end % objectiveFunction
    
    % Objective gradient
    function g = objectiveGradient(P,problem)

      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.g_evaluated
        
        % Evaluate
        P.g = P.f_scale * problem.evaluateObjectiveGradient(P.x);
        
        % Set indicator
        P.g_evaluated = true;
        
      end
      
      % Set objective gradient value
      g = P.g;
      
    end % end objectiveGradient
    
    % Primal point
    function x = primalPoint(P)
      
      % Set point
      x = P.x;
      
    end
    
    % Scale factors
    function [f_scale,c_scale] = scaleFactors(P)
      
      % Set scale factors
      f_scale = P.f_scale;
      c_scale = P.c_scale;
      
    end
        
  end
  
end