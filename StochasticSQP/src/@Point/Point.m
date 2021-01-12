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
    mE % number of constraints, equalities
    mI % number of constraints, inequalities
    yE % multipliers, equalities
    yE_true % true multipliers, equalities
    yI % multipliers, inequalities
    yI_true % true multipliers, inequalities
    x % primal point
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
    g_norm1
    g_normInf
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
        P.cE_scale = sparse(ones(P.mE,1));
        P.cI_scale = sparse(ones(P.mI,1));
        
      else % point + vector input (2 arguments)
        
        % Copy members from input point
        P.p = varargin{1}.problem;
        P.n = varargin{1}.numberOfVariables;
        P.mE = varargin{1}.numberOfConstraintsEqualities;
        P.mI = varargin{1}.numberOfConstraintsInequalities;
        [P.yE,P.yI] = varargin{1}.multipliers;
        [P.f_scale,P.cE_scale,P.cI_scale] = varargin{1}.scaleFactors;
        
        % Set indicator
        P.scales_set = true;

        % Set point
        P.x = sparse(varargin{2});
      
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
    function setMultipliers(P,yE,yI)
      
      % Set multipliers
      P.yE = yE;
      P.yI = yI;
      
    end % setMultipliers
    
    % Set true multipliers
    function setTrueMultipliers(P,yE,yI)
      
      % Set multipliers
      P.yE_true = yE;
      P.yI_true = yI;
      
    end % setTrueMultipliers
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Multipliers
    function [yE,yI] = multipliers(P)
      
      % Set multipliers
      yE = sparse(P.yE);
      yI = sparse(P.yI);
      
    end % multipliers
    
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
        
    %%%%%%%%%%%%%%%%%%%%%%
    % EVALUATION METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Constraint function, equalities
    function cE = constraintFunctionEqualities(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.cE_evaluated
        
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
      
      % Check if already evaluated
      if ~P.cI_evaluated
        
        % Evaluate
        [P.cI_unscaled,err] = P.p.evaluateConstraintFunctionInequalities(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating constraints, inequalities!');
        end
        
        % Scale
        P.cI = P.cI_scale .* P.cI_unscaled;
        
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
      
      % Check if already evaluated
      if ~P.JE_evaluated
        
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
      
      % Check if already evaluated
      if ~P.JI_evaluated
        
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
    
    % Constraint 2-norm
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
          P.cE_scale = sparse(quantities.scaleFactorGradientLimit./max(quantities.scaleFactorGradientLimit,vecnorm(Jacobian,inf,2)));
          
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
          P.cI_scale = sparse(quantities.scaleFactorGradientLimit./max(quantities.scaleFactorGradientLimit,vecnorm(Jacobian,inf,2)));
          
          % Evaluate
          P.JI = P.cI_scale .* Jacobian;
          
          % Set indicator
          P.JI_evaluated = true;
          
        end
        
      else
        
        % Set scales to 1
        P.f_scale = 1.0;
        P.cE_scale = sparse(ones(P.mE,1));
        P.cI_scale = sparse(ones(P.mI,1));
        
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
        [P.H,err] = P.p.evaluateHessianOfLagrangian(P.x,P.yE./P.cE_scale,P.yI./P.cI_scale);
        
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
    
    % Stationarity measure
    function v = stationarityMeasure(P,quantities)
      
      % Evaluate measure
      if P.mE == 0 && P.mI == 0
        v = norm(P.objectiveGradient(quantities),inf);
      else
        vec = P.objectiveGradient(quantities);
        if P.mE > 0
          vec = vec + (P.yE' * P.constraintJacobianEqualities(quantities))';
        end
        if P.mI > 0
          vec = vec + (P.yI' * P.constraintJacobianInequalities(quantities))';
        end
        v = norm(vec,inf);
        if P.mI > 0
          v = max(v,norm([min(P.yI,0); P.yI .* P.constraintFunctionInequalities(quantities)],inf));
        end
        v = max(v,P.constraintNormInf(quantities));
      end
      
    end % stationarityMeasure
    
    % True stationarity measure
    function v = trueStationarityMeasure(P,quantities)
      
      % Evaluate measure
      if P.mE == 0 && P.mI == 0
        v = norm(P.trueObjectiveGradient(quantities),inf);
      else
        vec = P.trueObjectiveGradient(quantities);
        if P.mE > 0
          vec = vec + (P.yE_true' * P.constraintJacobianEqualities(quantities))';
        end
        if P.mI > 0
          vec = vec + (P.yI_true' * P.constraintJacobianInequalities(quantities))';
        end
        v = norm(vec,inf);
        if P.mI > 0
          v = max(v,norm([min(P.yI_true,0); P.yI_true .* P.constraintFunctionInequalities(quantities)],inf));
        end
        v = max(v,P.constraintNormInf(quantities));
      end
      
    end % trueStationarityMeasure
    
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
    function g = objectiveGradient(P,quantities)

      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.g_evaluated
        
        % Evaluate
        [P.g,err] = P.p.evaluateObjectiveGradient(P.x);

        % Check for error
        if err == true
          error('Point: Error evaluating objective gradient!');
        end

        % Scale
        P.g = P.f_scale * P.g;
        
        % Set indicator
        P.g_evaluated = true;
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
      end
      
      % Set objective gradient value
      g = P.g;
      
    end % end objectiveGradient
    
    % True objective gradient
    function g = trueObjectiveGradient(P,quantities)
        
        % Check if scales have been set
        if ~P.scales_set
            error('Point: Scale factors have not been set!');
        end
        
        % Check if already evaluated
        if ~P.g_true_evaluated
            
            % Evaluate
            [P.g_true,err] = P.p.evaluateTrueObjectiveGradient(P.x);
            
            % Check for error
            if err == true
                error('Point: Error evaluating objective gradient!');
            end
            
            % Scale
            P.g_true = P.f_scale * P.g_true;
            
            % Set indicator
            P.g_true_evaluated = true;
            
        end
        
        % Set objective gradient value
        g = P.g_true;
        
    end % end trueObjectiveGradient
    
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