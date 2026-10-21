@echo off
title TECHNEX PC Toolkit
color 0B

:menu
cls
call :banner
echo   [1] System Information
echo   [2] Network Information (IP Address)
echo   [3] Internet Connection Test
echo   [4] Disk Space
echo   [5] Clean Temporary Files
echo   [6] Running Programs (with Close option)
echo   [7] Open Calculator / Notepad
echo   [0] Exit
echo.
echo  ------------------------------------------------------------
set /p choice=  Enter your choice (0-7): 

if "%choice%"=="1" goto sysinfo
if "%choice%"=="2" goto netinfo
if "%choice%"=="3" goto pingtest
if "%choice%"=="4" goto disk
if "%choice%"=="5" goto clean
if "%choice%"=="6" goto tasks
if "%choice%"=="7" goto apps
if "%choice%"=="0" goto end
echo.
echo  Invalid choice. Please try again.
pause
goto menu

:sysinfo
cls
call :banner
echo   --- System Information ---
echo.
echo   Computer Name : %COMPUTERNAME%
echo   User Name     : %USERNAME%
echo   Date          : %DATE%
echo   Time          : %TIME%
echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
pause
goto menu

:netinfo
cls
call :banner
echo   --- Network Information ---
echo.
ipconfig | findstr /C:"IPv4" /C:"Subnet" /C:"Default Gateway"
echo.
pause
goto menu

:pingtest
cls
call :banner
echo   --- Internet Connection Test ---
echo.
ping -n 4 google.com
echo.
pause
goto menu

:disk
cls
call :banner
echo   --- Disk Space (sizes shown in bytes) ---
echo.
wmic logicaldisk get caption,description,freespace,size
echo.
pause
goto menu

:clean
cls
call :banner
echo   --- Clean Temporary Files ---
echo.
echo   This will delete files from your temp folder:
echo   %TEMP%
echo.
set /p confirm=  Do you want to continue? (Y/N): 
if /i not "%confirm%"=="Y" goto menu
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >nul 2>&1
echo.
echo   Temporary files cleaned successfully.
pause
goto menu

:tasks
cls
call :banner
echo   --- Running Programs ---
echo.
echo   [L] List running programs
echo   [K] Close a program
echo   [B] Back to main menu
echo   [E] Exit TECHNEX Toolkit
echo.
echo   ------------------------------------------------------------
set "tchoice="
set /p tchoice=  Enter your choice (L/K/B/E): 
if /i "%tchoice%"=="L" goto listtasks
if /i "%tchoice%"=="K" goto killtask
if /i "%tchoice%"=="E" goto end
goto menu

:listtasks
cls
echo   --- Running Programs ---
echo   Press SPACE for next page, or Q to stop and go back.
echo   ------------------------------------------------------------
tasklist | more
echo.
pause
goto tasks

:killtask
echo.
echo   Type the program name exactly as shown above.
echo   Example: notepad.exe
echo.
set "pname="
set /p pname=  Program name (or press Enter to cancel): 
if "%pname%"=="" goto tasks
set /p kconfirm=  Close "%pname%"? Unsaved work will be lost. (Y/N): 
if /i not "%kconfirm%"=="Y" goto tasks
taskkill /IM "%pname%" /F
echo.
pause
goto tasks

:apps
cls
call :banner
echo   [1] Calculator
echo   [2] Notepad
echo.
set /p app=  Enter your choice: 
if "%app%"=="1" start calc
if "%app%"=="2" start notepad
goto menu

:end
cls
call :banner
echo   Thank you for using TECHNEX PC Toolkit.
echo   Innovate. Build. Inspire.  -  TECHNEX
echo.
timeout /t 3 >nul
exit

:banner
echo.
echo   ########  ########   ######  ##     ## ##    ## ######## ##     ##
echo      ##     ##        ##    ## ##     ## ###   ## ##        ##   ##
echo      ##     ######    ##       #########  ## ##  ## ######     ## ##
echo      ##     ##        ##    ## ##     ## ##  ## ## ##        ##   ##
echo      ##     ########   ######  ##     ## ##   #### ######## ##     ##
echo.
echo   ============================================================
echo                 TECHNEX PC TOOLKIT   -   v1.0
echo               Powered by TECHNEX  ^|  technex-official.vercel.app
echo   ============================================================
echo.
goto :eof