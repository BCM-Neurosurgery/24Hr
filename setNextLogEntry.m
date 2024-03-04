function setNextLogEntry(newEntry)
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