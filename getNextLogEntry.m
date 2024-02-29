function [emu_id,Subj,T] = getNextLogEntry()
    tableFile = dir(fullfile(userpath,'PatientData','+CurrentPatientLog'));
    tableFile = tableFile(~[tableFile.isdir]);
    if length(tableFile) > 1
        message = 'DANGER!! MORE THAN ONE FILE DETECTED IN +CURRENTPATIENTLOG FOLDER';
        msgbox(message,'More than one file detected','error')
        return
    else
        filename = tableFile.name;
        % Split the string using underscore as the delimiter
        fileParts = split(filename, '_');
        Subj = fileParts{1};
        
        T = readtable(fullfile(tableFile.folder,tableFile.name));
        emu_id_prev = str2double(T.emu_id(end));
        
        emu_id = emu_id_prev + 1;
    end
end 