%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Copy LADCP acquisition file to processing path                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ind_error] = copy_LADCP(cfg, logfile)

%--------------------------------------------------------------------------
% error indicative
ind_error = 0; 

% Copy LADCP files 
fileLADCPMoutput    = sprintf('%s', cfg.path_output_LADCP, cfg.filename_LADCPM);
fileLADCPSoutput    = sprintf('%s', cfg.path_output_LADCP, cfg.filename_LADCPS);
newfileLADCPMoutput = sprintf('%s', cfg.path_save_LADCP, cfg.newfilename_LADCPM);
newfileLADCPSoutput = sprintf('%s', cfg.path_save_LADCP, cfg.newfilename_LADCPS);

if exist(fileLADCPMoutput,'file') && exist(fileLADCPSoutput,'file')

    textlog = sprintf('COPY LADCP RAW FILES');
    write_logfile(logfile, textlog);
    
    textlog = sprintf('    %s and %s \n to \n    %s and %s',...
        fileLADCPMoutput, fileLADCPSoutput, newfileLADCPMoutput, newfileLADCPSoutput);
    
    if cfg.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
        
        write_logfile(logfile, textlog);
        
        movefile (fileLADCPMoutput, newfileLADCPMoutput);
        movefile (fileLADCPSoutput, newfileLADCPSoutput);
    
    end
    
else
 
    texterror = sprintf('>   !!! LADCP files %s and %s are missing', fileLADCPMoutput, fileLADCPSoutput);
    ind_error = 1;
    
    if cfg.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'LADCP files are missing !'...
            'Please verify files have been extracted with BBTalk'}, 'Error', 'error')
        return
    end

end

%--------------------------------------------------------------------------
% Copy raw-data on the network

textlog = sprintf ('COPY LADCP RAW FILES ON THE NETWORK');
write_logfile(logfile, textlog);

textlog = sprintf (' then to \n    %s \n    %s',...
    cfg.path_raw_LADCP, cfg.path_processing_LADCP);

if cfg.debug_mode
        
    write_logfile(logfile, textlog);
    
else
    
    write_logfile(logfile, textlog);

    copyfile (newfileLADCPMoutput, cfg.path_raw_LADCP);
    copyfile (newfileLADCPSoutput, cfg.path_raw_LADCP);
    copyfile (newfileLADCPMoutput, cfg.path_processing_LADCP);
    copyfile (newfileLADCPSoutput, cfg.path_processing_LADCP);

end

%--------------------------------------------------------------------------
% End of the process
newfileLADCPMraw = sprintf('%s', cfg.path_raw_LADCP, cfg.newfilename_LADCPM);
newfileLADCPSraw = sprintf('%s', cfg.path_raw_LADCP, cfg.newfilename_LADCPS);
newfileLADCPMprocess = sprintf('%s', cfg.path_processing_LADCP, cfg.newfilename_LADCPM);
newfileLADCPSprocess = sprintf('%s', cfg.path_processing_LADCP, cfg.newfilename_LADCPS);

if exist(newfileLADCPMraw,'file') && exist(newfileLADCPSraw,'file')...
        && exist(newfileLADCPMprocess,'file') && exist(newfileLADCPSprocess,'file')

    textlog = sprintf('END OF LADCP COPY PROCESS');
    
    write_logfile (logfile, textlog);

else

    texterror = sprintf('>   !!! Problem for copying LADCP files');
    ind_error = 1;
    
    if cfg.debug_mode
    
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'A problem occured during LADCP files copying !'...
            'Please verify the paths and the filenames'}, 'Error', 'error')    
        return
        
    end

end

%--------------------------------------------------------------------------
    function write_logfile (logfile, textlog)
    
        disp(textlog); 
        fprintf(logfile,'%s \n', textlog);

    end

    function error_logfile (logfile, texterror)
        
        disp(texterror);
        fprintf(logfile, '%s \n', texterror);
        
    end

end
