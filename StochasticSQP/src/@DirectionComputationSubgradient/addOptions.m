% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationSubgradient: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCS_compute_true',false);
options.addBoolOption(reporter,'DCS_compute_least_squares_multipliers',false);

end % addOptions