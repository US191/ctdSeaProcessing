%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create tree                                                             %
% Minimal directories needed for the processing                           %
% Autor: Pierre Rousselot / Date: 23/10/19                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables
external_drive_name  = 'e:'; % normally this is the server on French vessels
acquisition_computer = 'c:'; % "CTD" computer
name_mission         = 'SOLSTICE-CR062'; % CTD data must either get saved directly into this folder (by SEASAVE) or copied across before processing starts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create directories
mkdir(acquisition_computer, 'SEASOFT');
mkdir([acquisition_computer filesep 'SEASOFT'], name_mission);
mkdir([acquisition_computer filesep 'SEASOFT' filesep name_mission], 'data');

mkdir([external_drive_name filesep name_mission], 'data-raw');
mkdir([external_drive_name filesep name_mission filesep 'data-raw'], 'CTD');

mkdir([external_drive_name filesep name_mission], 'data-processing');
    mkdir([external_drive_name filesep name_mission filesep 'data-processing'], 'CTD');
        
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD'], 'batch');
        
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD'], 'data');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'data'], 'raw');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'data'], 'reports');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'asc');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'btl');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'cnv');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'tmp');

        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD'], 'psa');

        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' ], 'plots');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'downcast');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'TS');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'upcast');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'fluos');

mkdir([external_drive_name filesep name_mission], 'data-adjusted');
    mkdir([external_drive_name filesep name_mission filesep 'data-processing'], 'CTD');
        
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD'], 'batch');
        
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD'], 'data');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'data'], 'raw');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'data'], 'reports');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'asc');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'btl');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'cnv');
            mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep , 'data'], 'tmp');

        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD'], 'psa');

        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' ], 'plots');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'downcast');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'TS');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'upcast');
        mkdir([external_drive_name filesep name_mission filesep 'data-processing' filesep 'CTD' filesep 'plots' ], 'fluos');


