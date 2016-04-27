%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Processing CTD Data                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function process_CTD(p, logfile, wbar, time_wbar)

%% Initializing CTD Process
disp(' '); disp('CTD SBE PROCESSING'); 
fprintf(logfile, '\n CTD SBE PROCESSING \n');

% PMEL processing 
if p.processpmel
    
    sbe_pmel = sprintf('!SBEBatch.exe %spmel.batch %s %s', p.path_batch, p.filename_CTD, p.path_processingCTD);
    textlog = sprintf('    End of PMEL Processing');

    if p.debug_mode
        
        write_logfile (logfile, sbe_pmel);
        write_logfile (logfile, textlog);
        
        
    else
        
        waitbar(time_wbar, wbar, 'PMEL Processing');
        evalc(sbe_pmel);
        write_logfile (logfile, textlog);
        close(wbar)
        
    end
        
end


    sbe_ladcp      = sprintf('!SBEBatch.exe %sladcp.batch %s %s', p.path_batch, p.filename_CTD, p.path_processingCTD);
    sbe_codac      = sprintf('!SBEBatch.exe %scodac.batch %s %s', p.path_batch, p.filename_CTD, p.path_processingCTD);
    sbe_std        = sprintf('!SBEBatch.exe %sstd.batch %s %s', p.path_batch, p.filename_CTD, p.path_processingCTD);
    sbe_plt        = sprintf('!SBEBatch.exe %sseaplot.batch %s %s', p.path_batch, p.filename_CTD, p.path_processingCTD);
    sbe_report     = sprintf('!ConReport.exe %s%s.xmlcon %s', p.path_processCTD, p.filename_CTD, p.path_reports);
    sbe_btl        = sprintf('!SBEBatch.exe %sbtl.batch %s %s', p.path_batch, p.filename_CTD, p.path_processingCTD);
    codac_file     = sprintf('%s', p.path_codac, p.filename_CTD, '.cnv');
    compress_codac = sprintf('!bzip2.exe -f %s', codac_file);
    textlog        = sprintf('End of the CTD processing');

    if p.debug_mode
        write_logfile_disp (logfile, sbe_ladcp);
        write_logfile_disp (logfile, sbe_codac);
        write_logfile_disp (logfile, sbe_std);
        write_logfile_disp (logfile, sbe_plt);
        write_logfile_disp (logfile, sbe_report);
        write_logfile_disp (logfile, sbe_btl);
        write_logfile_disp (logfile, compress_codac);
        write_logfile_disp (logfile, textlog);
        
    else
        % Convert to cnv ascii for ladcp files
        waitbar(time_wbar,wbar, 'Convert to cnv ascii for ladcp files');
        write_logfile (logfile, sbe_ladcp);
        evalc(sbe_ladcp);
        textlog = sprintf('    End of convertion to cnv ascii for ladcp files');
        write_logfile_disp (logfile, textlog);

        % Codac Processing
        waitbar(time_wbar,wbar, 'Codac Processing');
        write_logfile (logfile, sbe_codac);
        evalc(sbe_codac);
        textlog = sprintf('    End of the Codac Processing');
        write_logfile_disp (logfile, textlog);

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

        % Bottles .ros processing
        waitbar(time_wbar,wbar, 'Bottles .ros processing');
        write_logfile (logfile, sbe_btl);
        evalc(sbe_btl);
        textlog = sprintf('    End of the bottles .ros processing');
        write_logfile_disp (logfile, textlog);

        % Compress file to 5db for Coriolis
        if exist(codac_file, 'file')
            waitbar(time_wbar, wbar, 'Compressing file at 5db for Coriolis');
            write_logfile (logfile, compress_codac);
            evalc(compress_codac);
            textlog = sprintf('    End of the file compressing for Coriolis');
            write_logfile_disp (logfile, textlog); 
        else
            msgbox('Codac file do not exist !', 'Error', 'error')
            textlog = sprintf('>   !!! Problem for compressing Codac file !');
            write_logfile_disp (logfile, textlog);
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

end
