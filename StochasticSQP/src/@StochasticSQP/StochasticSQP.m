% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.
%
% StochasticSQP
%
% Constructors:
%
%   S = StochasticSQP
%
% Public methods:
%
%   S.optimize(problem)
%       Runs optimization algorithm.
%
%   [x,yE,yI,infeasibility,kkt_error] = bestIterate(S)
%       Returns best iterate.
%
%   [x,yE,yI,infeasibility,kkt_error] = finalIterate(S)
%       Returns final iterate.
%
%   o = options(S)
%       Returns options object.
%
%   r = reporter(S)
%       Returns reporter object.

% StochasticSQP class
classdef StochasticSQP < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Members %
    %%%%%%%%%%%
    options_
    quantities_
    reporter_
    status_
    strategies_
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function S = StochasticSQP
      
      % Set options
      S.options_ = Options;
      
      % Set quantities
      S.quantities_ = Quantities;
      
      % Set reporter
      S.reporter_ = Reporter;
      
      % Set strategies
      S.strategies_ = Strategies;
      
      % Add options
      S.addOptions;
      
    end % Constructor
    
    %%%%%%%%%%%%
    % OPTIMIZE %
    %%%%%%%%%%%%
    
    % Optimize
    optimize(S,problem)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Best iterate
    function [x,yE,yI,infeasibility,kkt_error] = bestIterate(S)
      
      % Set return values
      x = S.quantities_.bestIterate.primalPoint;
      [yE,yI] = S.quantities_.bestIterate.multipliers('stochastic');
      infeasibility = S.quantities_.bestIterate.constraintNormInf(S.quantities_);
      kkt_error = S.quantities_.bestIterate.KKTError(S.quantities_,'stochastic');
      
    end % bestIterate
    
    % Final iterate
    function [x,yE,yI,infeasibility,kkt_error] = finalIterate(S)
      
      % Set return values
      x = S.quantities_.currentIterate.primalPoint;
      [yE,yI] = S.quantities_.currentIterate.multipliers('stochastic');
      infeasibility = S.quantities_.currentIterate.constraintNormInf(S.quantities_);
      kkt_error = S.quantities_.currentIterate.KKTError(S.quantities_,'stochastic');
      
    end % finalIterate
    
    
    function [x,yE,yI,infeasibility,kkt_error,objective] = solution(S)
      % Set return values
      x = S.quantities_.bestIterate.primalPoint;
      [yE,yI] = S.quantities_.bestIterate.multipliers('true');
      infeasibility = S.quantities_.bestIterate.constraintNormInf(S.quantities_);
      kkt_error = S.quantities_.bestIterate.KKTError(S.quantities_,'true');
      objective = S.quantities_.bestIterate.objectiveFunction(S.quantities_);
    end
    
    
    % Options
    function o = options(S)
      
      % Set return value
      o = S.options_;
      
    end % options
    
    % Reporter
    function r = reporter(S)
      
      % Set return value
      r = S.reporter_;
      
    end % reporter
    
  end % methods (public access)
  
  % Methods (private access)
  methods (Access = private)
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print footer
    printFooter(S)
    
    % Print header
    printHeader(S,P)
    
    % Print iteration header
    printIterationHeader(S)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(S)
    
    % Get options
    getOptions(S)
    
  end % methods (private access)
  
end % StochasticSQP