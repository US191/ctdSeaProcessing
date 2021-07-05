%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Processing CTD Data                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ind_error] = process_CTD(cfg, logfile, wbar, time_wbar)

%% Initializing CTD Process
% error indicative
ind_error = 0; 

disp(' '); disp('CTD SBE PROCESSING'); 
fprintf(logfile, '\n CTD SBE PROCESSING \n');

% Step by step mode
if cfg.stepbystep_mode
    cfg.step_arg = '#w';
    textlog = sprintf('Step by Step mode');
    write_logfile (logfile, textlog);
else
    cfg.step_arg = '';
end

% PMEL processing 
if cfg.process_PMEL
    
    sbe_pmel = sprintf('!SBEBatch.exe %spmel.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
    textlog = sprintf('    End of PMEL Processing');

    if cfg.debug_mode
        
        write_logfile (logfile, sbe_pmel);
        write_logfile (logfile, textlog);
        
        
    else
        
        waitbar(time_wbar, wbar, 'PMEL Processing');
        evalc(sbe_pmel);
        textlog = sprintf('    End of PMEL Processing');
        write_logfile (logfile, textlog);
        
        
    end
        
end

    if cfg.process_LADCP
        sbe_ladcp      = sprintf('!SBEBatch.exe %sladcp.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
    end
    sbe_codac      = sprintf('!SBEBatch.exe %scodac.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
    if cfg.process_BTL
        sbe_std        = sprintf('!SBEBatch.exe %sstd.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
    else
        sbe_std        = sprintf('!SBEBatch.exe %sstd_wobottle.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
    end
    
    if exist([cfg.path_processing_raw_CTD,cfg.filename_CTD,'.hex'],'file')
        sbe_plt        = sprintf('!SBEBatch.exe %sseaplot.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
        sbe_report     = sprintf('!ConReport.exe %s%s.xmlcon %s', cfg.path_processing_raw_CTD, cfg.filename_CTD, cfg.path_reports);
        sbe_btl        = sprintf('!SBEBatch.exe %sbtl.batch %s %s %s', cfg.path_batch, cfg.filename_CTD, cfg.path_processing_CTD, cfg.step_arg);
        if cfg.create_CODAC
            codac_file     = sprintf('%s', cfg.path_codac, cfg.filename_CTD, '.cnv');
            compress_codac = sprintf('!bzip2.exe -f %s', codac_file);
        end
        textlog        = sprintf('End of the CTD processing');
    else
        texterror = sprintf('>   !!! Problem with CTD files, %s%s.hex do not exist',...
            cfg.path_processing_raw_CTD, cfg.filename_CTD);
        ind_error = 1;
        
        if cfg.debug_mode
            
            error_logfile (logfile, texterror)
            
        else
            
            error_logfile (logfile, texterror)
            msgbox({'Problem with CTD files !'...
                'Please verify if the files exist !'}, 'Error', 'error')
            return
            
        end
    end

    if cfg.debug_mode
        if cfg.process_LADCP
            write_logfile_disp (logfile, sbe_ladcp);
        end
        write_logfile_disp (logfile, sbe_codac);
        write_logfile_disp (logfile, sbe_std);
        write_logfile_disp (logfile, sbe_plt);
        write_logfile_disp (logfile, sbe_report);
        if cfg.process_BTL
            write_logfile_disp (logfile, sbe_btl);
        end
        write_logfile_disp (logfile, compress_codac);
        write_logfile_disp (logfile, textlog);
        
    else
        % Convert to cnv ascii for ladcp files
        if cfg.process_LADCP
            waitbar(time_wbar,wbar, 'Convert to cnv ascii for ladcp files');
            write_logfile (logfile, sbe_ladcp);
            evalc(sbe_ladcp);
            textlog = sprintf('    End of convertion to cnv ascii for ladcp files');
            write_logfile_disp (logfile, textlog);
        end

        % Codac Processing
        if cfg.create_CODAC
            waitbar(time_wbar,wbar, 'Codac Processing');
            write_logfile (logfile, sbe_codac);
            evalc(sbe_codac);
            textlog = sprintf('    End of the Codac Processing');
            write_logfile_disp (logfile, textlog);
        end

        % SBE Processing
        waitbar(time_wbar,wbar, 'SBE Processing');
        write_logfile (logfile, sbe_std);
        evalc(sbe_std);
        textlog = sprintf('    End of the SBE Processing');
        write_logfile_disp (logfile, textlog);

        % SeaPlot Processing
        waitbar(time_wbar,wbar,'SeaPlot Processing');
        write_logfile (logfile, sbe_plt);
        evalc(sbe_plt);
        textlog = sprintf('    End of the SeaPlot Processing');
        write_logfile_disp (logfile, textlog);

        % Generate Report File
        waitbar(time_wbar,wbar,'Generate Report File');
        write_logfile (logfile, sbe_report);
        evalc(sbe_report);
        textlog = sprintf('    Report File generated');
        write_logfile_disp (logfile, textlog);
    
        if cfg.process_BTL
            % Bottles .ros processing
            waitbar(time_wbar,wbar, 'Bottles .ros processing');
            write_logfile (logfile, sbe_btl);
            evalc(sbe_btl);
            textlog = sprintf('    End of the bottles .ros processing');
            write_logfile_disp (logfile, textlog);
        end

        % Compress file to 5db for Coriolis
        if cfg.create_CODAC
            if exist(codac_file, 'file')
                waitbar(time_wbar, wbar, 'Compressing file at 5db for Coriolis');
                write_logfile (logfile, compress_codac);
                result = evalc(compress_codac);
                write_logfile (logfile, result);
                textlog = sprintf('    End of the file compressing for Coriolis');
                write_logfile_disp (logfile, textlog);
            else
                msgbox('Codac file do not exist !', 'Error', 'error')
                textlog = sprintf('>   !!! Problem for compressing Codac file !');
                write_logfile_disp (logfile, textlog);
            end
        end
        
        write_logfile(logfile, textlog);
        
    end
    
textlog = sprintf('END OF CTD SBE PROCESSING');  
write_logfile (logfile, textlog);   

%--------------------------------------------------------------------------
    function write_logfile (logfile, textlog)
    
        fprintf(logfile,'%s \n', textlog);

    end

    function write_logfile_disp (logfile, textlog)
    
        disp(textlog); 
        fprintf(logfile,'%s \n', textlog);

    end

    function error_logfile (logfile, texterror)
        
        disp(texterror);
        fprintf(logfile, '%s \n', texterror);
        
    end
end
