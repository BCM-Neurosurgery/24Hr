function [emuNum,subjID,T] = getNextLogEntry()
%GETNEXTLOGENTRY Gets the EMU number and subject ID from CurrentPatientLog
%
% CODE PURPOSE
% Determine the subject ID and next EMU number to write to the
% CurrentPatientLog file. Additionally, allows output of the
% CurrentPatientLog table entries
%
% SYNTAX
% [emuNum,subjID] = getNextLogEntry()
% [emuNum,subjID,T] = getNextLogEntry()
%
% OUTPUT
% emuNum - an integer representing the next EMU number to be used by the
%           TaskComment function
% subjID - a character array representing the ID of the current subject
% T      - a table of the current entries in the CurrentPatientLog file
%
% NOTE
% If this function does not find a CurrentPatientLog file or finds more
% than one in the folder, the code immediately sends an error message to
% the user so that proper measure can be taken to resolve the issue.
%
% Author: Paul J Steffan & Joshua Adkinson

tableFile = dir(fullfile(userpath,'PatientData','+CurrentPatientLog'));
tableFile = tableFile(~[tableFile.isdir]);
if isempty(tableFile)
    message = 'DANGER!! NO FILE DETECTED IN +CURRENTPATIENTLOG FOLDER';
    msgbox(message,'No file detected','error')
    return
elseif length(tableFile) > 1
    message = 'DANGER!! MORE THAN ONE FILE DETECTED IN +CURRENTPATIENTLOG FOLDER';
    msgbox(message,'More than one file detected','error')
    return
else
    filename = tableFile.name;
    % Split the string using underscore as the delimiter
    fileParts = split(filename, '_');
    subjID = fileParts{1};

    T = readtable(fullfile(tableFile.folder,tableFile.name),'Delimiter',',');
    emuNumPrev = T.emu_id(end);
    emuNum = emuNumPrev + 1;
end
end