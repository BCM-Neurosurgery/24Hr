%% This is some example code for how to use the getEMU and set EMU Funtions
% You will need to run InitializeLog if you have not already 


%First get the next EMU number 
[EMU_ID, Subj, T] = getEMU();


% You can do whatever you want with this information! 
TaskInfo = 'block2_run4';
TaskID = ['EMU-',EMU_ID,'_subj','-',Subj,'_',TaskInfo];

setEMU(EMU_ID, TaskID, T)

%EMU-0001_subj-YEX_task-whatever_NSP-1.ns3
