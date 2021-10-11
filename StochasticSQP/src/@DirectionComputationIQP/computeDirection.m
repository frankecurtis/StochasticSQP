% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationSubgradient: computeDirection
function err = computeDirection(D,options,quantities,reporter,strategies)

% Initialize error
err = false;

% Store quantities
cE = quantities.currentIterate.constraintFunctionEqualities(quantities);
JE = quantities.currentIterate.constraintJacobianEqualities(quantities);
cI = quantities.currentIterate.constraintFunctionInequalities(quantities);
% JI = quantities.currentIterate.constraintJacobianInequalities(quantities);

% Determine constraint activities
% cE_P = find(cE > 0);
% cE_N = find(cE < 0);
cI_P = find(cI > 0);
cI_Z = find(cI == 0);

g = quantities.currentIterate.objectiveGradient(quantities,'stochastic');
[xl,xu] = quantities.currentIterate.bounds;

[r,s] = subproblem_lin(JE, cE, quantities.currentIterate.primalPoint, xl, xu);
v = subproblem_quad(g,JE,cE, r, s,quantities.currentIterate.primalPoint,xl,xu);


% Set direction
quantities.setDirectionPrimal(v,'full');


% Compute true direction?
if D.compute_true_
  
    g = quantities.currentIterate.objectiveGradient(quantities,'true');
    [r,s] = subproblem_lin(JE, cE, x);
    [xl,xu] = quantities.currentIterate.bounds;
    v = subproblem_quad(g,JE,cE, r, s,xl,xu);


    % Set direction
    quantities.setDirectionPrimal(v,'true');
    
end

% Set curvature
quantities.setCurvature(v'*v,'full');

% Initialize multipliers
yE = zeros(quantities.currentIterate.numberOfConstraintsEqualities,1);
yI = zeros(quantities.currentIterate.numberOfConstraintsInequalities,1);

% Set multipliers
quantities.currentIterate.setMultipliers(yE,yI,'stochastic');
quantities.currentIterate.setMultipliers(yE,yI,'true');

% Compute least squares multipliers
if false
  
  % Construct "active" Jacobian
  Jacobian = [JE' JI(cI_P,:)' JI(cI_Z,:)'];
  
  % Compute least squares multipliers
  y = -Jacobian\quantities.currentIterate.objectiveGradient(quantities,'stochastic');
  
  % Set multipliers in place
  yE = y(1:quantities.currentIterate.numberOfConstraintsEqualities);
  yI(cI_P) = y(quantities.currentIterate.numberOfConstraintsEqualities+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P));
  yI(cI_Z) = y(quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+length(cI_Z));
  
  % Set multipliers
  quantities.currentIterate.setMultipliers(yE,yI,'stochastic');
  
  % Compute true multipliers?
  if D.compute_true_
    
    % Compute least squares multipliers
    y = -Jacobian\quantities.currentIterate.objectiveGradient(quantities,'true');
    
    % Set multipliers in place
    yE = y(1:quantities.currentIterate.numberOfConstraintsEqualities);
    yI(cI_P) = y(quantities.currentIterate.numberOfConstraintsEqualities+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P));
    yI(cI_Z) = y(quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+length(cI_Z));
    
    % Set multipliers
    quantities.currentIterate.setMultipliers(yE,yI,'true');
    
  end
  
end

end % computeDirection