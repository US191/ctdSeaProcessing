# ctdSeaProcessing
Automation pre-processing software for CTD-LADCP

 _Preprocessing software for CTD-LADCP_
 
 _Date: 10/03/16_                                     
 _Autor slave: Pierre Rousselot_                           
 _Jedi master: Jacques Grelet_  
 
-----------------------------------------------------------------------

This Matlab application automate the different steps of the on-board CTD/LADCP processing:
* Copy data acquisition CTD file to processing path                     
* CTD SBE Processing                      
* Copy data acquisition LADCP file to processing path                   
* ADCP LDEO Processing (https://github.com/jgrelet/ladcp)      

-----------------------------------------------------------------------
Your computer must contain the SeaBird processing software `SBEDataProcessing` (under Windows only) and the data compression program `gzip2`.

You can get the latest version of these program there:
* [SBEDataProcessing](http://www.seabird.com/software/sbe-data-processing)
* [gzip2](https://github.com/anandology/gzip2)
	

At the beginning of a cruise:

	- Fill in the 'configuration.ini' file with the cruise information and the directory paths,

	- The workspace file will be used for the entire cruise,
	
	- Launch ctdSeaProcessing under Matlab.



	
_You can launch the program as debug mode with:_
```
ctdSeaProcessing('mode','debug')
```