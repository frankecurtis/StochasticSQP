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
    
    % Constraint function, equalities
    function [cE,err] = evaluateConstraintFunctionEqualities(P,x)
      
      % Evaluate constraint function, equalities
      cE = x(1) + x(2) - 1;
      
      % No error
      err = false;
      
    end % evaluateConstraintFunctionEqualities
    
    % Constraint function, inequalities
    function [cI,err] = evaluateConstraintFunctionInequalities(P,x)
      
      % Evaluate constraint function, inequalities
      cI = [];
      
      % No error
      err = false;
      
    end % evaluateConstraintFunctionInequalities
    
    % Constraint Jacobian, equalities
    function [JE,err] = evaluateConstraintJacobianEqualities(P,~)
      
      % Evaluate constraint Jacobian, equalities
      JE = [1 1];
      
      % No error
      err = false;
      
    end % evaluateConstraintJacobianEqualities
    
    % Constraint Jacobian, inequalities
    function [JI,err] = evaluateConstraintJacobianInequalities(P,~)
      
      % Evaluate constraint Jacobian, inequalities
      JI = [];
      
      % No error
      err = false;
      
    end % evaluateConstraintJacobianInequalities
    
    % Hessian of the Lagrangian
    function [H,err] = evaluateHessianOfLagrangian(P,~,~,~)
      
      % Evaluate Hessian of Lagrangian
      H = eye(2);
      
      % No error
      err = false;
      
    end % evaluateHessianOfLagrangian
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Evaluate objective function
      f = (1/2)*x(1)^2 + (1/2)*x(2)^2;
      
      % No error
      err = false;
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x)
      
      % Evaluate objective gradient
      g = [x(1); x(2)];
      
      % No error
      err = false;
      
    end % evaluateObjectiveGradient
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = [4; 2];
      
    end % initialPoint
    
    % Name
    function s = name(P)
      
      % Set name
      s = 'Simple';
      
    end % name
    
    % Number of constraints, equalities
    function mE = numberOfConstraintsEqualities(P)
      
      % Set number of constraints, equalities
      mE = 1;
      
    end % numberOfConstraintsEqualities
        
    % Number of constraints, inequalities
    function mI = numberOfConstraintsInequalities(P)
      
      % Set number of constraints, inequalities
      mI = 0;
      
    end % numberOfConstraintsInequalities
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = 2;
      
    end % numberOfVariables
        
  end % methods (public access)
  
end % ProblemSimple