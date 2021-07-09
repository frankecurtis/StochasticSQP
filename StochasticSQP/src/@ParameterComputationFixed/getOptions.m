% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationFixed: getOptions
function getOptions(P,options,reporter)

% Get options
P.quadratic_model_ = options.getOption(reporter,'PCF_quadratic_model');

end % getOptions