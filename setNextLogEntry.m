function setNextLogEntry(newEntry)
%SETNEXTLOGENTRY Writes the new task entry into CurrentPatientLog file
%
% CODE PURPOSE
% Writes the new task entry into the CurrentPatientLog file as a table with
% entries for the EMU number and, optionally, the filename given for the
% task
%
% SYNTAX
% setNextLogEntry()
% setNextLogEntry(filename)
%
% INPUT
% newEntry - a character array identifying the new entry into the
%               CurrentPatientLog
%
% NOTE
% If this function does not find a CurrentPatientLog file or finds more
% than one in the folder, the code immediately sends an error message to
% the user so that proper measure can be taken to resolve the issue.
%
% Author: Paul J Steffan & Joshua Adkinson

if nargin == 0
    newEntry = "";
end

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
    T = readtable(fullfile(tableFile.folder,tableFile.name),'Delimiter',',');

    % New EMU ID
    emu_id_prev = T.emu_id(end);
    emu_id_new = emu_id_prev + 1;

    Task_ID = newEntry;
    %         success_id = 0;
    %         new_row = cell2table({emu_id_new,Task_ID,success_id},"VariableNames", ["emu_id","task_id","success_id"]);
    new_row = cell2table({emu_id_new,Task_ID},"VariableNames", ["emu_id","task_id"]);
    T = [T;new_row];
    writetable(T,fullfile(tableFile.folder,tableFile.name));
end
end