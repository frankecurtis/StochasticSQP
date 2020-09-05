% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Stochastic SQP: getOptions
function getOptions(S)

% Get bool options
S.scale_problem = S.options.getOption('scale_problem');

% Get integer options
S.iteration_limit = S.options.getOption('iteration_limit');

% Get double options
S.stationarity_tolerance = S.options.getOption('stationarity_tolerance');
S.scale_factor_gradient_limit = S.options.getOption('scale_factor_gradient_limit');

% Add string options
% (if any)

% Get quantities options
S.quantities.getOptions(S.options);

end
