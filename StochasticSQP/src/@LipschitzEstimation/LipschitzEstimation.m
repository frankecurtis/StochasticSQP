% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% LipschitzEstimation class
classdef (Abstract) LipschitzEstimation < Strategy
  
  % Methods (abstract, static)
  methods (Abstract, Static)
    
    % Add options
    addOptions(options,reporter)
    
  end % methods (abstract, static)
  
  % Methods (abstract)
  methods (Abstract)
    
    % Print iteration header
    printIterationHeader(S,reporter)
    
    % Print iteration values
    printIterationValues(S,quantities,reporter)
    
    % Get options
    getOptions(S,options,reporter)
    
    % Initialize
    initialize(S,options,quantities,reporter)
    
    % Name
    n = name(S)
    
    % Compute merit parameter
    estimateLipschitzConstants(S,options,quantities,reporter,strategies)
    
  end % methods (abstract)
  
end % LipschitzEstimation