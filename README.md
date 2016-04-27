# ctdSeaProcessing
Automation pre-processing software for CTD-LADCP

 Preprocessing software for CTD-LADCP                                     
 Autor slave: Pierre Rousselot / Date: 10/03/16                           
 Jedi master: Jacques Grelet  
 Test
-----------------------------------------------------------------------

 Different steps :                                                        
 -> Copy data acquisition CTD file to processing path                     
 -> CTD SBE Processing                      
 -> Copy data acquisition LADCP file to processing path                   
 -> ADCP Processing       

-----------------------------------------------------------------------
(Need Windows for SBEDataProcessing and gzip2 for compressing Codac file)   

You can launch the program as debug mode with: ctdSeaProcessing('mode','debug')


At the beginning of a cruise:

	- Fill in the 'configuration.ini' file with the cruise information and the directory paths,

	- The workspace file will be used for the entire cruise.
