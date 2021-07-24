% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ProblemCUTEst class
classdef ProblemCUTEst < Problem
  
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
    seed % seed for random number generator
    
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemCUTEst(seed)
      
      % Initialize CUTEst
      prob = cutest_setup();
      
      % Get initial point
      P.x = prob.x;
      
      % Set number of variables
      P.n = prob.n;
      
      % Get variable bounds
      P.xl = prob.bl;
      P.xu = prob.bu;
      
      % Set indices of variable bounds (that are finite)
      P.ixl = find(P.xl > -1e+18);
      P.ixu = find(P.xu <  1e+18);
      if isempty(P.ixl) == true, P.ixl = []; end
      if isempty(P.ixu) == true, P.ixu = []; end
      
      % Set numbers of variable bounds (that are finite)
      P.nxl = length(P.ixl);
      P.nxu = length(P.ixu);
      
      % Set number of constraints
      P.m = prob.m;
      
      % Get constraint lower bounds
      P.cl = prob.cl;
      
      % Get constraint upper bounds
      P.cu = prob.cu;
      
      % Set indices of constraint types
      P.ice = find(P.cl == P.cu);
      P.icl = setdiff(find(P.cl > -1e+18),P.ice);
      P.icu = setdiff(find(P.cu <  1e+18),P.ice);
      if isempty(P.ice) == true, P.ice = []; end
      if isempty(P.icl) == true, P.icl = []; end
      if isempty(P.icu) == true, P.icu = []; end
      
      % Set numbers of constraint types
      P.mce = length(P.ice);
      P.mcl = length(P.icl);
      P.mcu = length(P.icu);
      
      % Set name
      P.s = prob.name;
      
      % Set random number generator seed
      P.seed = seed;
      
    end % Constructor
    
    %%%%%%%%%%
    % DELETE %
    %%%%%%%%%%
    
    % Descructor
    function delete(P)
      
      % Terminate CUTEst
      cutest_terminate;
      
    end % destructor
    
    % Check for constant objective function
    function err = constantObjective(P)
      
      % Initialize error
      err = true;
      
      % Evaluate objective at random points
      try
        f = cutest_obj(P.x);
        for i = 1:10
          f_other = cutest_obj(P.x + randn(length(P.x),1));
          if abs(f - f_other) > 0
            err = false;
          end
        end
      catch
        warning('ProblemCUTEst: Function evaluation error in constantObjective.');
      end
      
    end % checkForConstantObjective
    
    % Constraint function, equalities
    function [cE,err] = evaluateConstraintFunctionEqualities(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate constraint function, equalities
      try
        c = cutest_cons(x);
        cE = c(P.ice) - P.cu(P.ice);
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
        c = cutest_cons(x);
        cI = [P.cl(P.icl) - c(P.icl); c(P.icu) - P.cu(P.icu); P.xl(P.ixl) - x(P.ixl); x(P.ixu) - P.xu(P.ixu)];
        if isempty(cI), cI = []; end
        if max(isnan(cI)), err = true; end
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
        [~,J] = cutest_cons(x);
        JE = sparse(J(P.ice,:));
        if isempty(JE), JE = []; end
        if max(max(isnan(JE))), err = true; end
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
        [~,J] = cutest_cons(x);
        JI = sparse(P.mcl+P.mcu+P.nxl+P.nxu,P.n);
        JI(1:P.mcl+P.mcu,1:P.n) = [-J(P.icl,:); J(P.icu,:)];
        JI(P.mcl+P.mcu+1:P.mcl+P.mcu+P.nxl,P.ixl) = -speye(P.nxl,P.nxl);
        JI(P.mcl+P.mcu+P.nxl+1:P.mcl+P.mcu+P.nxl+P.nxu,P.ixu) = speye(P.nxu,P.nxu);
        if isempty(JI), JI = []; end
        if max(max(isnan(JI))), err = true; end
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
        yEorig = zeros(P.m,1);
        yLorig = zeros(P.m,1);
        yUorig = zeros(P.m,1);
        yEorig(P.ice) =  yE;
        yLorig(P.icl) = -yI(1:P.mcl);
        yUorig(P.icu) =  yI(P.mcl+1:P.mcl+P.mcu);
        H = sparse(cutest_hess(x,yEorig + yLorig + yUorig));
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
        f = cutest_obj(x);
      catch
        f = [];
        err = true;
      end
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x,type,factor)
      
      % Initialize error
      err = false;
      
      % Evaluate objective gradient
      try
        
        % Check type
        if strcmp(type,'stochastic')
          rng(P.seed);
          g = cutest_grad(x) + (10^(-factor)/sqrt(P.n)) * randn(P.n,1);
          P.seed = rng;
        elseif strcmp(type,'true')
          g = cutest_grad(x);
        else
          error('ProblemCUTEst: Invalid type for evaluateObjectiveGradient.');
        end
      catch
        g = [];
        err = true;
      end
      
    end % evaluateObjectiveGradient
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = P.x;
      
    end % initialPoint
    
    % Name
    function s = name(P)
      
      % Set name
      s = P.s;
      
    end % name
    
    % Number of constraints, equalities
    function mE = numberOfConstraintsEqualities(P)
      
      % Set number of constraints, equalities
      mE = P.mce;
      
    end % numberOfConstraintsEqualities
    
    % Number of constraints, inequalities
    function mI = numberOfConstraintsInequalities(P)
      
      % Set number of constraints, inequalities
      mI = P.mcl + P.mcu + P.nxl + P.nxu;
      
    end % numberOfConstraintsInequalities
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end % numberOfVariables
    
  end % methods (public access)
  
end % ProblemCUTEst