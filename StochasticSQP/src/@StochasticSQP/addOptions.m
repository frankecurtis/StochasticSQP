% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Stochastic SQP: addOptions
function addOptions(S)

% Add bool options
S.options.addBoolOption('scale_problem',true);

% Add integer options
S.options.addIntegerOption('iteration_limit',1e+03,0,inf);

% Add double options
S.options.addDoubleOption('stationarity_tolerance',1e-06,0,inf);
S.options.addDoubleOption('scale_factor_gradient_limit',1e+02,0,inf);

% Add string options
% (if any)

% Add options from quantities
S.quantities.addOptions(S.options);

% Add options from strategies
% (TO DO)

end
