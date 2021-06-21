% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationSubgradient: getOptions
function getOptions(D,options,reporter)

% Get options
D.compute_true_ = options.getOption(reporter,'DCS_compute_true');
D.compute_least_squares_multipliers_ = options.getOption(reporter,'DCS_compute_least_squares_multipliers');

end % getOptions