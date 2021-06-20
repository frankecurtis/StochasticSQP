% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'SCA_diminishing',false);
options.addBoolOption(reporter,'SCA_lengthening',true);

% Add double options
options.addDoubleOption(reporter,'SCA_direction_norm_tolerance',1e-16,0,inf);
options.addDoubleOption(reporter,'SCA_lengthening_ratio',1.1e+00,1,inf);
options.addDoubleOption(reporter,'SCA_projection_width',1e+04,0,inf);
options.addDoubleOption(reporter,'SCA_scaling',1e+00,0,inf);
options.addDoubleOption(reporter,'SCA_sufficient_decrease',5e-01,0,1);

end % addOptions