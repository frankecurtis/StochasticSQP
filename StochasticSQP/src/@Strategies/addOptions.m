% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Strategies: addOptions
function addOptions(options,reporter)

% Add options
options.addStringOption(reporter,'direction_computation','EQP');
options.addStringOption(reporter,'lipschitz_estimation','FiniteDifference');
options.addStringOption(reporter,'parameter_computation','ModelReduction');
options.addStringOption(reporter,'stepsize_computation','Adaptive');

% Add direction computation options
d = DirectionComputationEQP;
d.addOptions(options,reporter);
d = DirectionComputationSubgradient;
d.addOptions(options,reporter);

% Add Lipschitz estimation options
l = LipschitzEstimationFiniteDifference;
l.addOptions(options,reporter);

% Add parameter computation options
m = ParameterComputationFixed;
m.addOptions(options,reporter);
m = ParameterComputationModelReduction;
m.addOptions(options,reporter);

% Add stepsize computation options
s = StepsizeComputationAdaptive;
s.addOptions(options,reporter);
s = StepsizeComputationConservative;
s.addOptions(options,reporter);

end % addOptions