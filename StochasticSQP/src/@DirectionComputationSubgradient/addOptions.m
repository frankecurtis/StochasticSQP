% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationSubgradient: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCS_compute_true',false);
options.addBoolOption(reporter,'DCS_compute_least_squares_multipliers',false);

end % addOptions