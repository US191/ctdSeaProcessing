%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Launch processing                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function launch_processing(cfg)

%% Open log file
logfile = fopen(strcat(cfg.path_logfile, cfg.log_filename), 'wt');
if ~exist(cfg.path_logfile, 'dir')
                msgbox({'Problem with logfile path' cfg.path_logfile ' !'...
                'Please verify your logfile directory !'}, 'Error', 'error')
          return
end


%% Option for multiple files
if strfind(cfg.num_station,'-')
    ind_sep         = strfind(cfg.num_station,'-');
    start           = str2num(cfg.num_station(1:ind_sep-1));
    last            = str2num(cfg.num_station(ind_sep+1:end));
    num_station     = start:last;
    for ii = 1 : length(num_station)
        cfg.num_station  = num2str(num_station(ii), ['%0' num2str(strlength(cfg.nomenclature_sta)) 'd']);
        cfg.filename_CTD = sprintf('%s', cfg.id_mission, cfg.num_station);
        process(cfg)
    end
else
    cfg.num_station  = num2str(str2double(cfg.num_station),['%0' num2str(strlength(cfg.nomenclature_sta)) 'd']);
    cfg.filename_CTD = sprintf('%s', cfg.id_mission, cfg.num_station);
    process(cfg)
end

    function process(cfg)
        
        counter = cfg.copy_CTD+cfg.process_CTD+cfg.copy_LADCP+cfg.process_LADCP;
        wbar    = waitbar(0, 'CTD-LADCP PreProcessing');
        if cfg.debug_mode
            close(wbar)
        end
        %% Copy files
        % Copy CTD file
        % error indicative
        ind_error = 0;
        
        if cfg.copy_CTD
            % Test file exist
            cfg.filename_CTD    = sprintf('%s', cfg.id_mission, cfg.num_station);
            fileRawCtd_hex      = sprintf('%s', cfg.path_raw_CTD, cfg.filename_CTD, '.hex');
            
            if cfg.debug_mode
                
                [ind_error] = copy_CTD(cfg, logfile);

            else
                
                waitbar(cfg.copy_CTD/(counter+1), wbar, 'Copying CTD data');
                
                if exist(fileRawCtd_hex,'file')
                    Quest_process = questdlg({'CTD files exist !' 'Are you sure to make the process?'}, 'File exist', 'Yes', 'No', 'Yes');
                    if strcmp(Quest_process,'Yes')
                        [ind_error] = copy_CTD(cfg, logfile);
                        if ind_error
                            close(wbar)
                            return
                        end
                    else
                        close(wbar);
                        return;
                    end
                else
                    [ind_error] = copy_CTD(cfg, logfile);
                    if ind_error
                        close(wbar)
                        return
                    end
                end
                
            end
            
        end
        
        % Copy SBE35 file
        % error indicative
        ind_error = 0;
        
        if cfg.copy_SBE35
            % Test file exist
            cfg.filename_SBE35    = sprintf('%s', upper(cfg.id_mission), cfg.num_station);
            fileRawSBE35_hex      = sprintf('%s', cfg.path_raw_SBE35, cfg.filename_SBE35, '.asc');
            
            if cfg.debug_mode
                
                [ind_error] = copy_SBE35(cfg, logfile);
                
            else
                
                waitbar(cfg.copy_CTD/(counter+1), wbar, 'Copying SBE35 data');
                
                if exist(fileRawSBE35_hex,'file')
                    Quest_process = questdlg({'SBE35 files exist !' 'Are you sure to make the process?'}, 'File exist', 'Yes', 'No', 'Yes');
                    if strcmp(Quest_process,'Yes')
                        [ind_error] = copy_SBE35(cfg, logfile);
                        if ind_error
                            close(wbar)
                            return
                        end
                    else
                        close(wbar);
                        return;
                    end
                else
                    [ind_error] = copy_SBE35(cfg, logfile);
                    if ind_error
                        close(wbar)
                        return
                    end
                end
                
            end
            
        end
        
        % LADCP
        % error indicative
        ind_error = 0;
        
        % Copy LADCP file
        if cfg.copy_LADCP
            
            if cfg.debug_mode
                
                copy_LADCP(cfg, logfile);
                
            else
                
                waitbar((cfg.copy_CTD+cfg.process_CTD+cfg.copy_LADCP)/(counter+1), wbar, 'Copying LADCP data');
                
                % New file name
                cfg.newfilename_LADCPM      = sprintf('%s', cfg.id_mission, 'M', cfg.num_station, '.000'); 
                cfg.newfilename_LADCPS      = sprintf('%s', cfg.id_mission, 'S', cfg.num_station, '.000');
                
                % Test file exist
                newfileLADCPMraw      = sprintf('%s', cfg.path_raw_LADCP, cfg.newfilename_LADCPM);
                newfileLADCPSraw      = sprintf('%s', cfg.path_raw_LADCP, cfg.newfilename_LADCPS);
                newfileLADCPMprocess  = sprintf('%s', cfg.path_processing_LADCP, cfg.newfilename_LADCPM);
                newfileLADCPSprocess  = sprintf('%s', cfg.path_processing_LADCP, cfg.newfilename_LADCPS);
                
                if exist(newfileLADCPMraw,'file') && exist(newfileLADCPSraw,'file')...
                        && exist(newfileLADCPMprocess,'file') && exist(newfileLADCPSprocess,'file')
                    Quest_process = questdlg({'LADCP files exist !' 'Are you sure to make the process?'}, 'File exist', 'Yes', 'No', 'Yes');
                    if strcmp(Quest_process,'Yes')
                        [ind_error] = copy_LADCP(cfg, logfile);
                        if ind_error
                            return
                        end
                    else
                        return;
                    end
                else
                    [ind_error] = copy_LADCP(cfg, logfile);
                    if ind_error
                        close(wbar);
                        return
                    end
                end             
                
            end
        end
        
        %% Process files
        % Process CTD file
        if cfg.process_CTD
            
            time_wbar=(cfg.copy_CTD+cfg.process_CTD)/(counter+1);
            
            if cfg.debug_mode
                
                process_CTD(cfg, logfile, wbar, time_wbar);
                
            else
                
                waitbar((cfg.copy_CTD+cfg.process_CTD)/(counter+1), wbar, 'Processing CTD file');
                
                if ind_error
                    Quest_process = questdlg({'Some problems occured during the copying process !' 'Are you sure to continu?'}, 'File exist', 'Yes', 'No', 'Yes');
                    if strcmp(Quest_process,'Yes')
                        [ind_error] = process_CTD(cfg, logfile, wbar, time_wbar);
                        if ind_error
                            close(wbar)
                            return
                        end
                    else
                        close(wbar);
                        return;
                    end
                else
                    [ind_error] = process_CTD(cfg, logfile, wbar, time_wbar);
                    if ind_error
                        close(wbar);
                        return
                    end
                end              
                
            end
        end
        
        % Process LADCP file
        if cfg.process_LADCP
            
            if cfg.debug_mode
                
                process_LADCP(cfg, logfile);
                
            else
                
                if ind_error
                    Quest_process = questdlg({'Some problems occued during the copying process !' 'Are you sure to continu?'}, 'File exist', 'Yes', 'No', 'Yes');
                    if strcmp(Quest_process,'Yes')
                        waitbar(counter/(counter+1), wbar, 'Processing LADCP file');
                        process_LADCP(cfg, logfile);
                    else
                        close(wbar);
                        return;
                    end
                else
                    waitbar(counter/(counter+1), wbar, 'Processing LADCP file');
                    process_LADCP(cfg, logfile);
                end
                
                cd(cfg.local_path);
                rmpath(genpath(cfg.process_LDEO));
                rmpath(cfg.drive);
                
            end
        else
	  close(wbar)   
        end
    end
end
