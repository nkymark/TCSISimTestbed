% Prints comments and textual outputs to the "Simulation Log" of the GUI.
%
%           stringLog = PrintLog( stringLog, stringText, flag, handles )
% 
% 
% This function takes in 'stringText' and prints it to the 'Simulation Log' section of the GUI with 
% the specified tag of 'stringHandles'. The 'flag' determines the various modes of which 
% 'stringText' is sent to the Log:
%   flag = 1: Print stringLog to Log directly
%   flag = 2: Store stringText to stringLog only
%   flag = 3: Concatenate stringText to stringLog and print updated stringLog
% 
% 
% (C) Mark Ng, 2019
% Ulster University, UK
%
%-------------------------------------------------------------------------%
%               Prints the string stringText to the Log in the GUI               
%-------------------------------------------------------------------------%
function stringLog = PrintLog( stringLog, stringText, flag, stringHandles )

if isempty( stringLog )     % Empty Log
    stringLog = stringText;
    return;
end

if flag == 1        % Print stringLog to Log
    stringLog = char( stringLog,stringText );
    set( stringHandles, 'string', stringLog )
elseif flag == 2    % Store stringText to stringLog only
    stringLog = char( stringLog,stringText );
elseif flag == 3    % Concatenate stringText to stringLog and print updated stringLog
    stringLog = char( stringLog(1:end-1,:), strcat( stringLog(end,:), stringText ) );
    set( stringHandles, 'string', stringLog );
end

%-------------------------------------------------------------------------%
