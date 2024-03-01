function initializeLogFile(subjID)
%% Initialize Log 
% Paul J Steffan 2024 Feb 26
% 
% This script is designed to create a simple log of Tasks Run in the EMU.
% In this script, we will create the first value in a table that we will
% initialize for a given patient.


%% THIS IS HUGELY IMPORTANT--YOU NEED TO MAKE SURE THE CURRENT/ FOLDER IS EMPTY!!

logFolder = fullfile(userpath,'PatientData','+CurrentPatientLog');
if ~exist(logFolder,'dir')
    mkdir(logFolder)
end
files = dir(logFolder);
files = files(~[files.isdir]);
if ~isempty(files)
   error('The CurrentPatientLog Folder should be empty prior to initializing a new log file!!! Please remove any files from this folder before using this function!!') 
end

%% 
emu_id = 0;
task_id = 'Initialize Log';
% success_id = 1;

%%
% T = cell2table({emu_id,task_id,success_id},"VariableNames", ["emu_id","task_id","success_id"]);
T = cell2table({emu_id,task_id},"VariableNames", ["emu_id","task_id"]);
logFilename = [subjID,'_log.csv'];
writetable(T,fullfile(logFolder,logFilename));