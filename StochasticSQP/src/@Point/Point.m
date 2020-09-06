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
    f % objective function value
    f_unscaled
    g % objective gradient value
    c % constraint function value
    c_unscaled
    J % constraint Jacobian value
    
    %%%%%%%%%
    % NORMS %
    %%%%%%%%%
    g_norm1
    g_normInf
    c_norm1
    c_normInf
    c_normInf_unscaled
    
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
    g_norm1_evaluated = false
    g_normInf_evaluated = false
    c_norm1_evaluated = false
    c_normInf_evaluated = false
    c_normInf_unscaled_evaluated = false
    multiplier_set = false
    scales_set = false
        
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
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

    %%%%%%%%%%%%%%%%%%%%
    % MAKE NEW METHODS %
    %%%%%%%%%%%%%%%%%%%%
    
    % Make linear combination
    function P = makeLinearCombination(P_curr,alpha,d)
      
      % Create new point
      P = Point(P_curr,P_curr.primalPoint + alpha*d);
      
    end % makeLinearCombination
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Number of constraints
    function m = numberOfConstraints(P)
      
      % Set number of constraints
      m = P.m;
      
    end % numberOfConstraints
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end % numberOfVariables
    
    % Primal point
    function x = primalPoint(P)
      
      % Set point
      x = P.x;
      
    end % primalPoint
    
    % Problem
    function p = problem(P)
      
      % Set problem
      p = P.p;
      
    end % problem
    
    % Scale factors
    function [f_scale,c_scale] = scaleFactors(P)
      
      % Set scale factors
      f_scale = P.f_scale;
      c_scale = P.c_scale;
      
    end % scaleFactors
        
    %%%%%%%%%%%%%%%%%%%%%%
    % EVALUATION METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Constraint function
    function c = constraintFunction(P,quantities)
      
      % Check if unconstrained
      if P.m == 0, P.c = []; P.c_evaluated = true; c = zeros(0,1); return; end
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.c_evaluated
        
        % Evaluate
        P.c_unscaled = P.p.evaluateConstraintFunction(P.x);
        
        % Scale
        P.c = P.c_scale .* P.c_unscaled;
        
        % Set indicator
        P.c_evaluated = true;
        
        % Increment counter
        quantities.incrementConstraintFunctionEvaluationCounter;
        
      end
      
      % Set constraint function value
      c = P.c;
      
    end % constraintFunction
    
    % Constraint Jacobian
    function J = constraintJacobian(P,quantities)
      
      % Check if unconstrained
      if P.m == 0, P.J = []; P.J_evaluated = true; J = zeros(0,P.n); return; end
      
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
        
        % Increment counter
        quantities.incrementConstraintJacobianEvaluationCounter;
        
      end
      
      % Set constraint Jacobian value
      J = P.J;
      
    end % end constraintJacobian
    
    % Constraint 2-norm
    function v = constraintNorm1(P,quantities)
      
      % Check if unconstrained
      if P.m == 0, P.c_norm1 = 0.0; P.c_norm1_evaluated = true; v = 0; return; end
      
      % Check if norm evaluated
      if ~P.c_norm1_evaluated
        
        % Check if constraint function evaluated
        if ~P.c_evaluated
          
          % Evaluate constraint function
          P.constraintFunction(quantities);
          
        end
        
        % Evaluate norm
        P.c_norm1 = norm(P.c,1);
        
      end
      
      % Set return value
      v = P.c_norm1;
      
    end % end constraintNorm1

    % Constraint inf-norm
    function v = constraintNormInf(P,quantities)
      
      % Check if unconstrained
      if P.m == 0, P.c_normInf = 0.0; P.c_normInf_evaluated = true; v = 0; return; end

      % Check if norm evaluated
      if ~P.c_normInf_evaluated
        
        % Check if constraint function evaluated
        if ~P.c_evaluated
          
          % Evaluate constraint function
          P.constraintFunction(quantities);
          
        end
        
        % Evaluate norm
        P.c_normInf = norm(P.c,'inf');
        
      end
      
      % Set return value
      v = P.c_normInf;
      
    end % end constraintNormInf
    
    % Constraint inf-norm unscaled
    function v = constraintNormInfUnscaled(P,quantities)
      
      % Check if unconstrained
      if P.m == 0, P.c_normInf_unscaled = 0.0; P.c_normInf_unscaled_evaluated = true; v = 0; return; end
      
      % Check if norm evaluated
      if ~P.c_normInf_unscaled_evaluated
        
        % Check if constraint function evaluated
        if ~P.c_evaluated
          
          % Evaluate constraint function
          P.constraintFunction(quantities);
          
        end
        
        % Evaluate norm
        P.c_normInf_unscaled = norm(P.c_unscaled,'inf');
        
      end
      
      % Set return value
      v = P.c_normInf_unscaled;
      
    end % end constraintNormInfUnscaled

    % Determine scale factors
    function determineScaleFactors(P,quantities)
      
      % Check whether to scale
      if quantities.scaleProblem
      
        % Evaluate objective gradient
        gradient = P.p.evaluateObjectiveGradient(P.x);
      
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
        % Set objective scale factor
        P.f_scale = quantities.scaleFactorGradientLimit/max(quantities.scaleFactorGradientLimit,norm(gradient,inf));
        
        % Set gradient
        P.g = P.f_scale * gradient;
        
        % Set indicator
        P.g_evaluated = true;
      
        % Check if unconstrained
        if P.m == 0
          
          % Set null values
          P.c_scale = []; P.J = []; P.J_evaluated = true;
          
        else
          
          % Evaluate constraint Jacobian
          Jacobian = P.p.evaluateConstraintJacobian(P.x);
          
          % Increment counter
          quantities.incrementConstraintJacobianEvaluationCounter;
          
          % Set constraint scale factor
          P.c_scale = quantities.scaleFactorGradientLimit/max(quantities.scaleFactorGradientLimit,vecnorm(Jacobian,inf,2));
          
          % Evaluate
          P.J = P.c_scale .* Jacobian;
          
          % Set indicator
          P.J_evaluated = true;
          
        end
        
      else
        
        % Set scales to 1
        P.f_scale = 1.0;
        P.c_scale = ones(P.m,1);
        
      end
      
      % Scales set
      P.scales_set = true;
      
    end % determineScaleFactors
    
    % Stationarity measure
    function v = stationarityMeasure(P,quantities,y)
      
      % Check if quantities already evaluated
      if ~P.g_evaluated
        P.objectiveGradient(quantities);
      end
      if ~P.J_evaluated
        P.constraintJacobian(quantities);
      end
      if ~P.c_evaluated
        P.constraintFunction(quantities);
      end
      
      % Evaluate measure
      if P.m > 0
        v = norm([P.g + (y'*P.J)'; P.c],inf);
      else
        v = norm(P.g,inf);
      end
      
    end % stationarityMeasure
    
    % Objective function
    function f = objectiveFunction(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        P.f_unscaled = P.p.evaluateObjectiveFunction(P.x);
        
        % Scale
        P.f = P.f_scale * P.f_unscaled;
        
        % Set indicator
        P.f_evaluated = true;
        
        % Increment counter
        quantities.incrementObjectiveFunctionEvaluationCounter;
        
      end
      
      % Set objective function value
      f = P.f;
      
    end % objectiveFunction
    
    % Objective function unscaled
    function f = objectiveFunctionUnscaled(P,quantities)
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        P.objectiveFunction(quantities);
        
      end
      
      % Set objective function unscaled value
      f = P.f_unscaled;
      
    end % objectiveFunctionUnscaled
    
    % Objective gradient
    function g = objectiveGradient(P,quantities)

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
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
      end
      
      % Set objective gradient value
      g = P.g;
      
    end % end objectiveGradient
    
    % Objective gradient 2-norm
    function v = objectiveGradientNorm1(P,quantities)
      
      % Check if norm evaluated
      if ~P.g_norm1_evaluated
        
        % Check if objective function evaluated
        if ~P.g_evaluated
          
          % Evaluate objective gradient function
          P.objectiveGradient(quantities);
          
        end
        
        % Evaluate norm
        P.g_norm1 = norm(P.g,1);
        
      end
      
      % Set return value
      v = P.g_norm1;
      
    end % end objectiveGradientNorm1

    % Constraint inf-norm
    function v = objectiveGradientNormInf(P,quantities)
      
      % Check if norm evaluated
      if ~P.g_normInf_evaluated
        
        % Check if objective function evaluated
        if ~P.g_evaluated
          
          % Evaluate objective gradient function
          P.objectiveGradient(quantities);
          
        end
        
        % Evaluate norm
        P.g_normInf = norm(P.g,'inf');
        
      end
      
      % Set return value
      v = P.g_normInf;
      
    end % end constraintNormInf
    
  end % methods (public access)
  
end % Point