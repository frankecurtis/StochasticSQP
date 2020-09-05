% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Point class
classdef Point < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Problem %
    %%%%%%%%%%%
    p
    
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
    
    %%%%%%%%%
    % NORMS %
    %%%%%%%%%
    g_norm2
    g_normInf
    c_norm2
    c_normInf
    
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
    g_norm2_evaluated = false
    g_normInf_evaluated = false
    c_norm2_evaluated = false
    c_normInf_evaluated = false
    scales_set  = false
        
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function P = Point(varargin)
      
      % Check for correct number of input arguments
      if nargin < 1 || nargin > 2
        error('Point: Incorrect number of inputs to constructor.');
      end
      
      % Check for problem input (1 argument)
      if nargin == 1
        
        % Set problem
        P.p = varargin{1};
      
        % Set initial primal point
        P.x = P.p.initialPoint;
      
        % Set number of variables
        P.n = P.p.numberOfVariables;
      
        % Set number of constraints
        P.m = P.p.numberOfConstraints;
      
        % Initialize scale factors
        P.f_scale = 1.0;
        P.c_scale = ones(P.m,1);
        
      else % point + vector input (2 arguments)
        
        % Copy members from input point
        P.p = varargin{1}.problem;
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
    function c = constraintFunction(P)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.c_evaluated
        
        % Evaluate
        P.c = P.c_scale .* P.p.evaluateConstraintFunction(P.x);
        
        % Set indicator
        P.c_evaluated = true;
        
      end
      
      % Set constraint function value
      c = P.c;
      
    end % constraintFunction
    
    % Constraint Jacobian
    function J = constraintJacobian(P)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.J_evaluated
        
        % Evaluate
        P.J = P.c_scale .* P.p.evaluateConstraintJacobian(P.x);
        
        % Set indicator
        P.J_evaluated = true;
        
      end
      
      % Set constraint Jacobian value
      J = P.J;
      
    end % end constraintJacobian
    
    % Constraint 2-norm
    function v = constraintNorm2(P)
      
      % Check if norm evaluated
      if ~P.c_norm2_evaluated
        
        % Check if constraint function evaluated
        if ~P.c_evaluated
          
          % Evaluate constraint function
          P.constraintFunction;
          
        end
        
        % Evaluate norm
        P.c_norm2 = norm(P.c);
        
      end
      
      % Set return value
      v = P.c_norm2;
      
    end % end constraintNorm2

    % Constraint inf-norm
    function v = constraintNormInf(P)
      
      % Check if norm evaluated
      if ~P.c_normInf_evaluated
        
        % Check if constraint function evaluated
        if ~P.c_evaluated
          
          % Evaluate constraint function
          P.constraintFunction;
          
        end
        
        % Evaluate norm
        P.c_normInf = norm(P.c,'inf');
        
      end
      
      % Set return value
      v = P.c_normInf;
      
    end % end constraintNormInf

    % Determine scale factors
    function determineScaleFactors(P,scaleFactorGradientLimit)
      
      % Evaluate objective gradient
      gradient = P.p.evaluateObjectiveGradient(P.x);
      
      % Set objective scale factor
      P.f_scale = scaleFactorGradientLimit/max(scaleFactorGradientLimit,norm(gradient,inf));
      
      % Evaluate constraint Jacobian
      Jacobian = P.p.evaluateConstraintJacobian(P.x);
      
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
    function f = objectiveFunction(P)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        P.f = P.f_scale * P.p.evaluateObjectiveFunction(P.x);
        
        % Set indicator
        P.f_evaluated = true;
        
      end
      
      % Set objective function value
      f = P.f;
      
    end % objectiveFunction
    
    % Objective gradient
    function g = objectiveGradient(P)

      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.g_evaluated
        
        % Evaluate
        P.g = P.f_scale * P.p.evaluateObjectiveGradient(P.x);
        
        % Set indicator
        P.g_evaluated = true;
        
      end
      
      % Set objective gradient value
      g = P.g;
      
    end % end objectiveGradient
    
    % Objective gradient 2-norm
    function v = objectiveGradientNorm2(P)
      
      % Check if norm evaluated
      if ~P.g_norm2_evaluated
        
        % Check if objective function evaluated
        if ~P.g_evaluated
          
          % Evaluate objective gradient function
          P.objectiveGradient;
          
        end
        
        % Evaluate norm
        P.g_norm2 = norm(P.g);
        
      end
      
      % Set return value
      v = P.g_norm2;
      
    end % end objectiveGradientNorm2

    % Constraint inf-norm
    function v = objectiveGradientNormInf(P)
      
      % Check if norm evaluated
      if ~P.g_normInf_evaluated
        
        % Check if objective function evaluated
        if ~P.g_evaluated
          
          % Evaluate objective gradient function
          P.objectiveGradient;
          
        end
        
        % Evaluate norm
        P.g_normInf = norm(P.g,'inf');
        
      end
      
      % Set return value
      v = P.g_normInf;
      
    end % end constraintNormInf
    
    % Primal point
    function x = primalPoint(P)
      
      % Set point
      x = P.x;
      
    end
    
    % Problem
    function p = problem(P)
      
      % Set problem
      p = P.p;
      
    end
    
    % Scale factors
    function [f_scale,c_scale] = scaleFactors(P)
      
      % Set scale factors
      f_scale = P.f_scale;
      c_scale = P.c_scale;
      
    end
        
  end
  
end