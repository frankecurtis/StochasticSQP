% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Reporter class
classdef Reporter < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    list = {}
    
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function R = Reporter
      
      % Add standard output by default
      R.addStandardOutputReport(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION);
      
    end % Constructor
    
    %%%%%%%%%%%%%%
    % DESTRUCTOR %
    %%%%%%%%%%%%%%
    
    % Destructor
    function delete(R)
      
      % Close file reports
      for i = 1:length(R.list)
        
        % Check for non-standard output
        if R.list{i}.fileID ~= 1 && R.list{i}.fileID ~= 2
          
          % Close file
          fclose(R.list{i}.fileID);
          
        end
        
      end
      
    end % Destructor
    
    %%%%%%%%%%%%%%%
    % ADD METHODS %
    %%%%%%%%%%%%%%%
    
    % Add standard output report
    function addStandardOutputReport(R,type,level)
      
      % Create report
      report.type   = type;
      report.level  = level;
      report.fileID = 1;
      
      % Add report to list
      R.list(length(R.list)+1) = {report};
      
    end % addStandardOutputReport
    
    % Add standard error report
    function addStandardErrorReport(R,type,level)
      
      % Create report
      report.type   = type;
      report.level  = level;
      report.fileID = 2;
      
      % Add report to list
      R.list(length(R.list)+1) = {report};
      
    end % addStandardErrorReport
    
    % Add file report
    function addFileReport(R,type,level,file_name)
      
      % Open file
      fileID = fopen(file_name,'w');
      
      % Check for success
      if fileID == -1
        warning('Reporter: Could not open file (%s).\n',file_name);
      else
        
        % Create report
        report.type   = type;
        report.level  = level;
        report.fileID = fileID;
        
        % Add report to list
        R.list(length(R.list)+1) = {report};
        
      end
      
    end % addFileReport
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
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
      
    end % printf
    
  end % methods (public access)
  
end % Reporter