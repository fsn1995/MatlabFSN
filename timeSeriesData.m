function [yr,mo,dy,hr,mi,se,data] = timeSeriesData(timeData,timeStep,t1,t2,predata)
%% This script reads time series data input and extract the period of interest and fill the date and data gaps
% [timeData]: timeInput in the format of matlab datetime
% [timeStep]: time steps of desired time series e.g. hours(1)-->every 1 hr
% [t1 t2]: the start and end study time; in the format of matlab datetime
% [predata]: the original input of data
% the date output is in the order of year, month, day, hour, minute, second
% [data] is the output of date and data gaps filled results
% example:
% [yr,mo,dy,hr,mi,se,temp] = timeSeriesData(time,hours(1),t1,t2,temp);
% INTERPOLATION METHOD CAN BE CHANGED: see help fillmissing

% Shunan Feng: fsn.1995@gmail.com
% written for thesis work in Uppsala University, 20190220

time = (datetime(t1):timeStep:datetime(t2))';
i = find(timeData < t1, 1); 
if isempty(i)
    error('Start time does not exist in data')
end
i = find(timeData > t2, 1); 
if isempty(i)
    error('End time does not exist in data')
end
fprintf('Time range of the dataset \n%s-%s\n', timeData(1),timeData(end));
if length(timeData) ~= length(time)
    index = ismember(time,timeData);
    data = nan(size(time));
    dataStart = find(timeData == t1);
    dataEnd = find(timeData == t2);
    nullNum = sum(index == 0);
    fprintf('%d date gaps found \n',nullNum);
    disp(time(index == 0));
    data(index == 1) = predata(dataStart:1:dataEnd);
    nullNum = sum(isnan(data));
    fprintf('%d data gaps found \n',nullNum);
    disp(time(isnan(data)));
    data = fillmissing(data,'linear');
else
    data = fillmissing(predata,'linear');
end
[yr,mo,dy] = ymd(time);
[hr,mi,se] = hms(time);
end