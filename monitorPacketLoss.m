function monitorPacketLoss()
%MONITORPACKETLOSS Monitors the data streaming from the Blackrock Neural
%Signal Processor for any drops in packets/signal
%
% CODE PURPOSE
% Monitors the data streaming from the Blackrock Neural Signal Processor
% for packet loss. In the event of a packet loss, the process attempts to
% approximate the amount of data lost in seconds with a warning in the
% command window.
%
% NOTES
% (1) The process uses a modal message box window. Closing this window
% halts the monitoring process.
% (2) The function has been designed to be very simple in order to allow
% other users to add other functions that can be called when a packet loss
% is detected. Inclusion of a backgroud (parallel_ pool to call functions
% and allow this process to continue monitoring for packet losses is
% recommended.
%
% SYNTAX
% monitorPacketLoss()
%
% Author: Joshua Adkinson


packetLossBoxHandle = msgbox({'Monitoring for packet losses on central.','Close this dialog box to halt monitoring.'},'Packet Loss Monitoring','modal');

address = getIPAddressesFromPortNames({'NSP1','NSP2'});
delay = 0.01;

cbmex('open',0,'central-addr',address{1});
cbmex('trialconfig',1,'double','instance',0,'noevent','continuous',102400);
for i = 2:272
    cbmex('mask',i,0)
end
pause(delay)
while ishandle(packetLossBoxHandle)
    pause(delay)
    [~, checkForData] = cbmex('trialdata',1);
    if isempty(checkForData)
        % INSERT PACKET LOSS FUNCTION CALLBACKS HERE
        missingDataCounter = 0;
        while isempty(checkForData)
            missingDataCounter = missingDataCounter + 1;
            [~, checkForData] = cbmex('trialdata',1);
            a = tic;
            while toc(a) < delay; end
        end
        warning(['PACKET LOSS!! Approximately ',num2str(delay*missingDataCounter),' seconds of contiguous data was not detected.'])
    end
end
cbmex('trialconfig',0)
