@echo off
xcopy /Y server.crt %systemdrive%\xampp\apache\conf\ssl.crt\
xcopy /Y server.key %systemdrive%\xampp\apache\conf\ssl.key\
pause 