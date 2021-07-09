% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StepsizeComputationAdaptive: getOptions
function getOptions(S,options,reporter)

% Get options
S.direction_norm_tolerance_ = options.getOption(reporter,'SCA_direction_norm_tolerance');
S.lengthening_ = options.getOption(reporter,'SCA_lengthening');
S.lengthening_ratio_ = options.getOption(reporter,'SCA_lengthening_ratio');
S.projection_width_ = options.getOption(reporter,'SCA_projection_width');
S.sufficient_decrease_ = options.getOption(reporter,'SCA_sufficient_decrease');

end % getOptions