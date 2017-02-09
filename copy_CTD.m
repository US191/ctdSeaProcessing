%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Copy CTD acquisition file to processing path                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ind_error] = copy_CTD(cfg, logfile)

%--------------------------------------------------------------------------
% error indicative
ind_error = 0; 

% Copy files to data-raw
fileCtd_hex    = sprintf('%s', cfg.path_output_CTD, cfg.filename_CTD,'.hex');
fileCtd_xmlcon = sprintf('%s', cfg.path_output_CTD, cfg.filename_CTD,'.XMLCON');
fileCtd_bl     = sprintf('%s', cfg.path_output_CTD, cfg.filename_CTD,'.bl');

textlog = sprintf( 'COPY CTD RAW FILES');
write_logfile(logfile, textlog);

if exist(fileCtd_hex,'file') && exist(fileCtd_xmlcon,'file')...
        && exist(fileCtd_bl,'file')
    
    textlog = sprintf( '    %s[.hex, .XMLCON, .bl] from %s to %s',...
      cfg.filename_CTD, cfg.path_outputCTD, cfg.path_rawCTD);  
    
    if cfg.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
    
        copyfile(fileCtd_hex, cfg.path_raw_CTD);
        copyfile(fileCtd_xmlcon, [cfg.path_raw_CTD, cfg.filename_CTD, '.xmlcon']);
        copyfile(fileCtd_bl, cfg.path_raw_CTD);
    
    end    
        
else
  
    texterror = sprintf('>   !!! Problem with CTD raw files, %s, %s and %s do not exist',...
      fileCtd_hex, fileCtd_xmlcon, fileCtd_bl);
    ind_error = 1;
    
    if cfg.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem with CTD raw files !'...
        'Please verify the paths and the filenames'}, 'Error', 'error')
        return
        
    end

end

%--------------------------------------------------------------------------
% Copy files to data-processing
fileRawCtd_hex    = sprintf('%s', cfg.path_raw_CTD, cfg.filename_CTD, '.hex');
fileRawCtd_xmlcon = sprintf('%s', cfg.path_raw_CTD, cfg.filename_CTD, '.xmlcon');
fileRawCtd_bl     = sprintf('%s', cfg.path_raw_CTD, cfg.filename_CTD, '.bl');

if exist(fileRawCtd_hex, 'file') && exist(fileRawCtd_xmlcon, 'file')...
        && exist(fileRawCtd_bl, 'file')
    
    textlog = sprintf('    %s[.hex, .xmlcon, .bl] from %s to %s',...
      cfg.filename_CTD, cfg.path_raw_CTD, cfg.path_processing_raw_CTD);

    if cfg.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
        
        copyfile(fileRawCtd_hex, cfg.path_processing_raw_CTD);
        copyfile(fileRawCtd_xmlcon, [cfg.path_processing_raw_CTD, cfg.filename_CTD, '.xmlcon']);
        copyfile(fileRawCtd_bl, cfg.path_processing_raw_CTD);
    
    end

else
  
    texterror = sprintf('>   !!! Problem for copying CTD raw files %s, %s and %s to %s',...
      fileCtd_hex, fileCtd_xmlcon, fileCtd_bl, cfg.path_rawCTD);
    ind_error = 1;

    if cfg.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem for copying CTD raw files to data-raw !'...
        'Please verify the paths and the filenames'}, 'Error', 'error')
    
    end

end

%--------------------------------------------------------------------------
% End of the copy process
fileProcessCtd_hex    = sprintf('%s', cfg.path_processing_raw_CTD, cfg.filename_CTD, '.hex');
fileProcessCtd_xmlcon = sprintf('%s', cfg.path_processing_raw_CTD, cfg.filename_CTD, '.xmlcon');
fileProcessCtd_bl     = sprintf('%s', cfg.path_processing_raw_CTD, cfg.filename_CTD, '.bl');

if exist(fileProcessCtd_hex,'file') && exist(fileProcessCtd_xmlcon,'file')...
        && exist(fileProcessCtd_bl,'file')
     
    textlog = sprintf('END OF CTD COPY PROCESS');  
    write_logfile (logfile, textlog);    
    
else
  
    texterror = sprintf('>   !!! Problem for copying CTD files to %s', cfg.path_processing_raw_CTD);
    ind_error = 1;

    if cfg.debug_mode
    
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem for copying files to data-processing !'...
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


