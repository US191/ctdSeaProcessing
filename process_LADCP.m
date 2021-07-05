%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> LADCP processing                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function process_LADCP(cfg, logfile)

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
    
    if ~exist(cfg.process_LDEO,'dir')
        
        texterror = sprintf('>   !!! Problem with LDEO processing path');
        
        if cfg.debug_mode
            
            error_logfile (logfile_CTD, texterror)
            
        else
            
            error_logfile (logfile_CTD, texterror)
            msgbox({'Problem with LDEO processing path !'...
                'Please verify LDEO processing path !'}, 'Error', 'error')
            
        end
        
        fclose('all');
        
    else
        cd(cfg.process_LDEO);
        addpath(genpath(cfg.process_LDEO));
        addpath(cfg.drive);
        set(0,'defaultsurfaceedgecolor', 'none');
        set(0,'defaultfigurerenderer', 'painter');
        
        % Processing
        disp('LDEO LADCP Processing');
        close all;
        disp('Clear previous prepared files');
        clear_prep(cfg.num_station)        

        fig1 = process_cast(cfg);
        while ishghandle(fig1)
            pause(1)
        end
        close all;

    end

end

textlog = sprintf('END OF LADCP PROCESS');
disp(textlog);

%--------------------------------------------------------------------------
    function write_logfile_CTD (logfile_CTD, textlog)
    
        disp(textlog); 
        fprintf(logfile_CTD,'%s \n', textlog);

    end

    function error_logfile (logfile_CTD, texterror)
        
        disp(texterror);
        fprintf(logfile_CTD, '%s \n', texterror);
        
    end

end
