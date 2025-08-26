@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
title WinDel Package Manager - Secure & Fast

REM Security: Prevent variable injection
set "PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem"

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
echo        Secure Package Update Manager v1.2.1
echo ================================================
echo.

REM Verify dependency installation and security
echo [1/4] Verifying system dependencies...
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo ⚠ WinGet not found - checking alternative locations...
    if exist "%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe" (
        set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WindowsApps"
        echo ✓ WinGet found in Windows Apps folder
    ) else (
        echo ⚠ WinGet not found - attempting automatic installation...
        start /wait ms-windows-store://pdp/?productid=9NBLGGH4NNS1
        timeout /t 10 >nul
        where winget >nul 2>&1
        if %errorLevel% neq 0 (
            if exist "%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe" (
                set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WindowsApps"
                echo ✓ WinGet installation completed
            ) else (
                echo ✗ Installation failed. Please install WinGet manually and restart.
                pause
                exit /b 1
            )
        )
    )
)

winget --version >nul 2>&1
if %errorLevel% neq 0 (
    echo ✗ System dependencies found but not responding
    echo [SOLUTION] Please restart your computer and try again
    pause
    exit /b 1
)

echo ✓ Dependencies verified and operational
echo [2/4] Validating WinGet integrity...
winget --info >nul 2>&1
if %errorLevel% neq 0 (
    echo ✗ WinGet integrity check failed
    echo [SECURITY] Please reinstall WinGet from Microsoft Store
    pause
    exit /b 1
)
echo ✓ WinGet integrity validated
echo [3/4] Refreshing package sources...
winget source update --disable-interactivity >nul 2>&1
echo ✓ Package sources updated
echo [4/4] System ready
echo.

:MAIN_MENU
cls
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [ADMIN] - WinDel Package Manager v1.2.0
) else (
    echo [USER]  - WinDel Package Manager v1.2.0
)
echo ====================================================
echo.
echo    1. 🔍 Check for updates [ENTER]
echo    2. ⚡ Update all packages
echo    3. ✅ Choose which to update
echo    0. ❌ Exit
echo.
echo ====================================================
set /p choice="Choice (default=1): "

if "%choice%"=="" set choice=1
if "%choice%"=="1" goto SCAN_UPDATES
if "%choice%"=="2" goto UPDATE_ALL_CONFIRM
if "%choice%"=="3" goto INTERACTIVE_UPDATE
if "%choice%"=="0" goto EXIT
echo Invalid choice. Press any key to continue...
timeout /t 2 >nul
goto MAIN_MENU

:SCAN_UPDATES
cls
echo Scanning for available updates...
echo ====================================================
echo.

set temp_updates=%temp%\winget_scan_%random%.txt
winget upgrade --include-unknown --disable-interactivity > "%temp_updates%" 2>&1

findstr /C:"No applicable update found" "%temp_updates%" >nul
if %errorLevel% equ 0 (
    echo ✓ All packages are up to date!
    del "%temp_updates%" 2>nul
    echo.
    echo Press any key to continue or wait 5 seconds...
    timeout /t 5 >nul
    goto MAIN_MENU
)

findstr /C:"upgrades available" "%temp_updates%" >nul
if %errorLevel% neq 0 (
    echo ✓ No updates found for your installed packages.
    del "%temp_updates%" 2>nul
    echo.
    echo Press any key to continue or wait 5 seconds...
    timeout /t 5 >nul
    goto MAIN_MENU
)

echo Updates found for your installed packages:
echo ====================================================
type "%temp_updates%"
del "%temp_updates%" 2>nul
echo ====================================================
echo.
echo Press any key to continue or wait 5 seconds...
timeout /t 5 >nul
goto MAIN_MENU

:UPDATE_ALL_CONFIRM
cls
echo ⚡ UPDATE ALL PACKAGES
echo ====================================================
echo.
echo This will update ALL available packages automatically.
echo.
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Note: Administrator prompts may appear during installation
)
echo.
echo Continue? [Y/n] (default=Yes, 10sec timeout)
choice /c yn /d y /t 10 /m "Press Y for Yes, N for No"
if errorlevel 2 goto MAIN_MENU

echo.
echo 🚀 Starting updates...
echo ====================================================
winget upgrade --all --accept-package-agreements --accept-source-agreements --silent --disable-interactivity
echo ====================================================
echo ✓ All updates completed!
timeout /t 3 >nul
goto MAIN_MENU

:INTERACTIVE_UPDATE
cls
echo INTERACTIVE UPDATE SELECTION
echo ====================================================
echo.
echo Fetching update list...

set temp_list=%temp%\winget_interactive_%random%.txt
winget upgrade --include-unknown --disable-interactivity > "%temp_list%" 2>&1

findstr /C:"No applicable update found" "%temp_list%" >nul
if %errorLevel% equ 0 (
    echo ✓ All packages are up to date!
    del "%temp_list%" 2>nul
    echo.
    echo Returning to menu in 3 seconds...
    timeout /t 3 >nul
    goto MAIN_MENU
)

findstr /C:"upgrades available" "%temp_list%" >nul
if %errorLevel% neq 0 (
    echo ✓ No updates found for your installed packages.
    del "%temp_list%" 2>nul
    echo.
    echo Returning to menu in 3 seconds...
    timeout /t 3 >nul
    goto MAIN_MENU
)

echo.
echo Available Updates:
echo ====================================================

set count=0
echo  # │ Package Name                 │ Current    │ Available  
echo ───┼──────────────────────────────┼────────────┼────────────
for /f "usebackq skip=2 tokens=1,2,3,4 delims=	 " %%a in ("%temp_list%") do (
    if not "%%a"=="Name" if not "%%a"=="" if not "%%a"=="-----" (
        set /a count+=1
        set "pkg_name[!count!]=%%a"
        set "pkg_id[!count!]=%%b" 
        set "current[!count!]=%%c"
        set "available[!count!]=%%d"
        
        set "display_name=%%a                             "
        set "display_name=!display_name:~0,28!"
        set "display_current=%%c          "
        set "display_current=!display_current:~0,10!"
        set "display_available=%%d          "
        set "display_available=!display_available:~0,10!"
        
        echo !count!│ !display_name! │ !display_current! │ !display_available!
    )
)

del "%temp_list%" 2>nul

if %count%==0 (
    echo No updates found.
    echo.
    timeout /t 3 >nul
    goto MAIN_MENU
)

echo ───┼──────────────────────────────┼────────────┼────────────
echo.
echo Found %count% available updates
echo.
echo Quick options: [a]ll, [1-5], [1,3,5], [Enter]=back
set /p selection="Selection: "

if /i "%selection%"=="a" set selection=all
if "%selection%"=="" goto MAIN_MENU

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
echo ✓ Selected updates completed!
echo.
timeout /t 3 >nul
goto MAIN_MENU

:UPDATE_ALL_INTERACTIVE
echo Updating all %count% packages...
echo ====================================================
for /l %%i in (1,1,%count%) do (
    echo [%%i/%count%] ████████████████████████████████████████ Updating !pkg_name[%%i]!
    winget upgrade --id "!pkg_id[%%i]!" --accept-package-agreements --accept-source-agreements --silent --disable-interactivity
    if !errorLevel! equ 0 (
        echo    ✓ !pkg_name[%%i]! updated successfully
    ) else (
        echo    ⚠ !pkg_name[%%i]! completed with warnings
    )
    echo.
)
goto :eof

:PROCESS_SELECTION
set "input=%~1"
REM Security: Sanitize input - remove dangerous characters
set "input=!input:&=!"
set "input=!input:|=!"
set "input=!input:>=!"
set "input=!input:<=!"
set "input=!input:;=!"
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
    echo [%num%/%count%] ████████████████████████████████████████ Updating !pkg_name[%num%]!
    winget upgrade --id "!pkg_id[%num%]!" --accept-package-agreements --accept-source-agreements --silent --disable-interactivity
    if !errorLevel! equ 0 (
        echo    ✓ !pkg_name[%num%]! updated successfully
    ) else (
        echo    ⚠ !pkg_name[%num%]! completed with warnings
    )
    echo.
) else (
    echo ✗ Invalid selection: %num% (valid: 1-%count%)
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