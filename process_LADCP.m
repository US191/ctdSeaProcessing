%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> LADCP processing                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function process_LADCP(cfg, logfile)
close all

%% LADCP file LDEO processing
% Initialisation
disp(' '); disp('LADCP PROCESSING'); 
fprintf(logfile, '\n LADCP PROCESSING \n');

disp(' '); textlog = sprintf('INITIALIZING LDEO LADCP PROCESSING');
logfile_CTD = logfile; %Resolve conflict LDEO Processing/ctdSeaProcessing

if cfg.debug_mode
    
    write_logfile_CTD (logfile_CTD, textlog);
    
else
    
    write_logfile_CTD (logfile_CTD, textlog);
    fclose('all');
    
    if ~exist(cfg.process_LDEO,'dir')
        texterror = sprintf('>   !!! Problem with LDEO processing path');
        ind_error = 1;
        
        if cfg.debug_mode
            
            error_logfile (logfile, texterror)
            
        else
            
            error_logfile (logfile, texterror)
            msgbox({'Problem with LDEO processing path !'...
                'Please verify LDEO processing path'}, 'Error', 'error')
            
        end
    else
        cd(cfg.process_LDEO);
        addpath(genpath(cfg.process_LDEO));
        addpath(cfg.drive);
        set(0,'defaultsurfaceedgecolor', 'none');
        set(0,'defaultfigurerenderer', 'painter');
        
        % Processing
        disp('LDEO LADCP Processing');
        process_cast(cfg.num_station);
        cd(cfg.local_path);
        rmpath(genpath(cfg.process_LDEO));
        rmpath(cfg.drive);
    end

end

textlog = sprintf('END OF LADCP PROCESS');
disp(textlog);

%--------------------------------------------------------------------------
    function write_logfile_CTD (logfile_CTD, textlog)
    
        disp(textlog); 
        fprintf(logfile_CTD,'%s \n', textlog);

    end

    function error_logfile (logfile, texterror)
        
        disp(texterror);
        fprintf(logfile, '%s \n', texterror);
        
    end

end
