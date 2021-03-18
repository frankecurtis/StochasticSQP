% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: getOptions
function getOptions(L,options,reporter)

% Get options
L.FD_full_samples_ = options.getOption(reporter,'FD_full_samples');
L.FD_Lipschitz_estimate_iter_first_ = options.getOption(reporter,'FD_Lipschitz_estimate_iter_first');
L.FD_Lipschitz_estimate_iter_later_ = options.getOption(reporter,'FD_Lipschitz_estimate_iter_later');
L.FD_Lipschitz_estimate_sample_distance_ = options.getOption(reporter,'FD_Lipschitz_estimate_sample_distance');

end % getOptions