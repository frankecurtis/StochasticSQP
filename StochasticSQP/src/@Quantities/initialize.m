% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Quantities: initialize
function initialize(Q,problem)

% Set current iterate
Q.current_iterate_ = Point(problem);

% Set previous iterate
Q.previous_iterate_ = Q.current_iterate_;

% Set best iterate
Q.best_iterate_ = Q.current_iterate_;

% Set multiplier
Q.current_iterate_.setMultipliers(zeros(problem.numberOfConstraintsEqualities,(problem.numberOfConstraintsEqualities > 0)),...
  zeros(problem.numberOfConstraintsInequalities,(problem.numberOfConstraintsInequalities > 0)),...
  'stochastic');

% Set true multiplier
Q.current_iterate_.setMultipliers(zeros(problem.numberOfConstraintsEqualities,(problem.numberOfConstraintsEqualities > 0)),...
  zeros(problem.numberOfConstraintsInequalities,(problem.numberOfConstraintsInequalities > 0)),...
  'true');

% Start clock
tic;

end % initialize