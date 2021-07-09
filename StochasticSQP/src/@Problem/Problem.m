% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Problem class
classdef (Abstract) Problem < handle
  
  % Methods (abstract)
  methods (Abstract)
    
    % Constraint function, equalities
    [cE,err] = evaluateConstraintFunctionEqualities(P,x)
    
    % Constraint function, inequalities
    [cI,err] = evaluateConstraintFunctionInequalities(P,x)
    
    % Constraint Jacobian, equalities
    [JE,err] = evaluateConstraintJacobianEqualities(P,x)
    
    % Constraint Jacobian, inequalities
    [JI,err] = evaluateConstraintJacobianInequalities(P,x)
    
    % Hessian of the Lagrangian
    [H,err] = evaluateHessianOfLagrangian(P,x,yE,yI)
    
    % Objective function
    [f,err] = evaluateObjectiveFunction(P,x)
    
    % Objective gradient
    [g,err] = evaluateObjectiveGradient(P,x,type,factor)
    
    % Initial point
    x = initialPoint(P)
    
    % Name
    s = name(P)
    
    % Number of constraints, equalities
    mE = numberOfConstraintsEqualities(P)
    
    % Number of constraints, inequalities
    mI = numberOfConstraintsInequalities(P)
    
    % Number of variables
    n = numberOfVariables(P)
    
  end % methods (abstract)
  
end % Problem