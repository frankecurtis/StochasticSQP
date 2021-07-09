% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationSubgradient: getOptions
function getOptions(D,options,reporter)

% Get options
D.compute_true_ = options.getOption(reporter,'DCS_compute_true');
D.compute_least_squares_multipliers_ = options.getOption(reporter,'DCS_compute_least_squares_multipliers');

end % getOptions