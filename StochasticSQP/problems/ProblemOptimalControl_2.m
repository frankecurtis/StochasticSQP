% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ProblemCUTEst class
classdef ProblemOptimalControl_2 < Problem
  
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
    function P = ProblemOptimalControl_2
      
      % Set parameter h
      h = 0.01;
      
      % Set number of variables
      P.n = (1/h - 1)^2 + 8*(1/h - 1);
      
      % Get initial point
      P.x = sparse(ones(P.n, 1));
      
      % Set number of constraints
      P.m = (1/h - 1)^2 + 4*(1/h - 1);
            
      % Set name
      P.s = 'OPTCONT_2';
      
      % Set number of problems
      P.np = 9;
      
      % Set error level
      P.err_lvl = 0.1;
            
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
        l = (P.n - P.m)/4;
        h = 1/(l+1);
        cE = sparse(P.m,1);
        for i = 1:(l^2)
            if i <= l || i > (l*(l-1)) || mod(i,l) == 1 || mod(i,l) == 0
                if i <= l
                    if mod(i,l) == 1
                        cE(i) = x(i) - (x(i+l) + x(i+1) + x(l^2+1) + x(l^2+l+1) - 4*x(i))/(h^2);
                    elseif mod(i,l) == 0
                        cE(i) = x(i) - (x(i+l) + x(i-1) + x(l^2+l) + x(l^2+2*l+1) - 4*x(i))/(h^2);
                    else
                        cE(i) = x(i) - (x(i+l) + x(i-1) + x(i+1) + x(l^2+i) - 4*x(i))/(h^2);
                    end
                elseif i > (l*(l-1))
                    if mod(i,l) == 1
                        cE(i) = x(i) - (x(i-l) + x(i+1) + x(l^2+2*l) + x(l^2+3*l+1) - 4*x(i))/(h^2);
                    elseif mod(i,l) == 0
                        cE(i) = x(i) - (x(i-l) + x(i-1) + x(l^2+3*l) + x(l^2+4*l) - 4*x(i))/(h^2);
                    else
                        cE(i) = x(i) - (x(i-l) + x(i-1) + x(i+1) + x(4*l+i) - 4*x(i))/(h^2);
                    end
                elseif mod(i,l) == 1
                    cE(i) = x(i) - (x(i-l) + x(i+l) + x(i+1) + x(fix(i/l)+1+l^2+l) - 4*x(i))/(h^2);
                else
                    cE(i) = x(i) - (x(i-l) + x(i+l) + x(i-1) + x(fix(i/l)+1+l^2+2*l) - 4*x(i))/(h^2);
                end
            else
                cE(i) = x(i) - (x(i-l) + x(i+l) + x(i-1) + x(i+1) - 4*x(i))/(h^2);
            end
        end
        for i = 1:l
            cE(l^2+i) = (x(l^2+i) - x(i))/h - x(l^2+4*l+i)/h;
            cE(l^2+l+i) = (x(l^2+l+i) - x((i-1)*l+1))/h - x(l^2+4*l+l+i)/h;
            cE(l^2+2*l+i) = (x(l^2+2*l+i) - x(i*l))/h - x(l^2+4*l+2*l+i)/h;
            cE(l^2+3*l+i) = (x(l^2+3*l+i) - x(l*(l-1)+i))/h - x(l^2+4*l+3*l+i)/h;
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
        l = (P.n - P.m)/4;
        h = 1/(l+1);
        JE = sparse(P.m,P.n);
        for i = 1:(l^2)
            if i <= l || i > (l*(l-1)) || mod(i,l) == 1 || mod(i,l) == 0
                if i <= l
                    if mod(i,l) == 1
                        JE(i,i) = 1+4/(h^2); JE(i,i+l) = -1/(h^2); JE(i,i+1) = -1/(h^2); JE(i,l^2+1) = -1/(h^2); JE(i,l^2+l+1) = -1/(h^2);
                    elseif mod(i,l) == 0
                        JE(i,i) = 1+4/(h^2); JE(i,i+l) = -1/(h^2); JE(i,i-1) = -1/(h^2); JE(i,l^2+l) = -1/(h^2); JE(i,l^2+2*l+1) = -1/(h^2);
                    else
                        JE(i,i) = 1+4/(h^2); JE(i,i+l) = -1/(h^2); JE(i,i-1) = -1/(h^2); JE(i,i+1) = -1/(h^2); JE(i,l^2+i) = -1/(h^2);
                    end
                elseif i > (l*(l-1))
                    if mod(i,l) == 1
                        JE(i,i) = 1+4/(h^2); JE(i,i-l) = -1/(h^2); JE(i,i+1) = -1/(h^2); JE(i,l^2+2*l) = -1/(h^2); JE(i,l^2+3*l+1) = -1/(h^2);
                    elseif mod(i,l) == 0
                        JE(i,i) = 1+4/(h^2); JE(i,i-l) = -1/(h^2); JE(i,i-1) = -1/(h^2); JE(i,l^2+3*l) = -1/(h^2); JE(i,l^2+4*l) = -1/(h^2);
                    else
                        JE(i,i) = 1+4/(h^2); JE(i,i-l) = -1/(h^2); JE(i,i-1) = -1/(h^2); JE(i,i+1) = -1/(h^2); JE(i,4*l+i) = -1/(h^2);
                    end
                elseif mod(i,l) == 1
                    JE(i,i) = 1+4/(h^2); JE(i,i-l) = -1/(h^2); JE(i,i+l) = -1/(h^2); JE(i,i+1) = -1/(h^2); JE(i,fix(i/l)+1+l^2+l) = -1/(h^2);
                else
                    JE(i,i) = 1+4/(h^2); JE(i,i-l) = -1/(h^2); JE(i,i+l) = -1/(h^2); JE(i,i-1) = -1/(h^2); JE(i,fix(i/l)+1+l^2+2*l) = -1/(h^2);
                end
            else
                JE(i,i) = 1+4/(h^2); JE(i,i-l) = -1/(h^2); JE(i,i+l) = -1/(h^2); JE(i,i-1) = -1/(h^2); JE(i,i+1) = -1/(h^2);
            end
        end
        for i = 1:l
            JE(l^2+i,l^2+i) = 1/h; JE(l^2+i,i) = -1/h; JE(l^2+i,l^2+4*l+i) = -1/h;
            JE(l^2+l+i,l^2+l+i) = 1/h; JE(l^2+l+i,(i-1)*l+1) = -1/h; JE(l^2+l+i,l^2+4*l+l+i) = -1/h;
            JE(l^2+2*l+i,l^2+2*l+i) = 1/h; JE(l^2+2*l+i,i*l) = -1/h; JE(l^2+2*l+i,l^2+4*l+2*l+i) = -1/h;
            JE(l^2+3*l+i,l^2+3*l+i) = 1/h; JE(l^2+3*l+i,l*(l-1)+i) = -1/h; JE(l^2+3*l+i,l^2+4*l+3*l+i) = -1/h;
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
        l = (P.n - P.m)/4;
        h = 1/(l+1);
        beta = 1e-5;
        
        H = speye(P.n,P.n);
        H(l^2+4*l+1:end,l^2+4*l+1:end) = (beta/(h^2)) * speye(P.n - (l^2+4*l), P.n - (l^2+4*l));

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
            l = (P.n - P.m)/4;
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
                c = reshape(c,l^2,1);
                c_cont = sparse(4*l,1);
                for i = 1:l
                    x1 = i/(l+1);
                    c_cont(i) = sin(para1*x1) + cos(0);
                    c_cont(i+l) = sin(0) + cos(para2*x1);
                    c_cont(i+2*l) = sin(para1*1) + cos(para2*x1);
                    c_cont(i+3*l) = sin(para1*x1) + cos(para2*1);
                end
                c = [c;c_cont];
                
                f = f + (0.5*norm(x(1:(l^2+4*l),1)-c)^2 + 0.5*(beta/(h^2))*norm(x(l^2+4*l+1:end,1))^2);
                
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
                
                l = (P.n - P.m)/4;
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
                    c = reshape(c,(l^2),1);
                    c_cont = sparse(4*l,1);
                    for i = 1:l
                        x1 = i/(l+1);
                        c_cont(i) = sin(para1*x1) + cos(0);
                        c_cont(i+l) = sin(0) + cos(para2*x1);
                        c_cont(i+2*l) = sin(para1*1) + cos(para2*x1);
                        c_cont(i+3*l) = sin(para1*x1) + cos(para2*1);
                    end
                    c = [c;c_cont];
                    
                    g(1:(l^2+4*l)) = g(1:(l^2+4*l)) + x(1:(l^2+4*l)) - c;
                    g(l^2+4*l+1:end) = g(l^2+4*l+1:end) + (beta/(h^2)) * x(l^2+4*l+1:end);
                    
                end
                
                g = g/factor;
                
            catch
                g = [];
                err = true;
            end
            
            % Set random seed
            P.seed = rng;
            
        elseif strcmp(type,'true')
            
            % Evaluate objective gradient
            try
                l = (P.n - P.m)/4;
                h = 1/(l+1);
                g = sparse(P.n,1);
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
                    c = reshape(c,(l^2),1);
                    c_cont = sparse(4*l,1);
                    for i = 1:l
                        x1 = i/(l+1);
                        c_cont(i) = sin(para1*x1) + cos(0);
                        c_cont(i+l) = sin(0) + cos(para2*x1);
                        c_cont(i+2*l) = sin(para1*1) + cos(para2*x1);
                        c_cont(i+3*l) = sin(para1*x1) + cos(para2*1);
                    end
                    c = [c;c_cont];
                    
                    g(1:(l^2+4*l)) = g(1:(l^2+4*l)) + x(1:(l^2+4*l)) - c;
                    g(l^2+4*l+1:end) = g(l^2+4*l+1:end) + (beta/(h^2)) * x(l^2+4*l+1:end);
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