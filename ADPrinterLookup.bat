@echo off
cls
echo.

:loop
SET printer=
SET /P printer=Type the full IP Address -OR- location code: || GOTO:EOF
cls
echo.

echo %printer% | find "."
echo.
echo.
call:header
IF %ERRORLEVEL% == 0 (call :IPQuery ) else (call :LocationQuery )
GOTO:loop

:header
echo           ==============================================
echo               Printer information for %printer%
echo           ==============================================
echo.
echo.
GOTO:EOF

:IPQuery
dsquery * domainroot -filter "(&(objectClass=PrintQueue)(portName=*%printer%*))" -attr printerName portName location serverName
echo.
GOTO:EOF

:LocationQuery
dsquery * domainroot -filter "(&(objectClass=PrintQueue)(location=*%printer%*))" -attr printerName portName location serverName
echo.
GOTO:EOF