% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Reporter class
classdef Reporter < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%
    % QUANTITIES %
    %%%%%%%%%%%%%%
    list = {}
            
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function R = Reporter(varargin)
      
      % Declare global enumerations
      global R_SOLVER R_SUBSOLVER
      global R_PER_ITERATION R_PER_INNER_ITERATION
      
      % Set global type enumerations
      R_SOLVER = 0;
      R_SUBSOLVER = 1;
      
      % Set global level enumerations
      R_PER_ITERATION = 0;
      R_PER_INNER_ITERATION = 1;
      
      % Add standard output by default
      R.addStandardOutputReport(R_SOLVER,R_PER_ITERATION);
      
    end % Constructor
    
    % Destructor
    function delete(R)
      
      % Clear global variables
      clear global R_SOLVER R_SUBSOLVER
      clear global R_PER_ITERATION R_PER_INNER_ITERATION
      
      % Close file reports
      for i = 1:length(R.list)
        
        % Check for non-standard output
        if R.list{i}.fileID ~= 1 && R.list{i}.fileID ~= 2
          
          % Close file
          fclose(R.list{i}.fileID);
          
        end
        
      end
      
    end % Destructor
    
    % Add standard output report
    function addStandardOutputReport(R,type,level)
      
      % Create report
      report.type   = type;
      report.level  = level;
      report.fileID = 1;
      
      % Add report to list
      R.list(length(R.list)+1) = {report};
      
    end
    
    % Add standard error report
    function addStandardErrorReport(R,type,level)
      
      % Create report
      report.type   = type;
      report.level  = level;
      report.fileID = 2;
      
      % Add report to list
      R.list(length(R.list)+1) = {report};
      
    end
    
    % Add file report
    function addFileReport(R,type,level,file_name)
      
      % Open file
      fileID = fopen(file_name,'w');
      
      % Check for success
      if fileID == -1
        warning('StochasticSQP: Could not open file (%s).\n',file_name);
      else
        
        % Create report
        report.type   = type;
        report.level  = level;
        report.fileID = fileID;
        
        % Add report to list
        R.list(length(R.list)+1) = {report};
        
      end
      
    end
    
    % Print, formatted
    function printf(R,type,level,format,varargin)
      
      % Loop through reports
      for i = 1:length(R.list)
        
        % Check for acceptability
        if R.list{i}.type == type && R.list{i}.level >= level
          
          % Print line
          fprintf(R.list{i}.fileID,format,varargin{:});
          
        end
        
      end
      
    end
    
  end
  
end