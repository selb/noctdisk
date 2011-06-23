@echo off
if "%LANG%"=="" lh doslfnms
if "%LANG%"=="" echo lh doslfnms >> %autofile%
if not "%LANG%"=="" lh doslfn
if not "%LANG%"=="" echo lh doslfn >> %autofile%
