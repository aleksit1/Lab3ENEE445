echo off
echo This sets paths to mingw-w64 gcc compiler and msys64 bash utililites like grep, find, etc.
echo Note: use 'mingw32-make'
rem Note: 
PATH=C:\Program Files\mingw-w64\x86_64-4.9.2-posix-seh-rt_v4-rev2\mingw64\bin;%PATH%

PATH=C:\msys64\usr\bin;%PATH%

PATH=C:\Python27\;%PATH%
"C:\Windows\system32\cmd.exe"
