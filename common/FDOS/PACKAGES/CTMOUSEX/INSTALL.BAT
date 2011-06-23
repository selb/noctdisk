@echo off
if not "%LANG%"=="" copy %DOSDIR%\BIN\CTMOUSE\ctm-%LANG%.exe %DOSDIR%\BIN\mouse.exe
if not exist %DOSDIR%\bin\mouse.exe copy %DOSDIR%\BIN\ctmouse.exe %dosdir%\bin\mouse.exe
