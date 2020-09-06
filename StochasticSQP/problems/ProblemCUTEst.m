% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% ProblemCUTEst class
classdef ProblemCUTEst < Problem
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    x % initial point
    n % number of variables
    m % number of constraints
    
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemCUTEst
      
      % Initialize CUTEst
      prob = cutest_setup();
      
      % Get initial point
      P.x = prob.x;
      
      % Get number of variables
      P.n = prob.n;
      
      % Get number of constraints
      P.m = prob.m;
      
      % Check for inequality constraints
      if sum(prob.cl < prob.cu) > 0
        error('Problem: Problem has inequality constraints.');
      end
      
    end % Constructor
    
    %%%%%%%%%%
    % DELETE %
    %%%%%%%%%%
    
    % Descructor
    function delete(P)
      
      % Terminate CUTEst
      cutest_terminate;
      
    end % destructor
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Evaluate objective function
      f = cutest_obj(x);
      
      % No error
      err = false;
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x)
      
      % Evaluate objective gradient
      g = cutest_grad(x);
      
      % No error
      err = false;
      
    end % evaluateObjectiveGradient
    
    % Constraint function
    function [c,err] = evaluateConstraintFunction(P,x)
      
      % Evaluate constraint function
      c = cutest_cons(x);
      
      % No error
      err = false;
      
    end % evaluateConstraintFunction
    
    % Constraint Jacobian
    function [J,err] = evaluateConstraintJacobian(P,x)
      
      % Evaluate constraint Jacobian
      [~,J] = cutest_cons(x);
      
      % No error
      err = false;
      
    end % evaluateConstraintJacobian
    
    % Hessian of the Lagrangian
    function [H,err] = evaluateHessianOfLagrangian(P,x,y)
      
      % Evaluate Hessian of Lagrangian
      H = cutest_hess(x,y);
      
      % No error
      err = false;
      
    end % evaluateHessianOfLagrangian
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = P.x;
      
    end % initialPoint
    
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
    
  end % methods (public access)
  
end % ProblemCUTEst