# WinDel Remote Execution - Run without installation
# Usage: iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/yourusername/windel/main/windel-remote.ps1'))

Write-Host "🚀 WinDel Package Manager - Remote Execution" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Create temporary directory
$temp_dir = "$env:TEMP\WinDel_" + (Get-Random)
New-Item -ItemType Directory -Path $temp_dir -Force | Out-Null

# Download and execute
try {
    Write-Host "📥 Downloading latest WinDel..." -ForegroundColor Green
    $windel_url = "https://raw.githubusercontent.com/Delroy09/WinDel/main/windel.bat"
    $windel_path = "$temp_dir\windel.bat"
    
    Invoke-WebRequest -Uri $windel_url -OutFile $windel_path
    
    Write-Host "▶️ Starting WinDel..." -ForegroundColor Green
    Set-Location $temp_dir
    & cmd.exe /c "`"$windel_path`""
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # Cleanup
    Set-Location $env:USERPROFILE
    if (Test-Path $temp_dir) {
        Remove-Item -Path $temp_dir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "🧹 Temporary files cleaned up" -ForegroundColor Gray