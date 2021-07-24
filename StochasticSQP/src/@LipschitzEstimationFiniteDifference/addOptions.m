% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% LipschitzEstimationFiniteDifference: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'LEFD_coordinate_directions',false);
options.addBoolOption(reporter,'LEFD_random_direction',true);
options.addBoolOption(reporter,'LEFD_use_true_gradient',false);

% Add double options
options.addDoubleOption(reporter,'LEFD_displacement',1e-04,0,inf);
options.addDoubleOption(reporter,'LEFD_lipschitz_constraint_initial',1.0,0,inf);
options.addDoubleOption(reporter,'LEFD_lipschitz_constraint_minimum',1e-12,0,inf);
options.addDoubleOption(reporter,'LEFD_lipschitz_objective_initial',1.0,0,inf);
options.addDoubleOption(reporter,'LEFD_lipschitz_objective_minimum',1e-12,0,inf);

% Add integer options
options.addIntegerOption(reporter,'LEFD_estimate_always_until',1,-1,inf);
options.addIntegerOption(reporter,'LEFD_estimate_frequency',inf,1,inf);

end % addOptions