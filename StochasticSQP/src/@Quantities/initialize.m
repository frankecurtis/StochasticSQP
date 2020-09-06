% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Quantities: initialize
function initialize(Q,problem)

% Set current iterate
Q.current_iterate_ = Point(problem);

% Set multiplier
Q.multiplier_ = zeros(problem.numberOfConstraints,1);

% Start clock
tic;

end % initialize