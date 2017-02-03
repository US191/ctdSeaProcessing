%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Copy LADCP acquisition file to processing path                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ind_error] = copy_ADCP(p, logfile)

%--------------------------------------------------------------------------
% error indicative
ind_error = 0; 

% Copy LADCP files 
fileADCPMoutput = sprintf('%s', p.path_outputADCP, p.filename_adcpm);
fileADCPSoutput = sprintf('%s', p.path_outputADCP, p.filename_adcps);
newfileADCPMoutput = sprintf('%s', p.path_moveADCP, p.newfilename_ADCPM);
newfileADCPSoutput = sprintf('%s', p.path_moveADCP, p.newfilename_ADCPS);

disp(' '); disp('LADCP PROCESSING'); 
fprintf(logfile, '\n LADCP PROCESSING \n');

if exist(fileADCPMoutput,'file') && exist(fileADCPSoutput,'file')

    textlog = sprintf('COPY LADCP RAW FILES');
    write_logfile(logfile, textlog);
    
    textlog = sprintf('    %s and %s \n to \n    %s and %s',...
        fileADCPMoutput, fileADCPSoutput, newfileADCPMoutput, newfileADCPSoutput);
    
    if p.debug_mode
        
        write_logfile(logfile, textlog);
    
    else
        
        write_logfile(logfile, textlog);
        
        copyfile (fileADCPMoutput, newfileADCPMoutput);
        copyfile (fileADCPSoutput, newfileADCPSoutput);
    
    end
    
else
 
    texterror = sprintf('>   !!! ADCP files %s and %s are missing', fileADCPMoutput, fileADCPSoutput);
    ind_error = 1;
    
    if p.debug_mode
        
        error_logfile (logfile, texterror)
    
    else
        
        error_logfile (logfile, texterror)
        msgbox({'ADCP files are missing !'...
            'Please verify files have been extracted with BBTalk'}, 'Error', 'error')
        
    end

end

%--------------------------------------------------------------------------
% Copy raw-data on the network

textlog = sprintf ('COPY LADCP RAW FILES ON THE NETWORK');
write_logfile(logfile, textlog);

textlog = sprintf (' then to \n    %s \n    %s',...
    p.path_rawADCP, p.path_processADCP);

if p.debug_mode
        
    write_logfile(logfile, textlog);
    
else
    
    write_logfile(logfile, textlog);

    copyfile (newfileADCPMoutput, p.path_rawADCP);
    copyfile (newfileADCPSoutput, p.path_rawADCP);
    copyfile (newfileADCPMoutput, p.path_processADCP);
    copyfile (newfileADCPSoutput, p.path_processADCP);

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
    ind_error = 1;
    
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
