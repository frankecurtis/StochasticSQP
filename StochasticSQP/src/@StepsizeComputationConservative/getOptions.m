% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: getOptions
function getOptions(S,options,reporter)

% Get options
S.objective_Lipschitz_ = options.getOption(reporter,'SCC_objective_Lipschitz');
S.constraint_Lipschitz_ = options.getOption(reporter,'SCC_constraint_Lipschitz');
S.stepsize_diminishing_ = options.getOption(reporter,'SCC_stepsize_diminishing');
S.stepsize_scaling_ = options.getOption(reporter,'SCC_stepsize_scaling');

end % getOptions