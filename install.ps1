# WinDel Package Manager - Remote Installation Script
param(
    [switch]$Portable,
    [switch]$System,
    [string]$Path
)

Write-Host "🚀 WinDel Package Manager Installer" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Security check
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator") -and $System) {
    Write-Host "❌ Administrator privileges required for system installation" -ForegroundColor Red
    Write-Host "💡 Run PowerShell as Administrator or use -Portable flag" -ForegroundColor Yellow
    exit 1
}

# Download latest WinDel script
$windel_url = "https://raw.githubusercontent.com/yourusername/windel/main/windel.bat"
Write-Host "📥 Downloading latest WinDel..." -ForegroundColor Green

try {
    # Determine installation path
    if ($Portable) {
        $install_path = "$env:USERPROFILE\Desktop\windel.bat"
        Write-Host "🏠 Installing to Desktop (Portable)" -ForegroundColor Yellow
    }
    elseif ($System) {
        $install_dir = "$env:ProgramFiles\WinDel"
        $install_path = "$install_dir\windel.bat"
        if (-not (Test-Path $install_dir)) {
            New-Item -ItemType Directory -Path $install_dir -Force | Out-Null
        }
        Write-Host "🏢 Installing to Program Files (System-wide)" -ForegroundColor Yellow
    }
    elseif ($Path) {
        $install_path = $Path
        Write-Host "📂 Installing to custom path: $Path" -ForegroundColor Yellow
    }
    else {
        $install_path = "$env:USERPROFILE\AppData\Local\WinDel\windel.bat"
        $install_dir = Split-Path $install_path
        if (-not (Test-Path $install_dir)) {
            New-Item -ItemType Directory -Path $install_dir -Force | Out-Null
        }
        Write-Host "👤 Installing to User AppData" -ForegroundColor Yellow
    }

    # Install the script
    Invoke-WebRequest -Uri $windel_url -OutFile $install_path
    Write-Host "✅ WinDel installed successfully!" -ForegroundColor Green
    Write-Host "📍 Location: $install_path" -ForegroundColor Gray

    # Add to PATH if system installation
    if ($System) {
        $env:PATH += ";$env:ProgramFiles\WinDel"
        [Environment]::SetEnvironmentVariable("PATH", $env:PATH, [EnvironmentVariableTarget]::Machine)
        Write-Host "🔗 Added to system PATH" -ForegroundColor Green
        Write-Host "💻 You can now run 'windel' from anywhere!" -ForegroundColor Cyan
    }

    # Create shortcuts
    if ($System -or (-not $Portable)) {
        $shortcut_path = "$env:USERPROFILE\Desktop\WinDel.lnk"
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut($shortcut_path)
        $shortcut.TargetPath = $install_path
        $shortcut.WorkingDirectory = Split-Path $install_path
        $shortcut.Description = "WinDel Package Manager"
        $shortcut.Save()
        Write-Host "🔗 Desktop shortcut created" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "🎉 Installation Complete!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "📋 Usage Options:" -ForegroundColor White
    if ($System) {
        Write-Host "   • Type 'windel' in any command prompt" -ForegroundColor Gray
    }
    Write-Host "   • Double-click desktop shortcut" -ForegroundColor Gray
    Write-Host "   • Run directly: $install_path" -ForegroundColor Gray
    Write-Host ""
    Write-Host "🔄 To update: Re-run this installer" -ForegroundColor Yellow
    Write-Host "❌ To uninstall: Delete $install_path" -ForegroundColor Yellow

}
catch {
    Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}