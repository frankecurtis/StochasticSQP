% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StochasticSQP: addOptions
function addOptions(S)

% Add options from quantities
S.quantities_.addOptions(S.options_,S.reporter_);

% Add options from strategies
S.strategies_.addOptions(S.options_,S.reporter_);

end % addOptions