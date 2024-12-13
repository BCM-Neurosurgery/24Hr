% setup communication with NSPs
% Eleonora December 2024
% run this code to setup the communication between NSPs, Central and Matlab
% for streaming data
% start with:
% NSPs on
% DO NOT turn on Central
% run these lines

cbmex('open',2,'central-addr','192.168.137.1','instance',0);
cbmex('open',2,'central-addr','192.168.137.17','instance',1);

% turn on Central
% load default config
% run these lines

sprintf('Now open Central\n')
input('Press Entrer when ready to continue: ')

cbmex('trialconfig',1,'instance',0)
cbmex('trialconfig',1,'instance',1)

cbmex('trialdata',1,'instance',0)
cbmex('trialdata',1,'instance',1)

% done

%% MISC: this to do it programmatically in case we change IP address in the future, not done yet
%
% address = getIPAddressesFromPortNames({'NSP1','NSP2'});
% 
% 
% %% Find/Open Connections to Available Blackrock NSPs
% availableNSPs = zeros(size(address));
% for i=1:length(address)
%     try
%         cbmex('open','central-addr',address{i},'instance',i-1)
%     catch
%         continue
%     end
%     fprintf('NSP%d Active\n',i)
%     availableNSPs(i) = 1;
% end


