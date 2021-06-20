% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: getOptions
function getOptions(S,options,reporter)

% Get options
S.diminishing_ = options.getOption(reporter,'SCA_diminishing');
S.direction_norm_tolerance_ = options.getOption(reporter,'SCA_direction_norm_tolerance');
S.lengthening_ = options.getOption(reporter,'SCA_lengthening');
S.lengthening_ratio_ = options.getOption(reporter,'SCA_lengthening_ratio');
S.projection_width_ = options.getOption(reporter,'SCA_projection_width');
S.scaling_ = options.getOption(reporter,'SCA_scaling');
S.sufficient_decrease_ = options.getOption(reporter,'SCA_sufficient_decrease');

end % getOptions