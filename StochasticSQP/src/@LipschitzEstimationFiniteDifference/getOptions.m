% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% LipschitzEstimationFiniteDifference: getOptions
function getOptions(L,options,reporter)

% Get options
L.coordinate_directions_ = options.getOption(reporter,'LEFD_coordinate_directions');
L.displacement_ = options.getOption(reporter,'LEFD_displacement');
L.estimate_always_until_ = options.getOption(reporter,'LEFD_estimate_always_until');
L.estimate_frequency_ = options.getOption(reporter,'LEFD_estimate_frequency');
L.lipschitz_constraint_initial_ = options.getOption(reporter,'LEFD_lipschitz_constraint_initial');
L.lipschitz_constraint_minimum_ = options.getOption(reporter,'LEFD_lipschitz_constraint_minimum');
L.lipschitz_objective_initial_ = options.getOption(reporter,'LEFD_lipschitz_objective_initial');
L.lipschitz_objective_minimum_ = options.getOption(reporter,'LEFD_lipschitz_objective_minimum');
L.random_direction_ = options.getOption(reporter,'LEFD_random_direction');
L.use_true_gradient_ = options.getOption(reporter,'LEFD_use_true_gradient');

end % getOptions