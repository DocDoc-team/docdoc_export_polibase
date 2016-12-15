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
rem creating variable for newline sequence
set EOL=^


rem # 2. Delete previous existing export files if its exists
echo Cleaning from old export files
for %%a in (%exportfiles%) do (
    if exist %exportpath%%%a.csv del /Q /F %exportpath%%%a.csv
)


rem # 3. Make fresh data export from DB
echo Generate new fresh export files

for %%a in (%exportfiles%) do (
    echo - %%a

rem clearing sql query
    set sqlcommand=

rem adding needed settings for csv spooling
    set sqlstart=set TERMOUT off!EOL!set colsep ^";^"!EOL!set headsep ^";^"!EOL!set feedback off!EOL!set pagesize 0 embedded on!EOL!set linesize 2000!EOL!set trimspool on!EOL!set underline off!EOL!spool %exportpath%%%a.csv!EOL!

rem reading sql from storage
    for /f "eol=- tokens=*" %%b in (%sqlpath%docdoc_export_%%a.sql) do set sqlcommand=!sqlcommand!%%b!EOL!

rem buiding final sql with spolling commands
    set "sqlcommand=!sqlstart!!EOL!!sqlcommand!spool off;!eol!quit;"

rem creating temporary file for PL SQL script
    echo !sqlcommand! > tmp/tmp.sql

    "%sql_cmd_path%\sqlplus" -S %con_str% @tmp/tmp.sql
)

rem removing temporary file
if exist tmp/tmp.sql del /Q /F tmp/tmp.sql

rem # 4. This batch is done.
rem To upload exported files run docdoc_upload.bat
echo Export files generated.
