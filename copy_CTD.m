%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Copy CTD acquisition file to processing path                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function copy_CTD(p, logfile)

%--------------------------------------------------------------------------
% Copy files to data-raw
fileCtd_hex    = sprintf('%s', p.path_outputCTD, p.filenameCTD,'.hex');
fileCtd_xmlcon = sprintf('%s', p.path_outputCTD, p.filenameCTD,'.XMLCON');
fileCtd_bl     = sprintf('%s', p.path_outputCTD, p.filenameCTD,'.bl');

textlog = sprintf( 'COPY CTD RAW FILES');
write_logfile(logfile, textlog);

if exist(fileCtd_hex,'file') && exist(fileCtd_xmlcon,'file')...
        && exist(fileCtd_bl,'file')
    
    textlog = sprintf( '    %s[.hex, .XMLCON, .bl] from %s to %s',...
      p.filenameCTD, p.path_outputCTD, p.path_rawCTD);  
    
    if p.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
    
        copyfile(fileCtd_hex, p.path_rawCTD);
        copyfile(fileCtd_xmlcon, [p.path_rawCTD, p.filenameCTD, '.xmlcon']);
        copyfile(fileCtd_bl, p.path_rawCTD);
    
    end    
        
else
  
    texterror = sprintf('>   !!! Problem with CTD raw files, %s, %s and %s do not exist',...
      fileCtd_hex, fileCtd_xmlcon, fileCtd_bl);
    
    if p.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem with CTD raw files !'...
        'Please verify the paths and the filenames'}, 'Error', 'error')
    
    end

end

%--------------------------------------------------------------------------
% Copy files to data-processing
fileRawCtd_hex    = sprintf('%s', p.path_rawCTD, p.filenameCTD, '.hex');
fileRawCtd_xmlcon = sprintf('%s', p.path_rawCTD, p.filenameCTD, '.xmlcon');
fileRawCtd_bl     = sprintf('%s', p.path_rawCTD, p.filenameCTD, '.bl');

if exist(fileRawCtd_hex, 'file') && exist(fileRawCtd_xmlcon, 'file')...
        && exist(fileRawCtd_bl, 'file')
    
    textlog = sprintf('    %s[.hex, .xmlcon, .bl] from %s to %s',...
      p.filenameCTD, p.path_rawCTD, p.path_processCTD);

    if p.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
        
        copyfile(fileCtd_hex, p.path_processCTD);
        copyfile(fileCtd_xmlcon, [p.path_processCTD, p.filenameCTD, '.xmlcon']);
        copyfile(fileCtd_bl, p.path_processCTD);
    
    end

else
  
    texterror = sprintf('>   !!! Problem for copying CTD raw files %s, %s and %s to %s',...
      fileCtd_hex, fileCtd_xmlcon, fileCtd_bl, p.path_rawCTD);

    if p.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'Problem for copying CTD raw files to data-raw !'...
        'Please verify the paths and the filenames'}, 'Error', 'error')
    
    end

end

%--------------------------------------------------------------------------
% End of the copy process
fileProcessCtd_hex    = sprintf('%s', p.path_processCTD, p.filenameCTD, '.hex');
fileProcessCtd_xmlcon = sprintf('%s', p.path_processCTD, p.filenameCTD, '.xmlcon');
fileProcessCtd_bl     = sprintf('%s', p.path_processCTD, p.filenameCTD, '.bl');

if exist(fileProcessCtd_hex,'file') && exist(fileProcessCtd_xmlcon,'file')...
        && exist(fileProcessCtd_bl,'file')
     
    textlog = sprintf('END OF CTD COPY PROCESS');  
    write_logfile (logfile, textlog);    
    
else
  
    texterror = sprintf('>   !!! Problem for copying CTD files to %s', p.path_processCTD);

    if p.debug_mode
    
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


