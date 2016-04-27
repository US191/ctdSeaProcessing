%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Copy LADCP acquisition file to processing path                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function copy_ADCP (p, logfile)

%--------------------------------------------------------------------------
disp(' '); disp('LADCP PROCESSING'); 
fprintf(logfile, '\n LADCP PROCESSING \n');

% Rename LADCP files 
fileADCPMoutput = sprintf('%s', p.path_outputADCP, p.filename_adcpm);
fileADCPSoutput = sprintf('%s', p.path_outputADCP, p.filename_adcps);
newfileADCPMoutput = sprintf('%s', p.path_outputADCP, p.newfilename_ADCPM);
newfileADCPSoutput = sprintf('%s', p.path_outputADCP, p.newfilename_ADCPS);

if exist(fileADCPMoutput,'file') && exist(fileADCPSoutput,'file')

    textlog = sprintf('RENAME LADCP FILES');
    write_logfile(logfile, textlog);
    textlog = sprintf('    %s and %s to %s and %s',...
        fileADCPMoutput, fileADCPSoutput, p.newfilename_ADCPM, p.newfilename_ADCPS);
    
    if p.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
        
        write_logfile(logfile, textlog);
        
        movefile (fileADCPMoutput, newfileADCPMoutput);
        movefile (fileADCPSoutput, newfileADCPSoutput);
    
    end
    
else
 
    texterror = sprintf('>   !!! ADCP files %s and %s are missing', fileADCPMoutput, fileADCPSoutput);
    
    if p.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'ADCP files are missing !'...
            'Please verify files have been extracted with BBTalk'}, 'Error', 'error')
        
    end

end

%--------------------------------------------------------------------------
% Move LADCP files
if exist(newfileADCPMoutput, 'file') && exist(newfileADCPSoutput, 'file')

    textlog = sprintf('MOVE LADCP fILE');
    write_logfile(logfile, textlog);
    textlog = sprintf('    %s and %s to %s', newfileADCPMoutput,...
      newfileADCPSoutput, p.path_moveADCP);
  
    if p.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
    
        write_logfile(logfile, textlog);
        
        movefile (newfileADCPMoutput, p.path_moveADCP);
        movefile (newfileADCPSoutput, p.path_moveADCP);
    
    end

else
  
    texterror = sprintf('>   !!! Problem for renaming %s and %s ADCP files to %s and %s',...
      fileADCPMoutput, fileADCPSoutput, newfileADCPMoutput, newfileADCPSoutput);

    if p.debug_mode
        
        error_logfile (logfile, texterror)
        
    else
        
        error_logfile (logfile, texterror)
        msgbox({'A problem occured during ADCP files renaming!'...
            'Please verify the paths and the filenames'}, 'Error', 'error')   
    
    end

end

%--------------------------------------------------------------------------
% Copy raw-data on the network

textlog = sprintf ('COPY LADCP RAW FILES');
textlog = sprintf ('    from %s to %s and %s',...
    p.path_moveADCP, p.path_rawADCP, p.path_processADCP);

if p.debug_mode
        
    write_logfile(logfile, textlog);
    
else
    
    write_logfile(logfile, textlog);

    newfileADCPMmove = sprintf('%s', p.path_moveADCP, p.newfilename_ADCPM);
    newfileADCPSmove = sprintf('%s', p.path_moveADCP, p.newfilename_ADCPS);

    copyfile (newfileADCPMmove, p.path_rawADCP);
    copyfile (newfileADCPSmove, p.path_rawADCP);
    copyfile (newfileADCPMmove, p.path_processADCP);
    copyfile (newfileADCPSmove, p.path_processADCP);

end

%--------------------------------------------------------------------------
% End of the process
newfileADCPMraw = sprintf('%s',p.path_rawADCP,p.newfilename_ADCPM);
newfileADCPSraw = sprintf('%s',p.path_rawADCP,p.newfilename_ADCPS);
newfileADCPMprocess = sprintf('%s',p.path_processADCP,p.newfilename_ADCPM);
newfileADCPSprocess = sprintf('%s',p.path_processADCP,p.newfilename_ADCPS);

if exist(newfileADCPMraw,'file') && exist(newfileADCPSraw,'file')...
        && exist(newfileADCPMprocess,'file') && exist(newfileADCPSprocess,'file')

    textlog = sprintf('END OF LADCP COPY PROCESS');
    
    write_logfile (logfile, textlog);

else

    texterror = sprintf('>   !!! Problem for copying ADCP files');
    
    if p.debug_mode
    
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'A problem occured during ADCP files copying !'...
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
