%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Copy CTD acquisition file to processing path                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ind_error] = copy_SBE35(cfg, logfile)

%--------------------------------------------------------------------------
% error indicative
ind_error = 0; 

% Copy file to data-raw
fileSBE35    = sprintf('%s', cfg.path_output_SBE35, cfg.filename_SBE35,'.asc');

textlog = sprintf( 'COPY SBE35 RAW FILE');
write_logfile(logfile, textlog);

if exist(fileSBE35,'file')
    
    textlog = sprintf( '    %s.asc from %s to %s',...
      cfg.filename_SBE35, cfg.path_output_SBE35, cfg.path_raw_SBE35);  
    
    if cfg.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
    
        copyfile(fileSBE35, cfg.path_raw_SBE35);
    
    end    
        
else
  
    texterror = sprintf('>   !!! Problem with SBE35 raw file, %s do not exist',...
      fileSBE35);
    ind_error = 1;
    
    if cfg.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem with SBE35 raw files !'...
        'Please verify the paths and the filenames'}, 'Error', 'error')
        return
        
    end

end

%--------------------------------------------------------------------------
% Copy files to data-processing
fileSBE35    = sprintf('%s', cfg.path_raw_SBE35, cfg.filename_SBE35, '.asc');

if exist(fileSBE35, 'file')
    
    textlog = sprintf('    %s.asc from %s to %s',...
      cfg.filename_SBE35, cfg.path_raw_SBE35, cfg.path_processing_SBE35);

    if cfg.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
        
        copyfile(fileSBE35, cfg.path_processing_SBE35);
    
    end

else
  
    texterror = sprintf('>   !!! Problem for copying SBE35 raw file %s to %s',...
      fileSBE35, cfg.path_raw_SBE35);
    ind_error = 1;

    if cfg.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem for copying SBE35 raw file to data-raw !'...
        'Please verify the paths and the filenames'}, 'Error', 'error')
    
    end

end

%--------------------------------------------------------------------------
% End of the copy process
fileProcessSBE35    = sprintf('%s', cfg.path_processing_SBE35, cfg.filename_SBE35, '.asc');

if exist(fileProcessSBE35,'file')
     
    textlog = sprintf('END OF SBE35 COPY PROCESS');  
    write_logfile (logfile, textlog);    
    
else
  
    texterror = sprintf('>   !!! Problem for copying SBE35 file to %s', cfg.path_processing_SBE35);
    ind_error = 1;

    if cfg.debug_mode
    
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem for copying SBE35 file to data-processing !'...
            'Please verify the paths and the filenames'}, 'Error', 'error')
        
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


