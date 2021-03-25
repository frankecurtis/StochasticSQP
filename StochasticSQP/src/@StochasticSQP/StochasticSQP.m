% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% StochasticSQP
%
% Please cite:
%
%   A. S. Berahas, F. E. Curtis, D. P. Robinson, and B. Zhou.  "Sequential
%   Quadratic Optimization for Nonlinear Equality Constrained Stochastic
%   Optimization." arXiv, 2007.10525.  2020.
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
%   [x,y] = S.solution
%       Returns solution estimate.

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
    
    % Final iterate
    function [x,yE,yI,infeasibility,stationarity] = finalIterate(S)
      
      % Set return values
      x = S.quantities_.currentIterate.primalPoint;
      [yE,yI] = S.quantities_.currentIterate.multipliers;
      infeasibility = S.quantities_.currentIterate.constraintNormInf(S.quantities_);
      stationarity = S.quantities_.currentIterate.stationarityMeasure(S.quantities_);
      
    end % finalIterate
    
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
    
    % Solution (best)
    function [x,yE,yI,infeasibility,stationarity] = solution(S)
      
      % Set return values
      x = S.quantities_.bestIterate.primalPoint;
      [yE,yI] = S.quantities_.bestIterate.multipliers('stochastic');
      infeasibility = S.quantities_.bestIterate.constraintNormInf(S.quantities_);
      stationarity = S.quantities_.bestIterate.stationarityMeasure(S.quantities_,'true');

    end % solution
    
    % Get upper bound of the ratio
    function [upperRatio] = getUpperRatio(S)
        
        % Set return values
        upperRatio = S.quantities_.innerIterationRelativeLimit;
        
    end % getUpperRatio
    
    % Get baseline ratio
    function [baseInnerIter] = baselineInnerIteration(S)
        
        % Set return values
        baseInnerIter = S.quantities_.innerIterationCounter;
        
    end % baselineInnerIteration
    
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