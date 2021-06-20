% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: getOptions
function getOptions(S,options,reporter)

% Get options
S.diminishing_ = options.getOption(reporter,'SCC_diminishing');
S.scaling_ = options.getOption(reporter,'SCC_scaling');

end % getOptions