# WinDel Package Manager 🚀

**Simple, Fast & Reliable Windows Package Update Manager**

[![Latest Release](https://img.shields.io/github/v/release/Delroy09/WinDel?style=for-the-badge&logo=github)](https://github.com/Delroy09/WinDel/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/Delroy09/WinDel/total?style=for-the-badge&logo=github)](https://github.com/Delroy09/WinDel/releases)
[![License](https://img.shields.io/github/license/Delroy09/WinDel?style=for-the-badge)](LICENSE)

WinDel is a lightweight Windows package manager that simplifies updating your installed applications using WinGet. Clean interface, reliable updates, works in both elevated and non-elevated states.

## ⚡ Quick Start

### Download & Run

```cmd
# Download the script
curl -o windel.bat https://raw.githubusercontent.com/Delroy09/WinDel/main/windel.bat

# Or using PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Delroy09/WinDel/main/windel.bat" -OutFile "windel.bat"

# Run it
windel.bat
```

### Or Direct Download

[Download windel.bat](https://github.com/Delroy09/WinDel/releases/latest/download/windel.bat) and double-click to run.

## 🎯 Features

- ✅ **Simple & Clean** - No complex installation, just download and run
- ⚡ **Fast Updates** - Efficiently scans and updates packages using WinGet
- 🎨 **User-Friendly** - Clear menu system with numbered options
- 🔧 **Smart Detection** - Automatically finds and validates WinGet installation
- 📊 **Interactive Selection** - Choose exactly which packages to update
- 🛡️ **Works Everywhere** - Functions in both elevated and standard user modes
- 🚀 **Seamless Flow** - Check updates and install them in one smooth workflow
- 📱 **Zero Dependencies** - Only requires WinGet (auto-detected)

## 🖥️ Interface

```
========================================
     WinDel Package Manager v1.3
========================================

WinDel Package Manager v1.3
====================================================

    1. Check for updates
    2. Update all packages
    3. Choose which to update
    4. Exit

====================================================
Choice (default=1):
```

## 🚀 Usage

### Main Menu Options

1. **Check for updates** - Scans for available updates and offers installation options
2. **Update all packages** - Updates everything with confirmation
3. **Choose which to update** - Interactive selection with clean numbered list
4. **Exit** - Clean exit

### Update Flow

- **Check updates** → View available updates → Choose to install all/some/none
- **Select packages** → Enter numbers (e.g., `1 2 3`) or `all`
- **Automatic installation** → Progress feedback with success/failure indicators

## 🛡️ System Requirements

- Windows 10 (1809+) or Windows 11
- WinGet (Microsoft App Installer) - auto-detected
- Command Prompt or PowerShell
- Internet connection for package updates

## 🔧 How It Works

1. **WinGet Detection** - Verifies WinGet is installed and accessible
2. **Package Scanning** - Uses `winget upgrade` to find available updates
3. **Clean Filtering** - Removes unknown/problematic packages from display
4. **Smart Updates** - Uses package IDs for reliable installation
5. **Status Feedback** - Shows success (✓) or failure (✗) for each update

## 📋 Troubleshooting

### WinGet Not Found

- Install from Microsoft Store: "App Installer"
- Or download from: https://github.com/microsoft/winget-cli/releases

### No Updates Showing

- Run `winget upgrade` manually to verify WinGet is working
- Check if you have any installed packages from WinGet sources

### Permission Issues

- Some packages may require elevation (WinGet will prompt automatically)
- Run as Administrator for system-wide package updates

## ✨ What's New in v1.3

- 🔄 **Improved Update Flow** - Check updates → immediate install options
- 🧹 **Clean Package Display** - Filtered unknown packages for better UX
- ✅ **Better Feedback** - Success/failure indicators for each update
- 🎯 **Enhanced Parsing** - More reliable package list processing
- 🛡️ **Robust Error Handling** - Graceful handling of various scenarios

## 📈 Changelog

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## 🤝 Contributing

1. Fork the repository
2. Make your improvements to `windel.bat`
3. Test thoroughly in different environments
4. Submit a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

- 📋 [Issues](https://github.com/Delroy09/WinDel/issues) - Bug reports and feature requests
- 💬 [Discussions](https://github.com/Delroy09/WinDel/discussions) - Questions and community

---

**Simple tools for better Windows package management** ⚡
