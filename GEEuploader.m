%% GEE uploader
% This is a temporary solution for batch uploading raster file to GEE
% REF: https://developers.google.com/earth-engine/command_line#upload
% REQUIREMENT:
% Install google earth engine python api:
% https://developers.google.com/earth-engine/python_install
% User must have a google account and google cloud storage (gcs)
%
% Step1: upload the files to gcs
% Step2: copy the generated commands to command window (note there's
% a limit of characters in cml, you may seprarate the tasks to avoid this)
%
% MSc in Physical Geography, Uppsala University
% Shunan Feng (冯树楠) fsn.1995@gmail.com
% 20190414

clearvars; close all;

f1 = fopen('geecml.txt','w'); % cml to upload imagery from gcs to gee
f2 = fopen('geemetacml.txt','w'); % cml to change time property

filepath = 'D:\noah\tif\'; % imagery local path, this is to get the date from file names
idpath = 'users/fsn1995/test/'; % id path in GEE asset
geepath = 'earthengine upload image --asset_id=users/fsn1995/test/';
gspath = 'gs://geetest_fsn/tif/'; % file path in gcs
metapath = 'earthengine asset set --time_start';

subdir = dir(filepath);
filenum = length(subdir);

for i = 3:filenum
    name = str2double(subdir(i).name(1:6));
    tifpath = [gspath,subdir(i).name,' & '];
    uploadcml = [geepath,num2str(name)];
    date = datetime(name*100+1,'ConvertFrom','yyyymmdd');
    dateNum = posixtime(date) * 1000;
    idcml = [idpath,num2str(name),' & '];
    fprintf(f1,'%s %s',uploadcml,tifpath);
    fprintf(f2,'%s %d %s',metapath, dateNum, idcml);
end
fclose('all');
