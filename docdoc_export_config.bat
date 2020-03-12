@echo off
rem ===================  Database settings  =================================

rem Connection string to Oracle database
rem format username/pasword@host:port/service
rem default port 1521 may be ommited
rem if you don't know credentials you can find their in polibase.ini config
rem in Polibase installation directory
rem
rem Examples:
rem   "con_str=admin/pass@clinicdb:1521/XE"
rem   "con_str=admin/pass@localhost/XE"
rem 
set "con_str=POLIBASE/POLIBASE@localhost/XE"



rem Full path to 'sqlplus' tool of Oracle database management system
rem 
rem Examples:
rem   "sql_cmd_path=E:\oraclexe\app\oracle\product\10.2.0\server\BIN"
rem 
set "sql_cmd_path=E:\oraclexe\app\oracle\product\10.2.0\server\BIN"


rem ===========  Upload settings  ===========================================

rem FTP host & port, user and password settings
rem FTP host examples:
rem   ftphost=ftp.docdoc.ru
rem   ftphost=ftp.docdoc.ru:21
set ftphost=ftp.docdoc.ru
set ftpuser=testuser
set ftppass=pass
rem Directory is where all files will be saved
set ftpstartdir=
rem path to winscp ftp client
set "winscppath=winscp\"
rem proxy settings for FTP connection
rem set "winscpsettings=ProxyHost^=testhost ProxyUsername^=testuser FtpProxyLogonType^=6 ProxyPasswordEnc^=passwordhash"
rem proxy settings for webDav connection
rem set "winscpsettings=ProxyMethod=3 ProxyHost^=testhost ProxyUsername^=testuser ProxyPasswordEnc^=passwordhash"
set ftplogpath=ftp.log
rem Accept ftp or webdav value for using approciate client protocol
set uploadmode=webdav



rem =======  Internal variables (DO NOT MODIFY THEM if not sure)  ===========

rem Subpath to sql commandlets
set sqlpath=.\sql\
rem Subpath where to put export files
set exportpath=.\export\
rem List of subnames of sql commandlets (and corresponding export files)
set exportfiles=clinics doctors schedule busyslots

