% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ProblemCUTEst class
classdef ProblemOptimalControl < Problem
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    x % initial point
    n % number of variables
    xl % lower variable bounds
    xu % upper variable bounds
    ixl % indices of variables, lower bounded
    ixu % indices of variables, upper bounded
    nxl % number of variables, lower bounded
    nxu % number of variables, upper bounded
    m % number of constraints
    cl % lower constraint bounds
    cu % upper constraint bounds
    ice % indices of constraints, equalities
    icl % indices of constraints, inequalities, lower bounded
    icu % indices of constraints, inequalities, upper bounded
    mce % number of constraints, equalities
    mcl % number of constraints, inequalities, lower bounded
    mcu % number of constraints, inequalities, upper bounded
    s % name
    np % number of problems
    seed = 1 % random seed
    err_lvl % error level
    
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemOptimalControl
      
      % Set parameter h
      h = 0.01;
      
      % Set number of variables
      P.n = 2 * (1/h - 1)^2;
      
      % Get initial point
      P.x = sparse(ones(P.n, 1));
      
      % Set number of constraints
      P.m = (1/h - 1)^2;
            
      % Set name
      P.s = 'OPTCONT';
      
      % Set number of problems
      P.np = 9;
      
      % Set error level
      P.err_lvl = 0.0001;
            
    end % Constructor
    
    %%%%%%%%%%
    % DELETE %
    %%%%%%%%%%
    
    % Descructor
    function delete(P)
      
    end % destructor
    
    % Constraint function, equalities
    function [cE,err] = evaluateConstraintFunctionEqualities(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate constraint function, equalities
      try
        l = sqrt(P.m);
        h = 1/(l+1);
        cE = sparse(zeros(P.m,1));
        for i = 1:P.m
            if i <= l || i > (P.m - l) || mod(i,l) == 1 || mod(i,l) == 0
                if i <= l
                    if mod(i,l) == 1
                        cE(i) = x(P.m + i)/h + (x(i+l) + x(i+1) - 4*x(i))/(h^2);
                    elseif mod(i,l) == 0
                        cE(i) = x(P.m + i)/h + (x(i+l) + x(i-1) - 4*x(i))/(h^2);
                    else
                        cE(i) = x(P.m + i)/h + (x(i+l) + x(i-1) + x(i+1) - 4*x(i))/(h^2);
                    end
                elseif i > (P.m - l)
                    if mod(i,l) == 1
                        cE(i) = x(P.m + i)/h + (x(i-l) + x(i+1) - 4*x(i))/(h^2);
                    elseif mod(i,l) == 0
                        cE(i) = x(P.m + i)/h + (x(i-l) + x(i-1) - 4*x(i))/(h^2);
                    else
                        cE(i) = x(P.m + i)/h + (x(i-l) + x(i-1) + x(i+1) - 4*x(i))/(h^2);
                    end
                elseif mod(i,l) == 1
                    cE(i) = x(P.m + i)/h + (x(i-l) + x(i+l) + x(i+1) - 4*x(i))/(h^2);
                else
                    cE(i) = x(P.m + i)/h + (x(i-l) + x(i+l) + x(i-1) - 4*x(i))/(h^2);
                end
            else
                cE(i) = x(P.m + i)/h + (x(i-l) + x(i+l) + x(i-1) + x(i+1) - 4*x(i))/(h^2);
            end
        end
        if isempty(cE), cE = []; end
        if max(isnan(cE)), err = true; end
      catch
        cE = [];
        err = true;
      end
      
    end % evaluateConstraintFunctionEqualities

    % Constraint function, inequalities
    function [cI,err] = evaluateConstraintFunctionInequalities(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate constraint function, inequalities
      try
        cI = [];
      catch
        cI = [];
        err = true;
      end
      
    end % evaluateConstraintFunctionInequalities

    % Constraint Jacobian, equalities
    function [JE,err] = evaluateConstraintJacobianEqualities(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate constraint Jacobian, equalities
      try
        l = sqrt(P.m);
        h = 1/(l+1);
        JE = sparse(zeros(P.m,P.n));
        for i = 1:P.m
            if i <= l || i > (P.m - l) || mod(i,l) == 1 || mod(i,l) == 0
                if i <= l
                    if mod(i,l) == 1
                        JE(i,i) = -4/(h^2);
                        JE(i,i+1) = 1/(h^2);
                        JE(i,i+l) = 1/(h^2);
                        JE(i,i+P.m) = 1/h;
                    elseif mod(i,l) == 0
                        JE(i,i) = -4/(h^2);
                        JE(i,i-1) = 1/(h^2);
                        JE(i,i+l) = 1/(h^2);
                        JE(i,i+P.m) = 1/h;
                    else
                        JE(i,i) = -4/(h^2);
                        JE(i,i-1) = 1/(h^2);
                        JE(i,i+1) = 1/(h^2);
                        JE(i,i+l) = 1/(h^2);
                        JE(i,i+P.m) = 1/h;
                    end
                elseif i > (P.m - l)
                    if mod(i,l) == 1
                        JE(i,i) = -4/(h^2);
                        JE(i,i+1) = 1/(h^2);
                        JE(i,i-l) = 1/(h^2);
                        JE(i,i+P.m) = 1/h;
                    elseif mod(i,l) == 0
                        JE(i,i) = -4/(h^2);
                        JE(i,i-1) = 1/(h^2);
                        JE(i,i-l) = 1/(h^2);
                        JE(i,i+P.m) = 1/h;
                    else
                        JE(i,i) = -4/(h^2);
                        JE(i,i-1) = 1/(h^2);
                        JE(i,i+1) = 1/(h^2);
                        JE(i,i-l) = 1/(h^2);
                        JE(i,i+P.m) = 1/h;
                    end
                elseif mod(i,l) == 1
                    JE(i,i) = -4/(h^2);
                    JE(i,i+1) = 1/(h^2);
                    JE(i,i-l) = 1/(h^2);
                    JE(i,i+l) = 1/(h^2);
                    JE(i,i+P.m) = 1/h;
                else
                    JE(i,i) = -4/(h^2);
                    JE(i,i-1) = 1/(h^2);
                    JE(i,i-l) = 1/(h^2);
                    JE(i,i+l) = 1/(h^2);
                    JE(i,i+P.m) = 1/h;
                end
            else
                JE(i,i) = -4/(h^2);
                JE(i,i-1) = 1/(h^2);
                JE(i,i+1) = 1/(h^2);
                JE(i,i-l) = 1/(h^2);
                JE(i,i+l) = 1/(h^2);
                JE(i,i+P.m) = 1/h;
            end
        end
        if isempty(JE), JE = []; end
      catch
        JE = [];
        err = true;
      end
      
    end % evaluateConstraintJacobianEqualities
    
    % Constraint Jacobian, inequalities
    function [JI,err] = evaluateConstraintJacobianInequalities(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate constraint Jacobian, inequalities
      try
        JI = [];
      catch
        JI = [];
        err = true;
      end
      
    end % evaluateConstraintJacobianInequalities
    
    % Hessian of the Lagrangian
    function [H,err] = evaluateHessianOfLagrangian(P,x,yE,yI)
      
      % Initialize error
      err = false;
      
      % Evaluate Hessian of Lagrangian
      try
        l = sqrt(P.m);
        h = 1/(l+1);
        beta = 1e-5;
        
        H = speye(P.n,P.n);
        H(P.m+1:end,P.m+1:end) = (beta/(h^2)) * speye(P.n-P.m, P.n-P.m);
        
      catch
        H = [];
        err = true;
      end
      
    end % evaluateHessianOfLagrangian
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Initialize error
      err = false;

      % Evaluate objective function
      try
          
          f = 0;
          l = sqrt(P.m);
          h = 1/(l+1);
          beta = 1e-5;
          for k = 1:P.np
              c = sparse(l,l);
              para1 = 4 + fix((k-1)/3) * P.err_lvl/sqrt(15);
              para2 = 3 + mod((k-1),3) * P.err_lvl/sqrt(15);
              for i = 1:l
                  for j = 1:l
                      x1 = i/(l+1);
                      x2 = j/(l+1);
                      c(i,j) = sin(para1*x1) + cos(para2*x2);
                  end
              end
              c = reshape(c,P.m,1);
              
              f = f + (0.5*norm(x(1:P.m,1)-c)^2 + 0.5*(beta/(h^2))*norm(x(P.m+1:end,1))^2);
          end
          f = f/P.np;
        
      catch
        f = [];
        err = true;
      end
            
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x,type,factor)
        
        % Initialize error
        err = false;
        
        if strcmp(type,'stochastic')
            
            % Set random seed
            rng(P.seed);
            
            % Evaluate objective gradient
            try
                
                l = sqrt(P.m);
                h = 1/(l+1);
                c = sparse(l,l);
                beta = 1e-5;
                g = sparse(P.n,1);
                
                for t = 1:factor
                    
                    k = randi([1,P.np]);
                    para1 = 4 + fix((k-1)/3) * P.err_lvl/sqrt(15);
                    para2 = 3 + mod((k-1),3) * P.err_lvl/sqrt(15);
                    
                    for i = 1:l
                        for j = 1:l
                            x1 = i/(l+1);
                            x2 = j/(l+1);
                            c(i,j) = sin(para1*x1) + cos(para2*x2);
                        end
                    end
                    c = reshape(c,P.m,1);
                    
                    g(1:P.m) = g(1:P.m) + x(1:P.m) - c;
                    g(P.m+1:end) = g(P.m+1:end) + (beta/(h^2)) * x(P.m+1:end);
                    
                end
                
                g = g/factor;
                
            catch
                g = [];
                err = true;
            end
            
            % Set random seed
            P.seed = rng;
            
        elseif strcmp(type,'true')
            
            try
                g = sparse(P.n,1);
                l = sqrt(P.m);
                h = 1/(l+1);
                beta = 1e-5;
                for k = 1:P.np
                    c = sparse(l,l);
                    para1 = 4 + fix((k-1)/3) * P.err_lvl/sqrt(15);
                    para2 = 3 + mod((k-1),3) * P.err_lvl/sqrt(15);
                    for i = 1:l
                        for j = 1:l
                            x1 = i/(l+1);
                            x2 = j/(l+1);
                            c(i,j) = sin(para1*x1) + cos(para2*x2);
                        end
                    end
                    c = reshape(c,P.m,1);
                    
                    g(1:P.m) = g(1:P.m) + x(1:P.m) - c;
                    g(P.m+1:end) = g(P.m+1:end) + (beta/(h^2)) * x(P.m+1:end);
                end
                g = g/P.np;
                
            catch
                g = [];
                err = true;
            end
            
        else
            
            err = true;
            error('Point: Incorrect type of inputs to Problem.evaluateObjectiveGradient.');
            
        end
        
    end % evaluateObjectiveGradient
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = sparse(P.x);
      
    end % initialPoint
    
    % Name
    function s = name(P)
      
      % Set name
      s = P.s;
      
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