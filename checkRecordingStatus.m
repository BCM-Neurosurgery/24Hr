function checkRecordingStatus()
%CHECKRECORDINGSTATUS Checks the recording status of the Blackrock Central
%Software Suite. In the event of no recording in progress, a recording is
%initialized.
%
% CODE PURPOSE
% (1) Checks the recording status of the Blackrock Central Software Suite
% (2) If no recording is in progress, the function (a) issues a warning,
% (b) closes the File Storage window, (c) reopens File Storage, and (d)
% initializes a recording into the directory (hard-coded into function)
%
% SYNTAX
% checkRecordingStatus()
%
% Author: Joshua Adkinson

recording = cbmex('fileconfig');
if ~recording
    warning('Central was not recording! Initiallizing a recording now...')
    % Get Recording Path
    [~,subjID] = getNextLogEntry();
    recordingPath = fullfile('D:','DATA',[subjID,'Datafile'],'DATA'); %<-HARDCODED
    % Reset File Storage
    cbmex('fileconfig','','',0,'option','close')
    pause(0.5)
    cbmex('fileconfig','','',0,'option','open')
    pause(0.5)
    % Initialize Recording
    cbmex('fileconfig',recordingPath,'',1)
end