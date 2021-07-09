% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Strategies: initialize
function initialize(S,options,quantities,reporter)

% Initialize
S.direction_computation_.initialize(options,quantities,reporter);
S.lipschitz_estimation_.initialize(options,quantities,reporter);
S.parameter_computation_.initialize(options,quantities,reporter);
S.stepsize_computation_.initialize(options,quantities,reporter);

end % initialize