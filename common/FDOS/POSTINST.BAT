@echo off
if [%errorlevel%]==[] goto error
if [%_CWD%]==[] goto error
if "%cdrom%"=="C:" goto error2
if "%cdrom%"=="c:" goto error2
if "%step6%"=="û" goto end
bin\xmssize 5>NUL
if errorlevel 15 set XMS=15
if not errorlevel 15 set XMS=%errorlevel%
for %%x in ( 4 5 6 ) do if "%cputype%"=="80%%x86" set cputype=80386
if not "%cputype%"=="80186" if not "%cputype%"=="80286" if not "%cputype%"=="80386" set cputype=80386
goto begin

rem #1: Copy kernel
rem #2: Search bootup files
rem  -2a: comfile (comspec/shell/command interpreter, command.com)
rem  -2b: autofile (bootup automation script, autoexec.bat)
rem  -2c: cfgfile (device driver loading script, [fd]config.sys)
rem #3: Create bootup files
rem #4: Translate programs and install them
rem #5: Clean up

:begin
cls
set fdosdir=%_CWD%
set nlspath=%fdosdir%
if "%bootsrc%"=="" set path=%fdosdir%;%path%
if "%bootsrc%"=="diskette" set path=%fdosdir%;%path%
if not "%BOOT_IMAGE%"=="" set toolpath=a:\freedos
rem ctty nul
cdd %fdosdir%
ren localize.txt localize.%lang%
for %%x in ( 1 2 3 4 5 6 7 ) DO set step%%x=é
goto infomenu

:infomenu
set nlspath=%fdosdir%
ctty con
cls
for %%x in ( 0 1 2 ) do localize 3.%%x
for %%x in ( 1 2 3 4 5 6 ) do if "%step%%x%"=="û" localize 4.%%x
for %%x in ( 1 2 3 4 5 6 ) do if "%step%%x%"=="é" localize 5.%%x
rem ctty nul
set nlspath=%fdosdir%
for %%x in ( 1 2 3 4 5 6 7) do if "%step%%x%"=="é" goto step%%x
goto end

:step1
set step1=û
set copycmd=/y
copy %fdosdir%\bin\kernel.sys %destdrv%\kernel.sys
goto infomenu

:step2
if exist localize.txt ren localize.txt localize.%lang%
goto step2a

:step2a
set autofile=%fdosdir%\fdauto.bat
set cfgfile=%destdrv%\fdconfig.sys
if not exist %cfgfile% goto endloop
set testn=0
:loop
if not exist %destdrv%\fdconfig.%testn% goto endloop
add %testn% 1>NUL
set testn=%errorlevel%
goto loop
:endloop
if not "%testn%"=="" copy %destdrv%\fdconfig.sys %destdrv%\fdconfig.%testn%
set testn=
set comfile=%fdosdir%\bin\command.com
goto step2b

:step2b
echo @echo off > %autofile%
echo SET dosdir=%fdosdir%>> %autofile%
rem LFN support in FreeCOM isn't 100% stable yet
if "%cputype%"=="" set cputype=80386
if "%cputype%"=="80386" if exist %fdosdir%\bin\banner2.com echo REM %fdosdir%\BIN\BANNER2 >> %autofile%
for %%x in ( 1 2 3 4 5 6 7 10 11 12 ) do localize 2.%%x >> %autofile%
if not !%cp%==! localize 2.13 >> %autofile%
if not !%cp%==! echo if not "%%config%%"=="4" MODE CON CP PREP=((%cp%) %fdosdir%\cpi\%cpxfile%.CPX)>>%autofile%
if not !%cp%==! echo if not "%%config%%"=="4" LH MODE CON CP SEL=%cp%>>%autofile%
echo if "%%config%%"=="2" LH SHARE>>%autofile%
if not !%xms%==! if not !%xms%==!0 localize 2.8 >> %autofile%
if !%xms%==! localize 2.9 >> %autofile%
if !%xms%==!0 localize 2.9 >> %autofile%
set step2=û
if exist %destdrv%\metakern.sys goto infomenu
if exist %destdrv%\autoexec.bat goto step2c
rem Moving file and adjusting %autofile%
rem Only use \AUTOEXEC.BAT if it doesn't exist already and no other DOS-flavour is detected.
copy %autofile% %destdrv%\autoexec.bat
if exist %destdrv%\autoexec.bat del %fdosdir%\fdauto.bat
if exist %destdrv%\autoexec.bat set autofile=%destdrv%\autoexec.bat
echo SET autofile=%autofile% >> %autofile%
echo alias reboot=fdapm warmboot >> %autofile%
echo alias halt=fdapm poweroff >> %autofile%
goto step2c

:step2c
rem if not exist %destdrv%\config.sys ren %destdrv%\fdconfig.sys config.sys
rem if exist %destdrv%\config.sys set cfgfile=%destdrv%\config.sys
rem if exist %destdrv%\fdconfig.sys set cfgfile=%destdrv%\fdconfig.sys
goto infomenu

:step3
pushd
CDD %fdosdir%\NLS
rem MakeCMD creates command.com by binary copying *.cln and strings.dat
if exist makecmd.bat call makecmd.bat
if exist command.com copy /y command.com %comfile%
if not exist \command.com copy %comfile% \
if exist %fdosdir%\nls\command.com del %fdosdir%\nls\command.com
set copycmd=/y
popd
cls
set step3=û
goto infomenu

:step4
cls
if "%cp%"=="" set cp=437
echo !COUNTRY=001,%cp%,%fdosdir%\BIN\COUNTRY.SYS > %cfgfile%
echo !SET lang=%lang% >> %cfgfile%
for %%x in ( 3 4 5 6 7 8 9 10 ) DO LOCALIZE 0.%%x >> %cfgfile%
if "%cputype%"=="" set cputype=80386
set cmd_dir=C:\
if not "%comfile%"=="C:\COMMAND.COM" set cmd_dir=%fdosdir%\bin
goto s4_%cputype%

:s4_80186
for %%x in ( 1 2 3 ) DO LOCALIZE 0.1%%x >> %cfgfile%
rem swap FreeCOM (non-XMS version!) to harddisk when using CALL /S prog.exe
ECHO 1?SHELLHIGH=%fdosdir%\bin\KSSF.COM %comfile% /K %autofile% >> %cfgfile%
set step4=û
goto infomenu

:s4_80286
copy %fdosdir%\NLS\command.com %comfile%
for %%x in ( 1 2 ) DO LOCALIZE 0.2%%x >> %cfgfile%
ECHO 1?DEVICE=%fdosdir%\BIN\FDXMS286.SYS >> %cfgfile%
ECHO 12?SHELL=%comfile% %cmd_dir% /P=%autofile% >> %cfgfile%
goto sub4keyb

:s4_80386
if exist %fdosdir%\bin\kernel32.sys copy /y %fdosdir%\bin\kernel32.sys %destdrv%\kernel.sys
for %%x in ( 0 1 2 3 ) DO LOCALIZE 0.3%%x >> %cfgfile%
if exist %fdosdir%\packages\grubx\nul localize 0.34 >> %cfgfile%
if exist %fdosdir%\packages\grubx\nul echo 5?DEVICE=%fdosdir%\bin\grub.exe >> %cfgfile%
localize 0.35 >> %cfgfile%
ECHO 123?DEVICE=%fdosdir%\BIN\HIMEM.EXE >> %cfgfile%
ECHO 1?DEVICE=%fdosdir%\BIN\EMM386.EXE NOEMS X=TEST>> %cfgfile%
ECHO 2?DEVICE=%fdosdir%\BIN\EMM386.EXE X=TEST>> %cfgfile%
ECHO ;123?DEVICEHIGH=%fdosdir%\bin\xdma.sys >> %cfgfile%
ECHO 123?DEVICEHIGH=%fdosdir%\bin\xcdrom.sys /d:FDCD0001 >> %cfgfile%
if not "%xms%"=="" if not "%xms%"=="0" ECHO 123?DEVICEHIGH=%fdosdir%\bin\cdrcache.sys FDCD0001 CDRCACH0 %xms%000 >> %cfgfile%
IF EXIST %fdosdir%\BIN\BLACKOUT.EXE ECHO REM 123?INSTALL=%fdosdir%\BIN\BLACKOUT.EXE >> %cfgfile%
IF EXIST %fdosdir%\BIN\BANNER1.COM ECHO REM 123?INSTALL=%fdosdir%\BIN\BANNER1.COM >> %cfgfile%
IF EXIST %fdosdir%\PACKAGES\MORESYSX\NUL ECHO 123?DEVICEHIGH=%fdosdir%\BIN\MORESYS.SYS >> %cfgfile%
ECHO SHELLHIGH=%comfile% %cmd_dir% /E:1024 /P=%autofile% >> %cfgfile%
ECHO SET CFGFILE=%cfgfile% >> %autofile%
if not "%xms%"=="" if not "%xms%"=="0" ECHO 123?INSTALLHIGH=%fdosdir%\bin\lbacache.com %xms%000 TUNS >> %cfgfile%
goto sub4keyb
 
:sub4keyb
set step4=û
if "%keybfile%"=="" goto infomenu
if not exist %fdosdir%\bin\KEYB.* goto infomenu
echo LH KEYB %kblayout%,,%keybfile% %keybrest% >> %autofile%
set keybrest=
set kblayout=
set keybfile=
cdd -
goto infomenu

:step5
set nlspath=%fdosdir%
REM localize 7.4 %cfgfile%, %autofile%, %comfile% >> %autofile%
for %%x in ( 0 1 2 1 ) do localize 7.%%x >> %autofile%
goto step5a

:step5a
set step5=û
if not exist %fdosdir%\bin\ctmouse.exe goto infomenu
localize 3.3
REM ctty nul
%fdosdir%\bin\ctmouse.exe
if errorlevel 5 goto infomenu
copy /y %fdosdir%\bin\ctmouse.exe %fdosdir%\bin\mouse.exe 
if exist %fdosdir%\bin\ctmouse\ctm-%lang%.exe copy /y %fdosdir%\bin\ctmouse\ctm-%lang%.exe %fdosdir%\bin\mouse.exe
if exist %fdosdir%\bin\mouse.exe ECHO if not "%%config%%"=="4" mouse >> %autofile%
set dosdir=%fdosdir%
ctty con
set path=%fdosdir%\bin;%path%
call postset.bat
goto infomenu

:step6
set step6=û
cd \
cdd %fdosdir%
if not exist %fdosdir%\temp\nul md %fdosdir%\temp
if not exist %fdosdir%\SOURCE\*.zip goto infomenu
CDD %fdosdir%\SOURCE
REM for %%x in ( *.ZIP ) DO %fdosdir%\bin\TUNZ %%x
CDD %fdosdir%
goto infomenu

:step7
ctty con
if not exist %fdosdir%\bin\choice.* goto reboot
set nlspath=%fdosdir%
for %%x in ( 1 2 3 4 ) do localize 6.%%x
%fdosdir%\bin\choice /N /C:NYJI /T:Y,8 .F.R.E.E.D.O.S.:
set reboot=%errorlevel%
if exist %fdosdir%\localize.* del %fdosdir%\localize.*
for %%x in ( 1 ) do if "%reboot%"=="%%x" goto clean_up
goto reboot

:reboot
rem This case handles a minimalistic installation where CHOICE is not installed.
if not exist %fdosdir%\bin\choice.* pause FreeDOS Installation has finished successfully, press a key to restart
%fdosdir%\bin\FDISK /REBOOT
%fdosdir%\bin\FDAPM /COLDBOOT
cls
echo Automatic reboot failed: please restart computer manually by pressing 
echo RESET button on your computer, or by pressing CTRL-ALT-DEL on your keyboard
echo.
goto clean_up

:clean_up
set temp=%fdosdir%\temp
set tmp=%fdosdir%\temp
set path=%fdosdir%\bin
set nlspath=%fdosdir%\NLS
for %%x in ( 1 2 3 4 5 6 7 ) do set step%%x=
for %%x in ( files disksrc bootsrc cputype cdname loadbat checklvl findfile ) DO set %%x=
for %%x in ( instmode menu1_nr menu2_nr opt form_opt instparm autofile key  ) DO set %%x=
for %%x in ( config cfgfile gui_inst comfile languages fdosroot color cdrom ) DO set %%x=
for %%x in ( yeskey virtualcd drivesrc initrd reboot ) DO set %%x=
rem for %%x in ( boot_image validsrc checklvl uniqueid keybfile ) DO set %%x=
goto end

:end
