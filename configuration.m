function cfg = configuration(config_filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PreProcessing Software for SBE CTD-LADCP                                %
% Autor: Pierre Rousselot / Date: 10/03/16    ok                          %
% Jedi Master: Jacques Grelet                                             %
% -> Create configuration file .mat {parametre_(id_mission).mat}          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cfg                         = ini2struct(config_filename);

% create path CTD
cfg.filename_CTD            = sprintf('%s', cfg.id_mission, cfg.num_station);
cfg.path_output_CTD         = sprintf('%s', cfg.path_SEASOFT, filesep, cfg.name_mission, filesep, cfg.rep_output_CTD, filesep);
cfg.path_raw_CTD            = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_raw_CTD, filesep);
cfg.path_processing_CTD     = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_processing_CTD, filesep);
cfg.path_processing_raw_CTD = sprintf('%s', cfg.path_processing_CTD, cfg.rep_processing_raw_CTD, filesep);
cfg.path_batch              = sprintf('%s', cfg.path_processing_CTD, cfg.rep_batch, filesep);
cfg.path_codac              = sprintf('%s', cfg.path_processing_CTD, cfg.rep_codac, filesep);
cfg.path_reports            = sprintf('%s', cfg.path_processing_CTD, cfg.rep_reports);

% create path ADCP
cfg.newfilename_LADCPM      = sprintf('%s', cfg.id_mission, 'M', cfg.num_station, '.000'); 
cfg.newfilename_LADCPS      = sprintf('%s', cfg.id_mission, 'S', cfg.num_station, '.000');
cfg.path_output_LADCP       = sprintf('%s', cfg.path_LADCP, filesep, cfg.name_mission, filesep, cfg.rep_output_LADCP, filesep);
cfg.path_raw_LADCP          = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_raw_LADCP, filesep);
cfg.path_processing_LADCP   = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_processing_LADCP, filesep);
cfg.path_save_LADCP         = sprintf('%s', cfg.path_LADCP, filesep, cfg.name_mission, filesep,  cfg.rep_save_LADCP, filesep); 
cfg.process_LDEO            = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_LDEO, filesep, cfg.name_mission, filesep); 

% find filename ADCP
master_file = fopen(sprintf('%s', cfg.path_LADCP, filesep, cfg.name_mission, filesep, 'MASTER.TXT'), 'r');
slave_file = fopen(sprintf('%s', cfg.path_LADCP, filesep, cfg.name_mission, filesep, 'SLAVE.TXT'), 'r');
M = fscanf(master_file, '%s');
S = fscanf(slave_file, '%s');
cfg.filename_LADCPM = [M(strfind(M, 'RN')+2:strfind(M, 'RN')+6),'000.000'];
cfg.filename_LADCPS = [S(strfind(S, 'RN')+2:strfind(S, 'RN')+6),'000.000'];


% convert to Boolean
cfg.copy_CTD                = str2num(cfg.copy_CTD);
cfg.copy_LADCP              = str2num(cfg.copy_LADCP);
cfg.process_CTD             = str2num(cfg.process_CTD);
cfg.process_LADCP           = str2num(cfg.process_LADCP);
cfg.process_PMEL            = str2num(cfg.process_PMEL);
cfg.process_BTL             = str2num(cfg.process_BTL);

% clear unused variable
clear cfg.rep_raw_CTD cfg.rep_processing_CTD cfg.rep_raw_LADCP cfg.rep_processing_LADCP cfg.rep_LDEO
clear cfg.rep_processing_raw_CTD cfg.rep_output_CTD cfg.rep_batch cfg.rep_codac cfg.rep_reports cfg.rep_output_LADCP cfg.rep_save_LADCP


end
