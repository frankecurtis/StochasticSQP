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
JI = quantities.currentIterate.constraintJacobianInequalities(quantities);

% Determine constraint activities
cE_P = find(cE > 0);
cE_N = find(cE < 0);
cI_P = find(cI > 0); % By the project subgradient method, cI_P should always be empty
cI_Z = find(cI == 0);

if sum(sum(isnan([JE(cE_P,:);JE(cE_N,:);JI(cI_P,:);JI(cI_Z,:)]))) > 0 || sum(sum(isinf([JE(cE_P,:);JE(cE_N,:);JI(cI_P,:);JI(cI_Z,:)])))>0 
    err = true;
else
% Compute subgradient
v = quantities.meritParameter * quantities.currentIterate.objectiveGradient(quantities,'stochastic');
if quantities.currentIterate.numberOfConstraintsEqualities > 0
  v = v + (ones(length(cE_P),1)'*JE(cE_P,:))' - (ones(length(cE_N),1)'*JE(cE_N,:))';
end
if quantities.currentIterate.numberOfConstraintsInequalities > 0
  v = v + (ones(length(cI_P),1)'*JI(cI_P,:))';
end

% Set direction
quantities.setDirectionPrimal(-v,'full');
quantities.setDirectionPrimal(-v,'normal');

% Set curvature
quantities.setCurvature(v'*v,'full');

% Compute true direction?
if D.compute_true_
  % Compute subgradient
  v = quantities.meritParameter * quantities.currentIterate.objectiveGradient(quantities,'true');
  if quantities.currentIterate.numberOfConstraintsEqualities > 0
    v = v + (ones(length(cE_P),1)'*JE(cE_P,:))' - (ones(length(cE_N),1)'*JE(cE_N,:))';
  end
  if quantities.currentIterate.numberOfConstraintsInequalities > 0
    v = v + (ones(length(cI_P),1)'*JI(cI_P,:))';
  end
  
  % Set direction
  quantities.setDirectionPrimal(-v,'true');
  
end

% Initialize multipliers
yE = zeros(quantities.currentIterate.numberOfConstraintsEqualities,1);
yI = zeros(quantities.currentIterate.numberOfConstraintsInequalities,1);

% Set multipliers
quantities.currentIterate.setMultipliers(yE,yI,'stochastic');
quantities.currentIterate.setMultipliers(yE,yI,'true');

% Compute least squares multipliers
if D.compute_least_squares_multipliers_
  
  % Construct "active" Jacobian

  Jacobian = [JE' JI(cI_P,:)' JI(cI_Z,:)'];
  
  % Compute least squares multipliers
  %   y = -Jacobian\quantities.currentIterate.objectiveGradient(quantities,'stochastic');
    
  lb = -Inf(quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+length(cI_Z),1);
  lb(quantities.currentIterate.numberOfConstraintsEqualities+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+length(cI_Z)) = 0;
  options = optimoptions('lsqlin','Algorithm','interior-point','Display','off');  
  y = lsqlin(Jacobian,-quantities.currentIterate.objectiveGradient(quantities,'stochastic'),[],[],[],[],lb,[],[],options);
    
  
  % Set multipliers in place
  yE = y(1:quantities.currentIterate.numberOfConstraintsEqualities);
  yI(cI_P) = y(quantities.currentIterate.numberOfConstraintsEqualities+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P));
  yI(cI_Z) = y(quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+length(cI_Z));
  
  % Set multipliers
  quantities.currentIterate.setMultipliers(yE,yI,'stochastic');
  
  % Compute true multipliers?
  if D.compute_true_
    
      y_true = lsqlin(Jacobian,-quantities.currentIterate.objectiveGradient(quantities,'true'),[],[],[],[],lb,[],[],options);

      yE_true = zeros(quantities.currentIterate.numberOfConstraintsEqualities,1);
      yI_true = zeros(quantities.currentIterate.numberOfConstraintsInequalities,1);
      % Set multipliers in place
      yE_true = y_true(1:quantities.currentIterate.numberOfConstraintsEqualities);
      yI_true(cI_P) = y_true(quantities.currentIterate.numberOfConstraintsEqualities+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P));
      yI_true(cI_Z) = y_true(quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+1:quantities.currentIterate.numberOfConstraintsEqualities+length(cI_P)+length(cI_Z));

      % Set multipliers
      quantities.currentIterate.setMultipliers(yE_true,yI_true,'true');
    
  end
  
end
end

end % computeDirection