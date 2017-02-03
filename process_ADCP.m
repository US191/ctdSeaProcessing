%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> LADCP processing                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function process_ADCP(p, logfile)
close all

%% ADCP file LDEO processing
% Initialisation
disp(' '); textlog = sprintf('INITIALIZING LDEO ADCP PROCESSING');
logfile_CTD = logfile; %Resolve conflict LDEO Processing/ctdSeaProcessing

if p.debug_mode
    
    write_logfile_CTD (logfile_CTD, textlog);
    
else
    
    write_logfile_CTD (logfile_CTD, textlog);
    fclose('all')
    
    cd(p.process_matlab)
    addpath(genpath(p.process_matlab));
    addpath(p.drive)
    set(0,'defaultsurfaceedgecolor', 'none');
    set(0,'defaultfigurerenderer', 'painter');

    % Processing
    disp('LDEO ADCP Processing');
    process_cast(p.num_station)

end

textlog = sprintf('END OF LADCP PROCESS');
disp(textlog);

%--------------------------------------------------------------------------
    function write_logfile_CTD (logfile_CTD, textlog)
    
        disp(textlog); 
        fprintf(logfile_CTD,'%s \n', textlog);

    end

end
