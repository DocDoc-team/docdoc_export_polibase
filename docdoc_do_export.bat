@echo off
rem =========================================================================
rem Script for do the export data from MIS Infoclinic database to Docdoc.
rem 
rem Developed for medical portal  Docdoc.ru
rem =========================================================================


rem Generate new export files
call docdoc_export.bat
echo.

rem Upload files on Doctoc server
call docdoc_upload.bat
echo.
echo.All done.
