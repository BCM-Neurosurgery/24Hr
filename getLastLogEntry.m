function [] = getLastLogEntry()
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
        Subj = fileParts{1};
        
        T = readtable(fullfile(tableFile.folder,tableFile.name),'Delimiter',',');
        emu_id = T.emu_id(end);
        
    end
    
    disp(['The Current Patient is ', sprintf('%04d', emu_id),'and the patient is ', Subj])
    
    
end 