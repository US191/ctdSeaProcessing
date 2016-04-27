function p = configuration(config_filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PreProcessing Software for SBE CTD-LADCP                                %
% Autor: Pierre Rousselot / Date: 10/03/16                                %
% Jedi Master: Jacques Grelet                                             %
% -> Create configuration file .mat {parametre_(id_mission).mat}          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p                    = ini2struct(config_filename);

% create path CTD
p.filename_CTD       = sprintf('%s', p.id_mission, p.num_station);
p.path_processingCTD = sprintf('%s', p.drive, p.name_mission, p.pprocessingctd);
p.path_processCTD    = sprintf('%s', p.path_processingCTD, p.pprocessctd);
p.path_rawCTD        = sprintf('%s', p.drive, p.name_mission, p.prawctd);
p.path_outputCTD     = sprintf('%s', p.path_seasoft, p.name_mission, p.poutputctd');
p.path_batch         = sprintf('%s', p.path_processingCTD, p.pbatch);
p.path_codac         = sprintf('%s', p.path_processingCTD, p.pcodac);
p.path_reports       = sprintf('%s', p.path_processingCTD, p.preports);

% create path ADCP
p.path_processADCP   = sprintf('%s', p.drive, p.name_mission, p.pprocessingadcp);
p.path_rawADCP       = sprintf('%s', p.drive, p.name_mission, p.prawadcp);
p.path_outputADCP    = sprintf('%s', p.path_dataladcp, p.name_mission, p.poutputadcp);
p.path_moveADCP      = sprintf('%s', p.path_dataladcp, p.name_mission, p.pmoveadcp);
p.newfilename_ADCPM  = sprintf('%s', p.name_adcpmaster, p.num_station, '.000'); 
p.newfilename_ADCPS  = sprintf('%s', p.name_adcpslave, p.num_station, '.000'); 
p.process_matlab     = sprintf('%s', p.drive, p.name_mission, p.pmatlab, p.name_mission); 

% convert to Boolean
p.copyctd            = str2num(p.copyctd);
p.copyadcp           = str2num(p.copyadcp);
p.processctd         = str2num(p.processctd);
p.processadcp        = str2num(p.processadcp);
p.processpmel        = str2num(p.processpmel);

end
