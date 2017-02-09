function cfg = configuration(config_filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PreProcessing Software for SBE CTD-LADCP                                %
% Autor: Pierre Rousselot / Date: 10/03/16                                %
% Jedi Master: Jacques Grelet                                             %
% -> Create configuration file .mat {parametre_(id_mission).mat}          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cfg                         = ini2struct(config_filename);

% create path CTD
cfg.filename_CTD            = sprintf('%s', cfg.id_mission, cfg.num_station);
cfg.path_output_CTD         = sprintf('%s', cfg.path_SEASOFT, filesep, cfg.name_mission, filesep, cfg.rep_output_CTD);
cfg.path_raw_CTD            = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_raw_CTD);
cfg.path_processing_CTD     = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_processing_CTD);
cfg.path_processing_raw_CTD = sprintf('%s', cfg.rep_processing_CTD, filesep, cfg.rep_processing_raw_CTD);
cfg.path_batch              = sprintf('%s', cfg.rep_processing_CTD, filesep, cfg.rep_batch);
cfg.path_codac              = sprintf('%s', cfg.rep_processing_CTD, filesep, cfg.rep_codac);
cfg.path_reports            = sprintf('%s', cfg.rep_processing_CTD, filesep, cfg.rep_reports);

% create path ADCP
cfg.newfilename_LADCPM      = sprintf('%s', cfg.name_LADCP_master, cfg.num_station, '.000'); 
cfg.newfilename_LADCPS      = sprintf('%s', cfg.name_LADCP_slave, cfg.num_station, '.000');
cfg.path_output_LADCP       = sprintf('%s', cfg.path_LADCP, filesep, cfg.name_mission, filesep, cfg.rep_output_LADCP, filesep);
cfg.path_raw_LADCP          = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_raw_LADCP);
cfg.path_processing_LADCP   = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_processing_LADCP);
cfg.path_save_LADCP         = sprintf('%s', cfg.path_LADCP, filesep, cfg.name_mission, filesep,  cfg.rep_save_LADCP); 
cfg.process_LDEO            = sprintf('%s', cfg.drive, filesep, cfg.name_mission, filesep, cfg.rep_LDEO, filesep, cfg.name_mission); 

% convert to Boolean
cfg.copy_CTD                = str2num(cfg.copy_CTD);
cfg.copy_LADCP              = str2num(cfg.copy_LADCP);
cfg.process_CTD             = str2num(cfg.process_CTD);
cfg.process_LADCP           = str2num(cfg.process_LADCP);
cfg.process_PMEL            = str2num(cfg.process_PMEL);

% clear unused variable
clear cfg.rep_raw_CTD cfg.rep_processing_CTD cfg.rep_raw_LADCP cfg.rep_processing_LADCP cfg.rep_LDEO
clear cfg.rep_processing_raw_CTD cfg.rep_output_CTD cfg.rep_batch cfg.rep_codac cfg.rep_reports cfg.rep_output_LADCP cfg.rep_save_LADCP


end
