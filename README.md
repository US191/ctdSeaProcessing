# ctdSeaProcessing

Automation pre-processing software for CTD-LADCP

 _Preprocessing software for CTD-LADCP_  
 _Autor slave: Pierre Rousselot_
 _Jedi master: Jacques Grelet_  
 _Date: 10/03/16_  

-----------------------------------------------------------------------

This Matlab application automate the different steps of the on-board CTD/LADCP processing:

* Copy data acquisition CTD file to processing path
* Specific CTD SBE Processing (ladcp, codac, std, plt, report, btl)
  * ladcp: Specific CTD processing for LADCP processing.
  * codac: Data reduction for real-time transmission to Coriolis.
  * std: Standard processing to export ASCII data.
  * plt: Plot CTD profile.
  * report: Generate report CTD file.  
  * btl: Bottle file processing.
* Copy data acquisition LADCP file to processing path
* ADCP LDEO Processing (<https://github.com/jgrelet/ladcp)>

-----------------------------------------------------------------------
Your computer must contain the SeaBird processing software `SBEDataProcessing` (under Windows only) and the data compression program `gzip2`.

You can get the latest version of these program there:

* [SBEDataProcessing](http://www.seabird.com/software/sbe-data-processing)
* [gzip2](https://github.com/anandology/gzip2) with python, or (http://gnuwin32.sourceforge.net/packages/bzip2.htm)
  
At the beginning of a cruise:

* Prepare your .psa files (you can use Step-By-Step Mode which process SBEDataProcessing Step-by-Step to parameter .psa files)
* Prepare your .batch files
* Copy you .psa files and .batch files <cruise>/data-processing/CTD/psa and <cruise>/data-processing/CTD/batch
* Fill in the 'configuration.ini' file with the cruise information and the directory paths
(The workspace file will be used for the entire cruise),

``` ini
%% configuration.ini
% Mission variables

name_mission      = PIRATA-FR28
id_mission        = fr28
% if you want to process a specific station
num_station       = 000
% Name of the output master LADCP file
filename_LADCPM   = MADCP000.000
% Name of the output master LADCP file
filename_LADCPS   = SADCP000.000
log_filename      = logfile.log

% Checkbox state (default)
copyCTD         = true
copyADCP        = true
processCTD      = true
processADCP     = true
processPMEL     = false (PMEL processing is a specific CTD processing for profile without bottle)

% Path
 %Working dir                                      (Path of the data processing directory)
drive           = m:\
 %Output CTD/LADCP                                 (Path of the output CTD and LADCP files)
path_seasoft    = c:\SEASOFT\
path_dataladcp  = c:\LADCP\

############################################################################
% Disk Organization

# LDEO program location : (drive\nom_mission...)
pmatlab         = \data-processing\LADCP\v10.16.2\ (Path of the LDEO program directory)

#(drive\nom_mission...)
pprocessingCTD  = \data-processing\CTD             (Path for the CTD data processed files)

#(path_processing...)
pprocessCTD     = \data\raw\                       (Path for the CTD raw-data before processing)

#(drive\nom_mission...)
prawCTD         = \data-raw\CTD\                   (Path for the CTD raw-data files)

#(path_seasoft\nom_mission...)
poutputCTD      = \data\                           (Path of the output CTD files)

#(drive\nom_mission\pprocessingCTD...)
pbatch          = \batch\                          (Path of the .batch files for processing)

#(drive\nom_mission\pprocessingCTD...)
pcodac          = \data\codac\                     (Path for the compressed CTD files for CORIOLIS)

#(drive\nom_mission\pprocessingCTD...)
preports        = \data\reports\                   (Path for the CTD report files)

#(drive\nom_mission...)
pprocessingADCP = \data-processing\LADCP\data\     (Path for the LADCP data processed files)

#(drive\nom_mission...)
prawADCP        = \data-raw\LADCP\                 (Path for the LADCP raw-data before processing)

#(path_dataladcp\nom_mission...)
poutputADCP     = \download\                       (Path of the output LADCP files)

#(path_dataladcp\nom_mission...)
pmoveADCP       =\data\                            (Path to move the output LADCP files)
```

* Launch ctdSeaProcessing under Matlab.

You can launch the program as debug mode with:_

``` matlab
ctdSeaProcessing('mode','debug')
```
