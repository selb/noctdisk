@echo off
del %dosdir%\appinfo\help.lsm
del %dosdir%\bin\bookshlf.exe
del %dosdir%\bin\help.exe
del %dosdir%\nls\htmlhelp.en
del %dosdir%\nls\htmlhelp.nl
del %dosdir%\help\fdl.txt
del %dosdir%\help\index.htm
deltree /y %dosdir%\help\docinfo
deltree /y %dosdir%\help\en
deltree /y %dosdir%\doc\help