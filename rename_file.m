%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rename file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mission_id = 'EK188';
path_dir   = 'C:\SEASOFT\SOLSTICE-EK188';
list       = dir(path_dir);

for ii = 1 : length(list)
   if strfind(list(ii).name, 'CTD')
      oldfilename = [path_dir filesep list(ii).name];
      newfilename = [path_dir filesep mission_id list(ii).name(5:end)];
      movefile(oldfilename, newfilename)
   end   
end