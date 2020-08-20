% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Stochastic SQP: optimize
function optimize(S,problem)

% Set problem
S.problem = problem;

% Get options
S.getOptions;

% Set iterate
S.iterate = Point(S.problem);

% Determine scale factors
S.iterate.determineScaleFactors(S.problem,S.scale_factor_gradient_limit);

% Main loop
for k = 1:5
  
  % Evaluate iterate values
  S.iterate.primalPoint
  S.iterate.objectiveFunction(S.problem)
  S.iterate.objectiveGradient(S.problem)
  S.iterate.constraintFunction(S.problem)
  S.iterate.constraintJacobian(S.problem)
  
  % Compute trial iterate
  trial_iterate = S.iterate.makeLinearCombination(1.0,-S.iterate.objectiveGradient(S.problem));
  
  % Evaluate trial iterate values
  trial_iterate.primalPoint
  trial_iterate.objectiveFunction(S.problem)
  trial_iterate.objectiveGradient(S.problem)
  trial_iterate.constraintFunction(S.problem)
  trial_iterate.constraintJacobian(S.problem)
  
  % Update iterate
  S.iterate = trial_iterate;
    
end

end