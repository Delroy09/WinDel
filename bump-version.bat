@echo off
setlocal enabledelayedexpansion

echo WinDel Version Management Tool
echo ==============================
echo.

echo Current version in windel.bat:
findstr "Secure Package Update Manager" windel.bat

echo.
set /p new_version="Enter new version (e.g., 1.3.0): "
if "%new_version%"=="" (
    echo Error: Version cannot be empty
    pause
    exit /b 1
)

echo.
echo Updating to version %new_version%...

REM Update version in main script (two locations)
powershell -Command "(Get-Content windel.bat) -replace 'Secure Package Update Manager v[\d\.]+', 'Secure Package Update Manager v%new_version%' | Set-Content windel.bat"
powershell -Command "(Get-Content windel.bat) -replace 'WinDel Package Manager v[\d\.]+', 'WinDel Package Manager v%new_version%' | Set-Content windel.bat"

REM Create new changelog entry if CHANGELOG.md exists
if exist CHANGELOG.md (
    powershell -Command "$content = Get-Content CHANGELOG.md; $newContent = @(); $inserted = $false; foreach($line in $content) { if($line -match '## \[Unreleased\]' -and -not $inserted) { $newContent += $line; $newContent += ''; $newContent += '### Added'; $newContent += '- New features'; $newContent += ''; $newContent += '### Changed'; $newContent += '- Changes in existing functionality'; $newContent += ''; $newContent += '### Fixed'; $newContent += '- Bug fixes'; $newContent += ''; $newContent += '## [%new_version%] - ' + (Get-Date -Format 'yyyy-MM-dd'); $newContent += ''; $inserted = $true } else { $newContent += $line } }; $newContent | Set-Content CHANGELOG.md"
)

echo ✓ Version updated to %new_version%
echo.
echo Next steps:
echo 1. Update CHANGELOG.md with actual changes for v%new_version%
echo 2. Commit: git add . ^&^& git commit -m "Release v%new_version%"
echo 3. Tag: git tag v%new_version%
echo 4. Push: git push origin main --tags
echo.
echo The GitHub Action will automatically create the release!
pause