% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

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
    mE % number of constraints, equalities
    mI % number of constraints, inequalities
    x % primal point
    yE % multipliers, equalities
    yE_true % true multipliers, equalities
    yI % multipliers, inequalities
    yI_true % true multipliers, inequalities
    f % objective function
    f_unscaled % objective function, unscaled
    g % objective gradient
    g_true % true objective gradient
    cE % constraint function, equalities
    cE_unscaled % constraint function, equalities, unscaled
    cI % constraint function, inequalities
    cI_unscaled % constraint function, inequalities, unscaled
    JE % constraint Jacobian, equalities
    JI % constraint Jacobian, inequalities
    H % Hessian of Lagrangian
    
    %%%%%%%%%
    % NORMS %
    %%%%%%%%%
    c_norm1
    c_normInf
    c_normInf_unscaled
    
    %%%%%%%%%%%%%%%%%
    % SCALE FACTORS %
    %%%%%%%%%%%%%%%%%
    f_scale
    cE_scale
    cI_scale
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    f_evaluated = false
    g_evaluated = false
    g_true_evaluated = false
    cE_evaluated = false
    cI_evaluated = false
    JE_evaluated = false
    JI_evaluated = false
    H_evaluated = false
    g_norm1_evaluated = false
    g_normInf_evaluated = false
    c_norm1_evaluated = false
    c_normInf_evaluated = false
    c_normInf_unscaled_evaluated = false
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
        
        % Set number of constraints, equalities
        P.mE = P.p.numberOfConstraintsEqualities;
        
        % Set number of constraints, inequalities
        P.mI = P.p.numberOfConstraintsInequalities;
        
        % Initialize scale factors
        P.f_scale = 1.0;
        P.cE_scale = ones(P.mE,1);
        P.cI_scale = ones(P.mI,1);
        
      else % point + vector input (2 arguments)
        
        % Copy members from input point
        P.p = varargin{1}.problem;
        P.n = varargin{1}.numberOfVariables;
        P.mE = varargin{1}.numberOfConstraintsEqualities;
        P.mI = varargin{1}.numberOfConstraintsInequalities;
        [P.yE,P.yI] = varargin{1}.multipliers('stochastic');
        [P.yE_true,P.yI_true] = varargin{1}.multipliers('true');
        [P.f_scale,P.cE_scale,P.cI_scale] = varargin{1}.scaleFactors;
        
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
    % SET METHODS %
    %%%%%%%%%%%%%%%
    
    % Set multipliers
    function setMultipliers(P,yE,yI,type)
      
      % Check type
      if strcmp(type,'stochastic')
        P.yE = yE;
        P.yI = yI;
      elseif strcmp(type,'true')
        P.yE_true = yE;
        P.yI_true = yI;
      else
        error('Point: Invalid type for setMultipliers.');
      end
      
    end % setMultipliers
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Multipliers
    function [yE,yI] = multipliers(P,type)
      
      % Check type
      if strcmp(type,'stochastic')
        yE = P.yE;
        yI = P.yI;
      elseif strcmp(type,'true')
        yE = P.yE_true;
        yI = P.yI_true;
      else
        error('Point: Invalid type for multipliers.');
      end
      
    end % multipliers
    
    
    % variable bounds
    function [xl,xu] = bounds(P)
        [xl,xu] = P.p.bounds;
    end % variable bounds
    
    % index sets of finite lower and upper bounds
    function [ixl,ixu] = indicesOfBounds(P)
        [ixl,ixu] = P.p.indicesOfBounds;     
    end % index sets of finite lower and upper bounds
    
    
    function projectToBounds(P)
        [xl,xu] = P.p.bounds;
        [n_small,~] = size(xl);
        ix_smallerThanBounds = find(P.x(1:n_small)<xl);
        ix_largerThanBounds = find(P.x(1:n_small)>xu);
        is_smallerThanBounds = find(P.x(n_small+1:P.n)<0)+n_small;
        P.x(ix_smallerThanBounds) = xl(ix_smallerThanBounds);
        P.x(ix_largerThanBounds) = xu(ix_largerThanBounds);
        P.x(is_smallerThanBounds) = 0;
    end
    
    % Number of constraints, equalities
    function mE = numberOfConstraintsEqualities(P)
      
      % Set number of constraints, equalities
      mE = P.mE;
      
    end % numberOfConstraintsEqualities
    
    % Number of constraints, inequalities
    function mI = numberOfConstraintsInequalities(P)
      
      % Set number of constraints, inequalities
      mI = P.mI;
      
    end % numberOfConstraintsInequalities
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end % numberOfVariables
    
     % Number of variables
    function n = numberOfOriginalVariables(P)
      
      % Set number of variables
      n = P.p.numberOfOriginalVariables;
      
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
    function [f_scale,cE_scale,cI_scale] = scaleFactors(P)
      
      % Set scale factors
      f_scale = P.f_scale;
      cE_scale = P.cE_scale;
      cI_scale = P.cI_scale;
      
    end % scaleFactors
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CHECK DERIVATIVE METHOD %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Check derivatives
    function checkDerivatives(P,quantities)
      
      % Set parameters
      epsilon   = 1e-08;
      tolerance = 1e-04;
      
      % Evaluate objective quantities
      f = P.objectiveFunction(quantities);
      g = P.objectiveGradient(quantities,'true');
      
      % Loop over coordinate directions
      for j = 1:P.n
        
        % Set perturbation
        perturbation = zeros(P.n,1); perturbation(j) = epsilon;
        
        % Set trial point
        temp = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + perturbation);
        
        % Set trial objective value
        f_temp = temp.objectiveFunction(quantities);
        
        % Check derivative
        if abs((f_temp - f)/epsilon - g(j)) >= tolerance
          warning('g[%8d] = %+e != %e',j,g(j),(f_temp - f)/epsilon);
        end
        
      end
      
      % Evaluate constraint quantities
      cE = P.constraintFunctionEqualities(quantities);
      JE = P.constraintJacobianEqualities(quantities);
      
      % Loop over coordinate directions
      for j = 1:P.n
        
        % Set perturbation
        perturbation = zeros(P.n,1); perturbation(j) = epsilon;
        
        % Set trial point
        temp = Point(quantities.currentIterate,quantities.currentIterate.primalPoint + perturbation);
        
        % Set trial objective value
        cE_temp = temp.constraintFunctionEqualities(quantities);
        
        % Check derivatives
        for i = 1:P.mE
          if abs((cE_temp(i) - cE(i))/epsilon - JE(i,j)) >= tolerance
            warning('JE[%8d,%8d] = %+e != %e',i,j,JE(i,j),(cE_temp(i) - cE(i))/epsilon);
          end
        end
        
      end
      
    end % checkDerivatives
    
    %%%%%%%%%%%%%%%%%%%%%%
    % EVALUATION METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Constraint function, equalities
    function cE = constraintFunctionEqualities(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if any constraints
      if P.mE == 0
        
        % Set null values
        P.cE_unscaled = [];
        P.cE = [];
        P.cE_evaluated = true;
        
      % Check if already evaluated
      elseif ~P.cE_evaluated
        
        % Evaluate
        [P.cE_unscaled,err] = P.p.evaluateConstraintFunctionEqualities(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating constraints, equalities!');
        end
        
        % Scale
        P.cE = P.cE_scale .* P.cE_unscaled;
        
        % Set indicator
        P.cE_evaluated = true;
        
        % Increment counter
        quantities.incrementConstraintFunctionEqualitiesEvaluationCounter;
        
      end
      
      % Set constraint function, equalities
      cE = P.cE;
      
    end % constraintFunctionEqualities
    
    % Constraint function, inequalities
    function cI = constraintFunctionInequalities(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if any constraints
      if P.mI == 0
        
        % Set null values
        P.cI_unscaled = [];
        P.cI = [];
        P.cI_evaluated = true;
        
      % Check if already evaluated
      elseif ~P.cI_evaluated
        
        % Evaluate
        [P.cI_unscaled,err] = P.p.evaluateConstraintFunctionInequalities(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating constraints, inequalities!');
        end
        
        % Scale
        P.cI = P.cI_scale .* P.cI_unscaled;
        P.cI =  P.cI_unscaled;
        
        % Set indicator
        P.cI_evaluated = true;
        
        % Increment counter
        quantities.incrementConstraintFunctionInequalitiesEvaluationCounter;
        
      end
      
      % Set constraint function, inequalities
      cI = P.cI;
      
    end % constraintFunctionInequalities
    
    % Constraint Jacobian, equalities
    function JE = constraintJacobianEqualities(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if any constraints
      if P.mE == 0
        
        % Set null values
        P.JE = zeros(0,P.n);
        P.JE_evaluated = true;
      
      % Check if already evaluated
      elseif ~P.JE_evaluated
        
        % Evaluate
        [P.JE,err] = P.p.evaluateConstraintJacobianEqualities(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating constraint Jacobian, equalities!');
        end
        
        % Scale
        P.JE = P.cE_scale .* P.JE;
        
        % Set indicator
        P.JE_evaluated = true;
        
        % Increment counter
        quantities.incrementConstraintJacobianEqualitiesEvaluationCounter;
        
      end
      
      % Set constraint Jacobian, equalities
      JE = P.JE;
      
    end % end constraintJacobianEqualities
    
    % Constraint Jacobian, inequalities
    function JI = constraintJacobianInequalities(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if any constraints
      if P.mI == 0
        
        % Set null values
        P.JI = zeros(0,P.n);
        P.JI_evaluated = true;
      
      % Check if already evaluated
      elseif ~P.JI_evaluated
        
        % Evaluate
        [P.JI,err] = P.p.evaluateConstraintJacobianInequalities(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating constraint Jacobian, inequalities!');
        end
        
        % Scale
        P.JI = P.cI_scale .* P.JI;
        
        % Set indicator
        P.JI_evaluated = true;
        
        % Increment counter
        quantities.incrementConstraintJacobianInequalitiesEvaluationCounter;
        
      end
      
      % Set constraint Jacobian, inequalities
      JI = P.JI;
      
    end % end constraintJacobianEqualities
    
    % Constraint 1-norm
    function v = constraintNorm1(P,quantities)
      
      % Check if norm evaluated
      if ~P.c_norm1_evaluated
        
        % Check if constraint function evaluated
        if ~P.cE_evaluated
          
          % Evaluate constraint function, equalities
          P.constraintFunctionEqualities(quantities);
          
        end
        
        % Check if constraint function evaluated
        if ~P.cI_evaluated
          
          % Evaluate constraint function, inequalities
          P.constraintFunctionInequalities(quantities);
          
        end
        
        % Evaluate norm
        P.c_norm1 = norm(P.cE,1) + norm(max(P.cI,0),1);
        
      end
      
      % Set return value
      v = P.c_norm1;
      
    end % end constraintNorm1
    
    % Constraint inf-norm
    function v = constraintNormInf(P,quantities)
      
      % Check if norm evaluated
      if ~P.c_normInf_evaluated
        
        % Check if constraint function evaluated
        if ~P.cE_evaluated
          
          % Evaluate constraint function, equalities
          P.constraintFunctionEqualities(quantities);
          
        end
        
        % Check if constraint function evaluated
        if ~P.cI_evaluated
          
          % Evaluate constraint function, inequalities
          P.constraintFunctionInequalities(quantities);
          
        end
        
        % Evaluate norm
        P.c_normInf = norm(P.cE,inf) + norm(max(P.cI,0),inf);
        
      end
      
      % Set return value
      v = P.c_normInf;
      
    end % end constraintNormInf
    
    % Constraint inf-norm unscaled
    function v = constraintNormInfUnscaled(P,quantities)
      
      % Check if norm evaluated
      if ~P.c_normInf_unscaled_evaluated
        
        % Check if constraint function evaluated
        if ~P.cE_evaluated
          
          % Evaluate constraint function, equalities
          P.constraintFunctionEqualities(quantities);
          
        end
        
        % Check if constraint function evaluated
        if ~P.cI_evaluated
          
          % Evaluate constraint function, inequalities
          P.constraintFunctionInequalities(quantities);
          
        end
        
        % Evaluate norm
        P.c_normInf_unscaled = norm(P.cE_unscaled,inf) + norm(max(P.cI_unscaled,0),inf);
        
      end
      
      % Set return value
      v = P.c_normInf_unscaled;
      
    end % end constraintNormInfUnscaled
    
    % Determine scale factors
    function determineScaleFactors(P,quantities,type)      
      % Check whether to scale
      
      if quantities.scaleProblem
        
        % Evaluate objective gradient
        gradient = P.p.evaluateObjectiveGradient(P.x,type,quantities.batchSize);
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
        % Set objective scale factor
        P.f_scale = quantities.scaleFactorGradientLimit/max(quantities.scaleFactorGradientLimit,norm(gradient,inf));
        
        % Set gradient
        P.g = P.f_scale * gradient;
        
        % Set indicator
        P.g_evaluated = true;
        
        % Check if equalities present
        if P.mE == 0
          
          % Set null values
          P.cE_scale = []; P.JE = []; P.JE_evaluated = true;
          
        else
          
          % Evaluate constraint Jacobian, equalities
          Jacobian = P.p.evaluateConstraintJacobianEqualities(P.x);
          
          % Increment counter
          quantities.incrementConstraintJacobianEqualitiesEvaluationCounter;
          
          % Set constraint scale factor
          P.cE_scale = quantities.scaleFactorGradientLimit./max(quantities.scaleFactorGradientLimit,vecnorm(Jacobian,inf,2));
          
          % Evaluate
          P.JE = P.cE_scale .* Jacobian;
          
          % Set indicator
          P.JE_evaluated = true;
          
        end
        
        % Check if inequalities present
        if P.mI == 0
          
          % Set null values
          P.cI_scale = []; P.JI = []; P.JI_evaluated = true;
          
        else
          
          % Evaluate constraint Jacobian, inequalities
          Jacobian = P.p.evaluateConstraintJacobianInequalities(P.x);
          
          % Increment counter
          quantities.incrementConstraintJacobianInequalitiesEvaluationCounter;
          
          % Set constraint scale factor
          P.cI_scale = quantities.scaleFactorGradientLimit./max(quantities.scaleFactorGradientLimit,vecnorm(Jacobian,inf,2));
          % Evaluate
          P.JI = P.cI_scale .* Jacobian;
          
          % Set indicator
          P.JI_evaluated = true;
          
        end
        
      else
        
        % Set scales to 1
        P.f_scale = 1.0;
        P.cE_scale = ones(P.mE,1);
        P.cI_scale = ones(P.mI,1);
        
      end
      
      % Scales set
      P.scales_set = true;
      
    end % determineScaleFactors
    
    % Hessian of Lagrangian
    function H = hessianOfLagrangian(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.H_evaluated
        
        % Evaluate
        [P.H,err] = P.p.evaluateHessianOfLagrangian(P.x,(P.yE.*P.cE_scale)/P.f_scale,(P.yI.*P.cI_scale)/P.f_scale);
        P.H = (P.H + P.H')/2;
        
        % Rescale P.H
        P.H = P.f_scale * P.H;
        
        % Check for error
        if err == true
          error('Point: Error evaluating Hessian of Lagrangian!');
        end
        
        % Set indicator
        P.H_evaluated = true;
        
        % Increment counter
        quantities.incrementHessianOfLagrangianEvaluationCounter;
        
      end
      
      % Set Hessian of Lagrangian
      H = P.H;
      
    end % hessianOfLagrangian
    
    % KKT error
    function v = KKTError(P,quantities,type)

      % Check for valid type
      if ~strcmp(type,'stochastic') && ~strcmp(type,'true')
        error('Point: Invalid type for KKTError.');
      end

      % Evaluate measure
      if P.mE == 0 && P.mI == 0
        v = norm(P.objectiveGradient(quantities,type),inf);
      else
        vec = P.objectiveGradient(quantities,type);
        if P.mE > 0
          if strcmp(type,'stochastic')
            vec = vec + (P.yE' * P.constraintJacobianEqualities(quantities))';
          else % strcmp(type,'true')
            vec = vec + (P.yE_true' * P.constraintJacobianEqualities(quantities))';
          end
        end
        if P.mI > 0
          if strcmp(type,'stochastic')
            vec = vec + (P.yI' * P.constraintJacobianInequalities(quantities))';
          else % strcmp(type,'true')
            vec = vec + (P.yI_true' * P.constraintJacobianInequalities(quantities))';
          end
        end
        v = norm(vec,inf);
        if P.mI > 0
          if strcmp(type,'stochastic')
            v = max(v,norm([min(P.yI,0); P.yI .* P.constraintFunctionInequalities(quantities)],inf));
          else % strcmp(type,'true')
            v = max(v,norm([min(P.yI_true,0); P.yI_true .* P.constraintFunctionInequalities(quantities)],inf));
          end
        end
        v = max(v,P.constraintNormInf(quantities));
      end
      
    end % KKTError
    
    % Objective function
    function f = objectiveFunction(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        [P.f_unscaled,err] = P.p.evaluateObjectiveFunction(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective function!');
        end
        
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
    function g = objectiveGradient(P,quantities,type)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check for valid type
      if ~strcmp(type,'stochastic') && ~strcmp(type,'true')
        error('Point: Invalid type for objectiveGradient.');
      end
      
      % Check if already evaluated
      if (strcmp(type,'stochastic') && ~P.g_evaluated) || (strcmp(type,'true') && ~P.g_true_evaluated)
        
        % Evaluate
        [g,err] = P.p.evaluateObjectiveGradient(P.x,type,quantities.batchSize);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective gradient!');
        end
        
        % Scale
        g = P.f_scale * g;
        
        % Check type
        if strcmp(type,'stochastic')
          
          % Set indicator
          P.g_evaluated = true;
          
          % Set gradient
          P.g = g;
          
          % Increment counter
          quantities.incrementObjectiveGradientEvaluationCounter;
          
        else % strcmp(type,'true')
          
          % Set indicator
          P.g_true_evaluated = true;
          
          % Set gradient
          P.g_true = g;
          
          % Increment counter
          quantities.incrementObjectiveGradientTrueEvaluationCounter;
          
        end
        
      else
        
        % Set gradient
        if strcmp(type,'stochastic')
          g = P.g;
        else % strcmp(type,'true')
          g = P.g_true;
        end
        
      end
      
    end % end objectiveGradient
    
  end % methods (public access)
  
end % Point