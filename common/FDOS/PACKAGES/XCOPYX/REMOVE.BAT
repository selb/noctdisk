@echo off
del %dosdir%\appinfo\xcopy.lsm
del %dosdir%\bin\xcopy.exe
del %dosdir%\nls\xcopy.en
del %dosdir%\nls\xcopy.de
del %dosdir%\nls\xcopy.nl
deltree /y %dosdir%\doc\xcopy
