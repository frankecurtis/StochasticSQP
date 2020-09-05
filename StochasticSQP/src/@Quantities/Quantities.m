% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Quantities class
classdef Quantities < handle
    
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ALGORITHM QUANTITIES %
    %%%%%%%%%%%%%%%%%%%%%%%%
    current_iterate_
    direction_
    stepsize_
    trial_iterate_
    
    %%%%%%%%%%%%
    % COUNTERS %
    %%%%%%%%%%%%
    function_counter_
    gradient_counter_
    iteration_counter_
    inner_iteration_counter_
    total_inner_iteration_counter_
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    cpu_time_limit_
    function_evaluation_limit_
    gradient_evaluation_limit_
    
  end
  
  % Methods (static)
  methods (Static)
    
    % Add options
    function addOptions(options)
      
      % Add bool options
      
      % Add integer options
      
      % Add double options
      options.addDoubleOption('cpu_time_limit',600,0,inf);
      options.addDoubleOption('function_evaluation_limit',1e+04,0,inf);
      options.addDoubleOption('gradient_evaluation_limit',1e+04,0,inf);
      
    end % end addOptions
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function Q = Quantities(varargin)
      
      % Initialize counters
      Q.function_counter_ = 0;
      Q.gradient_counter_ = 0;
      Q.iteration_counter_ = 0;
      Q.inner_iteration_counter_ = 0;
      Q.total_inner_iteration_counter_ = 0;
      
    end % Constructor
    
    % Current iterate
    function iterate = currentIterate(Q)
      
      % Set return value
      iterate = Q.current_iterate_;
      
    end % end currentIterate
        
    % Get options
    function getOptions(Q,options)
      
      % Get bool options
      
      % Get integer options
      
      % Get double options
      Q.cpu_time_limit_ = options.getOption('cpu_time_limit');
      Q.function_evaluation_limit_ = options.getOption('function_evaluation_limit');
      Q.gradient_evaluation_limit_ = options.getOption('gradient_evaluation_limit');
      
    end % end getOptions
    
    % Increment iteration counter
    function incrementIterationCounter(Q)
      
      % Increment iteration counter
      Q.iteration_counter_ = Q.iteration_counter_ + 1;
      
    end % end incrementIterationCounter
    
    % Initialization
    function initialize(Q,problem)
      
      % Set current iterate
      Q.current_iterate_ = Point(problem);
      
    end % end initialize
    
    % Iteration counter
    function k = iterationCounter(Q)
      
      % Set return value
      k = Q.iteration_counter_;
      
    end % end iterationCounter

    % Set trial iterate
    function setTrialIterate(Q,iterate)
      
      % Set trial iterate
      Q.trial_iterate_ = iterate;
      
    end
    
    % Trial iterate
    function iterate = trialIterate(Q)
      
      % Set return value
      iterate = Q.trial_iterate_;
      
    end % end trialIterate
    
    % Update iterate
    function updateIterate(Q)
      
      % Set current iterate to trial iterate
      Q.current_iterate_ = Q.trial_iterate_;
      
    end % end updateIterate
    
  end
  
end