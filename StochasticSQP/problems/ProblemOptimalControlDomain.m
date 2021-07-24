% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ProblemOptimalControlDomain class
classdef ProblemOptimalControlDomain < Problem
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    b % objective factor
    C % objective coefficients
    e % error level
    h % discretization parameter
    n % number of variables
    rows % number of grid points, rows
    cols % number of grid points, columns
    N % number of objective terms
    m % number of constraints
    s % random seed
    t % constraint scaling factor
    x % initial point
    X % grid x values
    Y % grid y values
    
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor (input h is discretization parameter)
    function P = ProblemOptimalControlDomain(h,N,b,e)
      
      % Set discretization parameter
      P.h = h;

      % Set number of objective terms
      P.N = N;

      % Set objective factor
      P.b = b;
      
      % Set error level
      P.e = e;
      
      % Set grid
      [P.X,P.Y] = meshgrid(0:h:1,0:h:1);
      
      % Store sizes
      P.rows = size(P.X,1);
      P.cols = size(P.X,2);
      
      % Set number of variables
      P.n = 2 * P.rows * P.cols;

      % Set initial point
      P.x = ones(P.n,1);
      
      % Set number of constraints
      P.m = P.rows * P.cols;
      
      % Set seed
      P.s = 0;
      
      % Set objective coefficients
      P.C = zeros(P.rows,P.cols,P.N^2);
      for i = 1:P.N
        for j = 1:P.N
          param1 = 4 + P.e/sqrt(15) * (i - (P.N+1)/2);
          param2 = 3 + P.e/sqrt(15) * (j - (P.N+1)/2);
          P.C(:,:,i+(j-1)*P.N) = sin(param1*P.X) + cos(param2*P.Y);
        end
      end
      
      % Set constraint scaling factor
      P.t = h^2;
      
    end % Constructor
    
    % Constraint function, equalities
    function [cE,err] = evaluateConstraintFunctionEqualities(P,x)
      
      % Evaluate constraint function, equalities
      cE = zeros(P.m,1);
      for i = 1:P.rows
        for j = 1:P.cols
          k = i + (j-1)*P.rows;
          if 1 == i && 1 == j
            cE(k) = P.t * ((         x(k+1)               + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          elseif 1 < i && i < P.rows && 1 == j
            cE(k) = P.t * ((x(k-1) + x(k+1)               + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          elseif i == P.rows && 1 == j
            cE(k) = P.t * ((x(k-1)                        + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          elseif 1 == i && 1 < j && j < P.rows
            cE(k) = P.t * ((         x(k+1) + x(k-P.rows) + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          elseif i == P.cols && 1 < j && j < P.rows
            cE(k) = P.t * ((x(k-1)          + x(k-P.rows) + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          elseif 1 == i && j == P.rows
            cE(k) = P.t * ((         x(k+1) + x(k-P.rows)               - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          elseif 1 < i && i < P.cols && j == P.rows
            cE(k) = P.t * ((x(k-1) + x(k+1) + x(k-P.rows)               - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));            
          elseif i == P.cols && j == P.rows
            cE(k) = P.t * ((x(k-1)          + x(k-P.rows)               - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          else
            cE(k) = P.t * ((x(k-1) + x(k+1) + x(k-P.rows) + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
          end
        end
      end
      
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
    function [JE,err] = evaluateConstraintJacobianEqualities(P,x)
      
      % Evaluate constraint Jacobian, equalities
      JE = zeros(P.m,P.n);
      for i = 1:P.rows
        for j = 1:P.cols
          k = i + (j-1)*P.rows;
          if 1 == i && 1 == j
            % cE(k) = P.t * ((         x(k+1)               + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k+1)             =    P.t/(P.h^2);
            JE(k,k+P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif 1 < i && i < P.rows && 1 == j
            % cE(k) = P.t * ((x(k-1) + x(k+1)               + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k-1)             =    P.t/(P.h^2);
            JE(k,k+1)             =    P.t/(P.h^2);
            JE(k,k+P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif i == P.rows && 1 == j
            % cE(k) = P.t * ((x(k-1)                        + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k-1)             =    P.t/(P.h^2);
            JE(k,k+P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif 1 == i && 1 < j && j < P.rows
            % cE(k) = P.t * ((         x(k+1) + x(k-P.rows) + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k+1)             =    P.t/(P.h^2);
            JE(k,k-P.rows)        =    P.t/(P.h^2);
            JE(k,k+P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif i == P.cols && 1 < j && j < P.rows
            % cE(k) = P.t * ((x(k-1)          + x(k-P.rows) + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k-1)             =    P.t/(P.h^2);
            JE(k,k-P.rows)        =    P.t/(P.h^2);
            JE(k,k+P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif 1 == i && j == P.rows
            % cE(k) = P.t * ((         x(k+1) + x(k-P.rows)               - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k+1)             =    P.t/(P.h^2);
            JE(k,k-P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif 1 < i && i < P.cols && j == P.rows
            % cE(k) = P.t * ((x(k-1) + x(k+1) + x(k-P.rows)               - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k-1)             =    P.t/(P.h^2);
            JE(k,k+1)             =    P.t/(P.h^2);
            JE(k,k-P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          elseif i == P.cols && j == P.rows
            % cE(k) = P.t * ((x(k-1)          + x(k-P.rows)               - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k-1)             =    P.t/(P.h^2);
            JE(k,k-P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          else
            % cE(k) = P.t * ((x(k-1) + x(k+1) + x(k-P.rows) + x(k+P.rows) - 4*x(k))/(P.h^2) + x(k + P.rows*P.cols));
            JE(k,k-1)             =    P.t/(P.h^2);
            JE(k,k+1)             =    P.t/(P.h^2);
            JE(k,k-P.rows)        =    P.t/(P.h^2);
            JE(k,k+P.rows)        =    P.t/(P.h^2);
            JE(k,k)               = -4*P.t/(P.h^2);
            JE(k,k+P.rows*P.cols) =    P.t;
          end
        end
      end
      
      % No error
      err = false;
      
    end % evaluateConstraintJacobianEqualities
    
    % Constraint Jacobian, inequalities
    function [JI,err] = evaluateConstraintJacobianInequalities(P,x)
      
      % Evaluate constraint Jacobian, inequalities
      JI = [];
      
      % No error
      err = false;
      
    end % evaluateConstraintJacobianInequalities
    
    % Hessian of the Lagrangian
    function [H,err] = evaluateHessianOfLagrangian(P,x,yE,yI)
      
      % Evaluate Hessian of Lagrangian
      H = speye(P.n,P.n);
      H(P.rows*P.cols+1:end,P.rows*P.cols+1:end) = P.b * speye(P.rows*P.cols,P.rows*P.cols);
      
      % No error
      err = false;
      
    end % evaluateHessianOfLagrangian
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Reshape
      X = reshape(x(1:P.rows*P.cols),P.rows,P.cols);
      
      % Evaluate objective function
      f = 0;
      for i = 1:P.N
        for j = 1:P.N
          f = f + 0.5*norm(X - P.C(:,:,i+(j-1)*P.N),'fro')^2 + 0.5*P.b*norm(x(P.rows*P.cols+1:end))^2;
        end
      end
      f = f/(P.N^2);
      
      % No error
      err = false;
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x,type,factor)
      
      % Reshape
      X = reshape(x(1:P.rows*P.cols),P.rows,P.cols);
      
      % Evaluate objective gradient
      g = zeros(P.n,1);
      if strcmp(type,'stochastic')
        rng(P.s);
        for batch = 1:factor
          k = randi([1,P.N^2]);
          g = g + [reshape((X - P.C(:,:,k)),P.rows*P.cols,1); P.b*x(P.rows*P.cols+1:end)];
        end
        g = g/factor;
        P.s = rng;
      elseif strcmp(type,'true')
        for i = 1:P.N
          for j = 1:P.N
            g = g + [reshape((X - P.C(:,:,i+(j-1)*P.N)),P.rows*P.cols,1); P.b*x(P.rows*P.cols+1:end)];
          end
        end
        g = g/(P.N^2);
      else
        error('ProblemOptimalControlDomain: Invalid type for evaluateObjectiveGradient.');
      end
      
      % No error
      err = false;
      
    end % evaluateObjectiveGradient
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = P.x;
      
    end % initialPoint
    
    % Name
    function s = name(P)
      
      % Set name
      s = 'OptimalControlDomain';
      
    end % name
    
    % Number of constraints, equalities
    function mE = numberOfConstraintsEqualities(P)
      
      % Set number of constraints, equalities
      mE = P.m;
      
    end % numberOfConstraintsEqualities
    
    % Number of constraints, inequalities
    function mI = numberOfConstraintsInequalities(P)
      
      % Set number of constraints, inequalities
      mI = 0;
      
    end % numberOfConstraintsInequalities
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end % numberOfVariables
    
  end % methods (public access)
  
end % ProblemCUTEst