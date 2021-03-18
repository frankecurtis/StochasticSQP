% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'FD_full_samples',false);

% Add double options
options.addDoubleOption(reporter,'FD_Lipschitz_estimate_iter_first',1,0,inf);
options.addDoubleOption(reporter,'FD_Lipschitz_estimate_iter_later',1e+4,0,inf);
options.addDoubleOption(reporter,'FD_Lipschitz_estimate_sample_distance',1e-04,0,inf);

end % addOptions