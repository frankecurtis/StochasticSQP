% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'SCC_diminishing',false);

% Add double options
options.addDoubleOption(reporter,'SCC_scaling',1e+00,0,inf);

end % addOptions