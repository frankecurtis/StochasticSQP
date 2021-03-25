% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: getOptions
function getOptions(S,options,reporter)

% Get options
S.objective_Lipschitz_ = options.getOption(reporter,'SCA_objective_Lipschitz');
S.constraint_Lipschitz_ = options.getOption(reporter,'SCA_constraint_Lipschitz');
S.projection_width_ = options.getOption(reporter,'SCA_projection_width');
S.stepsize_diminishing_ = options.getOption(reporter,'SCA_stepsize_diminishing');
S.stepsize_scaling_ = options.getOption(reporter,'SCA_stepsize_scaling');
S.sufficient_decrease_ = options.getOption(reporter,'SCA_sufficient_decrease');
S.lengthening_ratio_ = options.getOption(reporter,'SCA_lengthening_ratio');
S.diminishing_ratio_ = options.getOption(reporter,'SCA_diminishing_ratio');
S.forward_lengthening_ = options.getOption(reporter,'SCA_forward_lengthening');
S.direction_norm_tolerance_ = options.getOption(reporter,'SCA_direction_norm_tolerance');

end % getOptions