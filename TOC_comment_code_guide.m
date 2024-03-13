%% GUIDE to changes that needed to be done to all codes to work with TOC and comment system
% by Eleonora
% Find lines of code (control F) that contain the word: Blackrock
% If those lines are the start/stop functions, comment them 
% Add just below that add a new line with the function: TaskComment.m
% The function takes the same variable (name) you were using with start/stop
% (let's say filename) + a flag. The flag needs to be different depending
% on the function you are replacing and its context.
% StartBlackrockAquisition -> 'start'
% StopBlackrockAquisition -> either 'stop' or 'kill' or 'error'
% Note: it's good practice to add a comment to identify changes so that you
% can find them with control+F easily in the future
%
% here is how your code should look:

taskname ='whatever';

%[onlineNSP,~,~]=StartBlackrockAquisition(filename); %changed 02/22/2024 for TOC mode

onlineNSP=TaskComment('start',filename); 


%--------------------------------------------------------------------------
% new block of functions for improved features:
%
% START
%
%read next available EMU number and subject code from a csv log file that
%gets auto-updated and does not require human input:

[EMU_number,sbj_code] = getNextLogEntry(); %read next available from log
% this line will be different for each task, but in general everyone has a
% line where they generate the filename (some call it savefname, etc)
filename = sprintf('EMU-%.4d_subj-%s_task-%s',EMU_number,sbj_code,taskname);
onlineNSP=TaskComment('start',filename); 
% update the log file: add new emu number and filename
%--------------------------------------------------------------------------
% 
% STOP
%
%StopBlackrockAquisition(filename,onlineNSP); %changed 02/22/2024 for TOC mode

TaskComment('stop',filename); 


% if you have your whole code in a try/catch, place this in the catch
TaskComment('error',filename); 

% if you have an abort function, use this to mark the manual stop there:
TaskComment('kill',filename); 

%% special section: if you are sending comments for trials or other events information between your start and stop
% here is how you can make sure that these are getting sent to both NSPs
% (if there are two NSPs)

for jj = 1:numel(onlineNSP) % this uses the output of TaskComment to determine how many NSPs are online
    cbmex('comment',16777215,0,sprintf('%s','whatever your comment is'),'instance',jj-1);
    %added cbmex comment gets sent to each NSP (1=NSP-2 and 0=NSP1)
end

% note: 16777215 is white. Please use this for non-start/stop/err/kill
% comments to make it easier to see the key comments on the screen and
% distinguish them from other trial event comments.

% special section 2: if you are sending comment for trials and other events
% information between your start and stop in a subfunction that does not
% have access to the onlineNSP variable, you can use this workaround: TRY
% to send the comments to 2 NSPs in a try-catch, if only one is available,
% it will not give an error:

for jj = 1:2
    try
        cbmex('comment',16777215,0,sprintf('%s','whatever your comment is'),'instance',jj-1);
    catch
    end
end

% FIN