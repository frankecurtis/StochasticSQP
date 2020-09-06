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
S.sufficient_decrease_ = options.getOption(reporter,'SCA_sufficient_decrease');

end % getOptions