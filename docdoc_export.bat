@echo off
rem =========================================================================
rem Script for generating export files from MIS PolyBase database.
rem 
rem Developed for medical portal  Docdoc.ru
rem =========================================================================


rem # 1. Configure variables
SetLocal EnableDelayedExpansion EnableExtensions
echo Loading...
call docdoc_export_config.bat


rem # 2. Delete previous existing export files if its exists
echo Cleaning from old export files
for %%a in (%exportfiles%) do (
    if exist %exportpath%%%a.csv del /Q /F %exportpath%%%a.csv
)


rem # 3. Make fresh data export from DB
echo Generate new fresh export files
for %%a in (%exportfiles%) do (
    echo - %%a

    set sqlstart = "set colsep ;\nset headsep off\set pagesize 0\nset trimspool on\nspool %exportpath%%%a.csv\n"

    set /p sqlcommand=<%sqlpath%docdoc_export_%%a.sql
    set sqlcommand="%sqlstart% %sqlcommand%\n spool off"
    echo %sqlcommand% | "%sql_cmd_path%sqlplus" %constr%
)

rem # 4. This batch is done.
rem To upload exported files run docdoc_upload.bat
echo Export files generated.
