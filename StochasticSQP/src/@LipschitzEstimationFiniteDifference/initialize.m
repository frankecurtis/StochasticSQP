% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% LipschitzEstimationFiniteDifference: initialize
function initialize(L,options,quantities,reporter)

% Initialize random number generator
rng(L.seed_);

% Initialize lipschitz constants
quantities.setLipschitz(L.lipschitz_constraint_initial_,L.lipschitz_objective_initial_);

end % initialize