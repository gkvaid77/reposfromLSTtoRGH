clear all
close all
clc

% Select signal
%% Ford offline data

p=3;
for io=1:p
clear Signal E_mat E_Cumm_mat e_per CC Eb_eps
[outputsOfflineFile,outputPathName] = uigetfile('*.csv');
opts = detectImportOptions(outputsOfflineFile);
opts.DataLines = 3;
opts.VariableNamesLine = 1;
offlineOutput = readtable(outputsOfflineFile,opts);

[refData,in,out,ref,tOut,tRef,ind_start,ind_end,signalCount,sineA,sinef] ...
    = extractOfflineData_Lat(offlineOutput);


f(io,:)=outputsOfflineFile(1:end-7);          % f : file location char string
    perceptionT = 0.05/9.81;    % perception limits in units of signal input
    binsize = 20;               % bin size for CC segmental calculations
%     p =length(f(:,1));          % # the error processing script you want to run.
    sampf = 200;                % sampling frequency of signal

Signal.in = in;
Signal.out = out;
Signal.time = tOut;

[E_mat,E_Cumm_mat,e_per,CC,Eb_eps]=Error_Classification_eps(Signal,binsize,perceptionT,sampf);

ProcessNPlot_eps(Signal,E_mat,E_Cumm_mat,e_per,Eb_eps,perceptionT,f,p,io);
end

%% Ford Online data

% close all
% clear
% clc
% 
% 
% addpath(genpath(pwd))
% 
% 
% headerOffline = readtable('VI_DriveSim_Cueing_Signals.xlsx', ...
%     'Sheet','Inputs_Offline','Range','A:A');
% headerOnline  = readtable('VI_DriveSim_Cueing_Signals.xlsx', ...
%     'Sheet','Outputs_Offline','Range','A:A');



% Input Signal Type
% 1. OD
% 2. CarMaker
% 3. Vehile Test Data
% signalType = input(['Select Input Signal Type : \n' ...
%     '1. OD \n'...
%     '2. CarMaker \n'...
%     '3. Vehile Test Data - Steering \n' ...
%     'Input - ']);
% 
% if signalType == 1
%     inputSignalType = 'OD';
%     for axis = [5 6]
%         clearvars -except signalType axis headerOffline headerOnline...
%             path_resultsOffline path_resultsOnline inputSignalType
%     end
% elseif signalType == 2
%     inputSignalType = 'CarMaker';
% elseif signalType == 3
%     inputSignalType = 'SDNA';
% else
%     disp('Incorrect Input. Exiting.')
%     return
% end
% 
% path_resultsOffline = [pwd '\cueingOfflineOutputFiles'];
% path_resultsOnline  = [pwd '\cueingOnlineOutputFiles'];
% outputsOfflinePath = [path_resultsOffline '\' inputSignalType];
% outputsOnlinePath  = [path_resultsOnline '\' inputSignalType];
% 
% fileList = dir(outputsOnlinePath);
% fullFileName = string(strcat(char(fileList.folder), ...
%     '\',char(fileList.name)));
% fileInd = contains(string(char(fileList.name)),manName,'IgnoreCase',true);
% outputsOnlineDir = strcat(char(fileList(fileInd).folder), ...
%     '\',char(fileList(fileInd).name));
% outputsOnlineFile = dir([outputsOnlineDir '\*.csv']);
% 
% onlineOutput = readtable(outputsOnlineFile.name);
