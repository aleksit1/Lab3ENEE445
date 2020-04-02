@echo off
REM hex2mem.bat wmh 2018-09-23
echo This is run to convert a .hex file generated in Keil to a a .mem file for use by Vivado.
echo Paths and file names are hard-coded for the current setup and should be edited if
echo the locations of the .hex source and .mem destination are changed
pause
_hex2mem3 ..\8051_code\BLINKY.hex ..\..\project_2.srcs\sources_1\imports\8051_logic\BLINKY.mem
echo:
echo Any conversion errors reported?
pause
echo Now updating ROM4Kx8.v timestamp (DOS kludge) for "Refresh Changed Modules" operation in Vivado synthesis
copy /b  ..\..\project_2.srcs\sources_1\imports\8051_logic\ROM4Kx8.v+,, ..\..\project_2.srcs\sources_1\imports\8051_logic\ROM4Kx8.v
pause


