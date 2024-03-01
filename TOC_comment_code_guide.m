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

filename ='whatever';

%[onlineNSP,~,~]=StartBlackrockAquisition(filename); %changed 02/22/2024 for TOC mode
onlineNSP=TaskComment('start',filename); 

%StopBlackrockAquisition(filename,onlineNSP); %changed 02/22/2024 for TOC mode
TaskComment('stop',filename); 

%% if you have additional stops for abort and errors:

%StopBlackrockAquisition(filename,onlineNSP); %changed 02/22/2024 for TOC mode

% if you have an abort function, use this to mark the manual stop there:
TaskComment('kill',filename); 

% if you have your whole code in a try/catch, place this in the catch
TaskComment('error',filename); 

%% special section: if you are sendng comments for trials or other events information between your start and stop
% here is how you can make sure that these are getting sent to both NSPs
% (if there are two NSPs)

for jj = onlineNSP % this uses the output of TaskComment to determine how many NSPs are online
    cbmex('comment',255,0,sprintf('%s','whatever your comment is'),'instance',jj-1);
    %added cbmex comment gets sent to each NSP (1=NSP-2 and 0=NSP1)
end

% FIN