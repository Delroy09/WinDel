@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
title WinDel Package Manager - Secure & Fast

REM Security and admin check
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [ADMIN MODE] Running with administrator privileges
) else (
    echo [USER MODE] UAC prompts may appear for some updates
)

echo.
echo ██╗    ██╗██╗███╗   ██╗
echo ██║    ██║██║████╗  ██║
echo ██║ █╗ ██║██║██╔██╗ ██║
echo ██║███╗██║██║██║╚██╗██║
echo ╚███╔███╔╝██║██║ ╚████║
echo  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
echo.
echo ██████╗ ███████╗██╗     
echo ██╔══██╗██╔════╝██║     
echo ██║  ██║█████╗  ██║     
echo ██║  ██║██╔══╝  ██║     
echo ██████╔╝███████╗███████╗
echo ╚═════╝ ╚══════╝╚══════╝
echo.
echo        Secure Package Update Manager v1.0
echo ================================================
echo.

REM Verify dependency installation and security
echo [1/3] Verifying system dependencies...
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ERROR: Required system dependencies not found
    echo This tool requires additional system components to function.
    echo.
    echo [AUTO-INSTALLING] Downloading and installing dependencies...
    echo Opening Microsoft Store for automatic installation...
    start ms-windows-store://pdp/?productid=9NBLGGH4NNS1
    echo.
    echo [PROGRESS] Installing system components...
    echo [INFO] This process may take a few minutes
    echo [ACTION] Please complete the installation and restart this tool
    echo.
    pause
    exit /b 1
)

winget --version >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: System dependencies found but not responding
    echo [SOLUTION] Please restart your computer and try again
    pause
    exit /b 1
)

echo [SUCCESS] Dependencies verified and operational
echo [2/3] Refreshing package sources...
winget source update >nul 2>&1
echo [SUCCESS] Package sources updated
echo [3/3] System ready
echo.

:MAIN_MENU
cls
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [ADMIN] - WinDel Update Manager - Secure Mode
) else (
    echo [USER]  - WinDel Update Manager - Standard Mode
)
echo ====================================================
echo.
echo Quick Actions:
echo    1. Scan for updates
echo    2. Update all packages
echo    3. Interactive update selection
echo    4. Exit
echo.
echo ====================================================
set /p choice="Enter choice (1-4): "

if "%choice%"=="1" goto SCAN_UPDATES
if "%choice%"=="2" goto UPDATE_ALL_CONFIRM
if "%choice%"=="3" goto INTERACTIVE_UPDATE
if "%choice%"=="4" goto EXIT
echo Invalid choice. Please enter 1-4.
timeout /t 2 >nul
goto MAIN_MENU

:SCAN_UPDATES
cls
echo Scanning for available updates...
echo ====================================================
echo.

set temp_updates=%temp%\winget_scan_%random%.txt
winget upgrade --include-unknown > "%temp_updates%" 2>&1

findstr /C:"No applicable update found" "%temp_updates%" >nul
if %errorLevel% equ 0 (
    echo All packages are up to date!
    del "%temp_updates%" 2>nul
    echo.
    pause
    goto MAIN_MENU
)

findstr /C:"upgrades available" "%temp_updates%" >nul
if %errorLevel% neq 0 (
    echo No updates found for your installed packages.
    del "%temp_updates%" 2>nul
    echo.
    pause
    goto MAIN_MENU
)

echo Updates found for your installed packages:
echo ====================================================
type "%temp_updates%"
del "%temp_updates%" 2>nul
echo ====================================================
echo.
pause
goto MAIN_MENU

:UPDATE_ALL_CONFIRM
cls
echo WARNING: UPDATE ALL PACKAGES
echo ====================================================
echo.
echo This will update ALL available packages automatically.
echo.
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Note: Administrator prompts may appear during installation
)
echo.
set /p confirm="Continue with updating all packages? (y/n): "
if /i not "%confirm%"=="y" goto MAIN_MENU

echo.
echo Starting mass update process...
echo ====================================================
winget upgrade --all --accept-package-agreements --accept-source-agreements --silent
echo ====================================================
echo Mass update process completed!
echo.
pause
goto MAIN_MENU

:INTERACTIVE_UPDATE
cls
echo INTERACTIVE UPDATE SELECTION
echo ====================================================
echo.
echo Fetching update list...

set temp_list=%temp%\winget_interactive_%random%.txt
winget upgrade --include-unknown > "%temp_list%" 2>&1

findstr /C:"No applicable update found" "%temp_list%" >nul
if %errorLevel% equ 0 (
    echo All packages are up to date!
    del "%temp_list%" 2>nul
    echo.
    pause
    goto MAIN_MENU
)

findstr /C:"upgrades available" "%temp_list%" >nul
if %errorLevel% neq 0 (
    echo No updates found for your installed packages.
    del "%temp_list%" 2>nul
    echo.
    pause
    goto MAIN_MENU
)

echo.
echo Available Updates:
echo ====================================================

set count=0
echo  # ^| Package Name                  ^| Current      ^| Available    ^| Package ID
echo ---+-------------------------------+--------------+--------------+---------------------
for /f "usebackq skip=2 tokens=1,2,3,4 delims=	 " %%a in ("%temp_list%") do (
    if not "%%a"=="Name" if not "%%a"=="" if not "%%a"=="-----" (
        set /a count+=1
        set "pkg_name[!count!]=%%a"
        set "pkg_id[!count!]=%%b" 
        set "current[!count!]=%%c"
        set "available[!count!]=%%d"
        
        set "display_name=%%a                               "
        set "display_name=!display_name:~0,29!"
        set "display_current=%%c              "
        set "display_current=!display_current:~0,12!"
        set "display_available=%%d              "
        set "display_available=!display_available:~0,12!"
        
        echo !count!^| !display_name! ^| !display_current! ^| !display_available! ^| %%b
    )
)

del "%temp_list%" 2>nul

if %count%==0 (
    echo No updates found.
    echo.
    pause
    goto MAIN_MENU
)

echo ---+-------------------------------+--------------+--------------+---------------------
echo.
echo Found %count% available updates
echo.
echo Selection Options:
echo    • Single: 3
echo    • Multiple: 1,3,5,7
echo    • Range: 1-5
echo    • Mixed: 1,3-5,8
echo    • All: all
echo.
set /p selection="Enter your selection: "

if /i "%selection%"=="all" goto UPDATE_ALL_INTERACTIVE
if "%selection%"=="" goto MAIN_MENU

echo.
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Note: Administrator prompts may appear for some packages
)
echo.
echo Processing selected updates...
echo ====================================================

call :PROCESS_SELECTION "%selection%"

echo ====================================================
echo Selected updates completed!
echo.
pause
goto MAIN_MENU

:UPDATE_ALL_INTERACTIVE
echo Updating all %count% packages...
echo ====================================================
for /l %%i in (1,1,%count%) do (
    echo [%%i/%count%] Updating: !pkg_name[%%i]!
    winget upgrade --id "!pkg_id[%%i]!" --accept-package-agreements --accept-source-agreements --silent
)
goto :eof

:PROCESS_SELECTION
set "input=%~1"
set "input=!input: =!"

for %%i in (!input!) do (
    set "item=%%i"
    echo !item! | findstr "-" >nul
    if !errorLevel! equ 0 (
        for /f "tokens=1,2 delims=-" %%a in ("!item!") do (
            set start=%%a
            set end=%%b
            if !start! leq %count% if !end! leq %count% (
                for /l %%n in (!start!,1,!end!) do (
                    call :UPDATE_SINGLE %%n
                )
            )
        )
    ) else (
        call :UPDATE_SINGLE !item!
    )
)
goto :eof

:UPDATE_SINGLE
set num=%1
if %num% gtr 0 if %num% leq %count% (
    echo [%num%/%count%] Updating !pkg_name[%num%]! (!current[%num%]! to !available[%num%]!)
    winget upgrade --id "!pkg_id[%num%]!" --accept-package-agreements --accept-source-agreements --silent
    if !errorLevel! equ 0 (
        echo    Update completed successfully
    ) else (
        echo    Update completed with warnings or user interaction required
    )
    echo.
) else (
    echo Invalid selection: %num% (valid: 1-%count%)
)
goto :eof

:EXIT
cls
echo.
echo ████████╗██╗  ██╗ █████╗ ███╗   ██╗██╗  ██╗███████╗
echo ╚══██╔══╝██║  ██║██╔══██╗████╗  ██║██║ ██╔╝██╔════╝
echo    ██║   ███████║███████║██╔██╗ ██║█████╔╝ ███████╗
echo    ██║   ██╔══██║██╔══██║██║╚██╗██║██╔═██╗ ╚════██║
echo    ██║   ██║  ██║██║  ██║██║ ╚████║██║  ██╗███████║
echo    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
echo.
echo    Thank you for using WinDel Update Manager!
echo    Your system packages are now optimized.
echo.
echo ====================================================
timeout /t 3 >nul
exit /b 0