% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Strategies: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
S.direction_computation_.printIterationHeader(reporter);
S.parameter_computation_.printIterationHeader(reporter);
S.lipschitz_estimation_.printIterationHeader(reporter);
S.stepsize_computation_.printIterationHeader(reporter);

end % printIterationHeader