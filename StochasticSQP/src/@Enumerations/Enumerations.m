% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Enumerations class
classdef Enumerations < uint8
  
  enumeration
    
    %%%%%%%%%%%%%%%%%%
    % REPORTER TYPES %
    %%%%%%%%%%%%%%%%%%
    R_SOLVER (0)
    R_SUBSOLVER (1)
    
    %%%%%%%%%%%%%%%%%%%
    % REPORTER LEVELS %
    %%%%%%%%%%%%%%%%%%%
    R_BASIC (0)
    R_PER_ITERATION (1)
    R_PER_INNER_ITERATION (2)
    R_DETAILED (3)
    
    %%%%%%%%%%%%%%%%%%%
    % SOLVER STATUSES %
    %%%%%%%%%%%%%%%%%%%
    S_UNSET (0)
    S_SUCCESS (1)
    S_CPU_TIME_LIMIT (2)
    S_SIZE_LIMIT (3)
    S_ITERATION_LIMIT (4)
    S_EVALUATION_LIMIT (5)
    S_DIRECTION_COMPUTATION_FAILURE (6)
    
  end % enumeration
  
end % Enumerations