@echo off
setlocal enabledelayedexpansion
title WinDel Package Manager

echo.
echo ========================================
echo     WinDel Package Manager v1.3.2
echo ========================================
echo.

REM Check for dependencies
echo Checking for dependencies...
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ========================================
    echo    Dependencies Not Installed!
    echo ========================================
    echo.
    echo WinDel requires package management dependencies to function.
    echo.
    echo Do you wish to install the required dependencies?
    echo.
    choice /c yn /d n /t 15 /m "Install dependencies? (Y/N) - Default: No"
    if errorlevel 2 (
        echo.
        echo This program requires dependencies to run.
        echo Please install the required dependencies and try again.
        echo.
        pause
        exit /b 1
    )
    
    echo.
    echo Installing dependencies...
    echo ====================================================
    echo.
    echo Opening Microsoft Store to install package manager...
    
    REM Try to open Microsoft Store to App Installer page
    start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1
    
    echo.
    echo Microsoft Store should open to install App Installer.
    echo This includes the required package management tools.
    echo.
    echo Please:
    echo 1. Install/Update App Installer from the Store
    echo 2. Restart this program once installation completes
    echo.
    echo If the Store doesn't open, you can:
    echo • Search "App Installer" in Microsoft Store manually
    echo.
    pause
    exit /b 1
)
echo Dependencies found.
echo.

:MAIN_MENU
cls
echo WinDel Package Manager v1.3.2
echo ====================================================
echo.
echo    1. Check for updates
echo    2. Update all packages
echo    3. Choose which to update
echo    4. Exit
echo.
echo ====================================================
set /p choice="Choice (default=1): "

if "%choice%"=="" set choice=1
if "%choice%"=="1" goto SCAN_UPDATES
if "%choice%"=="2" goto UPDATE_ALL_CONFIRM
if "%choice%"=="3" goto INTERACTIVE_UPDATE
if "%choice%"=="4" goto EXIT
echo Invalid choice. Press any key to continue...
timeout /t 2 >nul
goto MAIN_MENU

:SCAN_UPDATES
cls
echo Scanning for available updates...
echo ====================================================
echo.

set temp_updates=%temp%\winget_updates.txt
winget upgrade > "%temp_updates%" 2>&1

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

echo Updates found:
echo ====================================================
type "%temp_updates%"
del "%temp_updates%" 2>nul
echo ====================================================
echo.
echo What would you like to do?
echo.
echo    1. Update all packages
echo    2. Choose which packages to update
echo    3. Return to main menu
echo.
set /p update_choice="Choice (default=3): "

if "%update_choice%"=="" set update_choice=3
if "%update_choice%"=="1" goto UPDATE_ALL_CONFIRM
if "%update_choice%"=="2" goto INTERACTIVE_UPDATE
if "%update_choice%"=="3" goto MAIN_MENU
echo Invalid choice. Returning to main menu...
timeout /t 2 >nul
goto MAIN_MENU

:UPDATE_ALL_CONFIRM
cls
echo UPDATE ALL PACKAGES
echo ====================================================
echo.
echo This will update ALL available packages automatically.
echo.
echo Continue? [Y/n] (default=Yes)
choice /c yn /d y /t 10 /m "Press Y for Yes, N for No"
if errorlevel 2 goto MAIN_MENU

echo.
echo Starting updates...
echo ====================================================
winget upgrade --all --accept-package-agreements --accept-source-agreements
echo ====================================================
echo Updates completed!
echo.
pause
goto MAIN_MENU

:INTERACTIVE_UPDATE
cls
echo INTERACTIVE UPDATE SELECTION
echo ====================================================
echo.
echo Fetching update list...

REM Get clean list of upgradeable packages (excludes unknown)
set temp_list=%temp%\winget_interactive.txt
winget upgrade --include-unknown > "%temp_list%" 2>&1

REM Filter out unknown packages to clean list
set clean_list=%temp%\winget_clean.txt
findstr /V /C:"Unknown" "%temp_list%" > "%clean_list%" 2>nul

findstr /C:"No applicable update found" "%clean_list%" >nul
if %errorLevel% equ 0 (
    echo All packages are up to date!
    del "%temp_list%" 2>nul
    del "%clean_list%" 2>nul
    echo.
    pause
    goto MAIN_MENU
)

findstr /C:"upgrades available" "%clean_list%" >nul
if %errorLevel% neq 0 (
    echo No updates found for your installed packages.
    del "%temp_list%" 2>nul
    del "%clean_list%" 2>nul
    echo.
    pause
    goto MAIN_MENU
)

echo.
echo Available Updates:
echo ====================================================

set count=0
set "found_header=false"

REM Parse the clean winget output
for /f "usebackq tokens=*" %%a in ("%clean_list%") do (
    set "line=%%a"
    
    REM Skip until we find the header with "Name"
    if "!found_header!"=="false" (
        echo !line! | findstr /C:"Name" >nul
        if !errorLevel! equ 0 set "found_header=true"
    ) else (
        REM Skip the separator line with dashes
        echo !line! | findstr /R "^-" >nul
        if !errorLevel! neq 0 (
            REM Process actual package lines (not empty, not header, not dashes)
            if not "!line!"=="" (
                echo !line! | findstr /R "^[A-Za-z]" >nul
                if !errorLevel! equ 0 (
                    REM Extract package details using proper parsing
                    for /f "tokens=1,2,3,4 delims= " %%i in ("!line!") do (
                        REM Skip if line contains "available" without proper ID
                        echo "%%j" | findstr /C:"available" >nul
                        if !errorLevel! neq 0 (
                            if not "%%i"=="" if not "%%j"=="" (
                                set /a count+=1
                                set "pkg_name[!count!]=%%i"
                                set "pkg_id[!count!]=%%j"
                                set "current[!count!]=%%k"
                                set "available[!count!]=%%l"
                                
                                if not "%%k"=="" if not "%%l"=="" (
                                    echo !count!. %%i ^(%%k ^-^> %%l^)
                                ) else (
                                    echo !count!. %%i
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)

del "%temp_list%" 2>nul
del "%clean_list%" 2>nul

if %count%==0 (
    echo No updates found.
    echo.
    pause
    goto MAIN_MENU
)

echo.
echo Found %count% available updates
echo.
echo Enter package numbers (e.g., 1 2 3) or 'all' for all packages:
set /p selection="Selection: "

if /i "%selection%"=="all" goto UPDATE_ALL_SELECTED
if "%selection%"=="" goto MAIN_MENU

echo.
echo Processing selected updates...
echo ====================================================

call :PROCESS_SELECTION "%selection%"

echo ====================================================
echo Selected updates completed!
echo.
pause
goto MAIN_MENU

:UPDATE_ALL_SELECTED
echo Updating all %count% packages...
echo ====================================================
for /l %%i in (1,1,%count%) do (
    echo [%%i/%count%] Updating !pkg_name[%%i]!...
    winget upgrade --id "!pkg_id[%%i]!" --accept-package-agreements --accept-source-agreements
    if !errorLevel! equ 0 (
        echo ✓ !pkg_name[%%i]! updated successfully
    ) else (
        echo ✗ Failed to update !pkg_name[%%i]!
    )
    echo.
)
echo All selected updates completed!
echo.
pause
goto MAIN_MENU

:PROCESS_SELECTION
set "input=%~1"
for %%i in (%input%) do (
    if %%i gtr 0 if %%i leq %count% (
        echo Updating !pkg_name[%%i]!...
        winget upgrade --id "!pkg_id[%%i]!" --accept-package-agreements --accept-source-agreements
        if !errorLevel! equ 0 (
            echo ✓ !pkg_name[%%i]! updated successfully
        ) else (
            echo ✗ Failed to update !pkg_name[%%i]!
        )
        echo.
    ) else (
        echo Invalid selection: %%i
    )
)
goto :eof

:UPDATE_SINGLE
set num=%1
if %num% gtr 0 if %num% leq %count% (
    echo Updating !pkg_name[%num%]!...
    winget upgrade --id "!pkg_id[%num%]!" --accept-package-agreements --accept-source-agreements
    echo.
) else (
    echo Invalid selection: %num%
)
goto :eof

:EXIT
cls
echo.
echo Thank you for using WinDel Package Manager!
echo.
timeout /t 3 >nul
exit /b 0