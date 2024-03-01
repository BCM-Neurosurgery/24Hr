function updateSuccessLogEntry()

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
    T = readtable(fullfile(tableFile.folder,tableFile.name));
    T.success_id(end) = 1;
    writetable(T,fullfile(tableFile.folder,tableFile.name));
end

end