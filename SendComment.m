function SendComment(comment_text)
% send a quick comment to the NSPs
% 
% use:
% SendComment('hello')
%
% Important!
% This is NOT to send comments that are start/stop ones, for those use:
% [onlineNSP]=TaskComment(event,filename) as start/stop use special comment
% structure that is detected by the stitching code
%
% Eleonora 2025

%% Get IP Addresses of NSP ethernet ports
% address = {'192.168.137.1','192.168.137.17'};

address = getIPAddressesFromPortNames({'NSP1','NSP2'});


%% Find/Open Connections to Available Blackrock NSPs, send a comment to all 

availableNSPs = zeros(size(address));
for n=1:length(address)
    try
        cbmex('open','central-addr',address{n},'instance',n-1)
    catch
        disp('Problem with cbmex, check if NSPs are active')
        return
    end
    
    availableNSPs(n) = 1;
end
onlineNSP = find(availableNSPs==1);

%% send Comment
for n = 1:numel(onlineNSP)
    cbmex('comment', 16777215, 0,comment_text,'instance',onlineNSP(n)-1);
    fprintf('%s sent to NSP %d\n',comment_text,n)
end

end