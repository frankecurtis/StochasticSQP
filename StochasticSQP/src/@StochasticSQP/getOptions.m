% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StochasticSQP: getOptions
function getOptions(S)

% Get options for quantities
S.quantities_.getOptions(S.options_,S.reporter_);

% Get options for strategies
S.strategies_.getOptions(S.options_,S.reporter_);

end % getOptions