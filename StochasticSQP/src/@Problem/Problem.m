% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Problem class
classdef (Abstract) Problem < handle
  
  % Methods (abstract)
  methods (Abstract)
    
    % Objective function
    [f,err] = evaluateObjectiveFunction(P,x)
      
    % Objective gradient
    [g,err] = evaluateObjectiveGradient(P,x)
      
    % Constraint function
    [c,err] = evaluateConstraintFunction(P,x)
      
    % Constraint Jacobian
    [J,err] = evaluateConstraintJacobian(P,x)
    
    % Hessian of the Lagrangian
    [H,err] = evaluateHessianOfLagrangian(P,x,y)
    
    % Initial point
    x = initialPoint(P)
    
    % Number of constraints
    m = numberOfConstraints(P)
    
    % Number of variables
    n = numberOfVariables(P)
    
  end % methods (abstract)
  
end % Problem