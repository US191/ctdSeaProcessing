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
	-ladcp: Specific CTD processing for LADCP processing. 
	-codac: Data reduction for real-time transmission to Coriolis.
	-std: Standard processing to export ASCII data.
	-plt: Plot CTD profile.
	-report: Generate report CTD file.
	-btl: Bottle file processing.
* Copy data acquisition LADCP file to processing path                   
* ADCP LDEO Processing (https://github.com/jgrelet/ladcp)      

-----------------------------------------------------------------------
Your computer must contain the SeaBird processing software `SBEDataProcessing` (under Windows only) and the data compression program `gzip2`.

You can get the latest version of these program there:
* [SBEDataProcessing](http://www.seabird.com/software/sbe-data-processing)
* [gzip2](https://github.com/anandology/gzip2)
	

At the beginning of a cruise:

	- Fill in the 'configuration.ini' file with the cruise information and the directory paths 
	  (The workspace file will be used for the entire cruise),
```
_% Mission variables_
_name_mission_  
_id_mission_     
_num_station     -> (if you want to process a specific station)_
_filename_ADCPM  -> Name of the output master LADCP file_
_filename_ADCPS  -> Name of the output slave LADCP file_
_name_adcpmaster -> New name for the master LADCP file_
_name_adcpslave  -> New name for the slace LADCP file_
_log_filename    -> Name of the logfile_

_% Checkbox state (default)_
_copyCTD         = true_
_copyADCP        = true_
_processCTD      = true_
_processADCP     = true_
_processPMEL     = false (PMEL processing is a specific CTD processing for profile without bottle)_ 

_% Path_
 _%Working dir_                                      (Path of the data processing directory)_
_drive           = m:\_
 _%Output CTD/LADCP                                 (Path of the output CTD and LADCP files)_
_path_seasoft    = c:\SEASOFT\_
_path_dataladcp  = c:\LADCP\_

_############################################################################_
_% Disk Organization_

_# LDEO program location : (drive\nom_mission...)_
_pmatlab         = \data-processing\LADCP\v10.16.2\ (Path of the LDEO program directory)_

_#(drive\nom_mission...)_
_pprocessingCTD  = \data-processing\CTD             (Path of the CTD data processed files)_           

_#(path_processing...)_
_pprocessCTD     = \data\raw\                       (Path for the CTD raw data files before processing)_

_#(drive\nom_mission...)_
_prawCTD         = \data-raw\CTD\                   (Path for the CTD raw data files)_

_#(path_seasoft\nom_mission...)_
_poutputCTD      = \data\                           (Path of the output CTD files)_                          

_#(drive\nom_mission\pprocessingCTD...)_
_pbatch          = \batch\                          (Path of the .batch files for processing)_

_#(drive\nom_mission\pprocessingCTD...)_
_pcodac          = \data\codac\                     (Path for the compressed CTD files for CORIOLIS)_

_#(drive\nom_mission\pprocessingCTD...)_
_preports        = \data\reports\                   (Path for the CTD report files)_

_#(drive\nom_mission...)_
_pprocessingADCP = \data-processing\LADCP\data\     (Path for the LADCP data processed files)_   

_#(drive\nom_mission...)_
_prawADCP        = \data-raw\LADCP\                 (Path for the  LADCP raw data files before processing)_               

_#(path_dataladcp\nom_mission...)_
_poutputADCP     = \download\                       (Path of the output LADCP files)_                      

_#(path_dataladcp\nom_mission...)_
_pmoveADCP       =\data\                            (Path to move the output LADCP files)_
```	
	- Launch ctdSeaProcessing under Matlab.



	
_You can launch the program as debug mode with:_
```
ctdSeaProcessing('mode','debug')
```
