% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StepsizeComputationAdaptive: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'SCA_lengthening',true);

% Add double options
options.addDoubleOption(reporter,'SCA_direction_norm_tolerance',1e-16,0,inf);
options.addDoubleOption(reporter,'SCA_lengthening_ratio',1.1e+00,1,inf);
options.addDoubleOption(reporter,'SCA_projection_width',1e+04,0,inf);
options.addDoubleOption(reporter,'SCA_sufficient_decrease',5e-01,0,1);

end % addOptions