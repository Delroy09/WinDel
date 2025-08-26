# WinDel Package Manager 🚀

**Secure, Fast & Simple Windows Package Update Manager**

[![Latest Release](https://img.shields.io/github/v/release/Delroy09/WinDel?style=for-the-badge&logo=github)](https://github.com/Delroy09/WinDel/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/Delroy09/WinDel/total?style=for-the-badge&logo=github)](https://github.com/Delroy09/WinDel/releases)
[![License](https://img.shields.io/github/license/Delroy09/WinDel?style=for-the-badge)](LICENSE)

WinDel is a lightweight, secure Windows package manager that simplifies updating your installed applications using WinGet. Built with security-first principles and enterprise-grade reliability.

## ⚡ Quick Installation

### One-Line Install (Recommended)

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Delroy09/WinDel/main/install.ps1'))
```

### Alternative Installation Methods

**System-Wide (Admin Required)**

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Delroy09/WinDel/main/install.ps1')) -System
```

**Portable (Desktop)**

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Delroy09/WinDel/main/install.ps1')) -Portable
```

**Run Once (No Installation)**

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Delroy09/WinDel/main/windel-remote.ps1'))
```

**Manual Download**

```cmd
curl -o windel.bat https://raw.githubusercontent.com/Delroy09/WinDel/main/windel.bat && windel.bat
```

## 🎯 Features

- ✅ **Secure by Design** - Multiple security layers and input validation
- ⚡ **Lightning Fast** - Optimized for speed and minimal resource usage
- 🎨 **Beautiful Interface** - Modern UI with progress indicators and emoji
- 🔧 **Auto-Detection** - Intelligent WinGet discovery and installation
- 📊 **Interactive Selection** - Choose exactly which packages to update
- 🛡️ **Enterprise Ready** - Admin privilege handling and audit trails
- 🚀 **One-Click Updates** - Update all packages with a single command
- 📱 **Minimal Dependencies** - Just WinGet and Windows built-ins

## 🖥️ Screenshots

```
██╗    ██╗██╗███╗   ██╗
██║    ██║██║████╗  ██║
██║ █╗ ██║██║██╔██╗ ██║
██║███╗██║██║██║╚██╗██║
╚███╔███╔╝██║██║ ╚████║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝

██████╗ ███████╗██╗
██╔══██╗██╔════╝██║
██║  ██║█████╗  ██║
██║  ██║██╔══╝  ██║
██████╔╝███████╗███████╗
╚═════╝ ╚══════╝╚══════╝

    1. 🔍 Check for updates [ENTER]
    2. ⚡ Update all packages
    3. ✅ Choose which to update
    0. ❌ Exit
```

## 🚀 Usage

### Interactive Mode

Run WinDel and follow the menu:

1. **Check for updates** - Scan for available package updates
2. **Update all packages** - Automatically update everything
3. **Choose which to update** - Interactive selection with ranges (1-5, 1,3,5)

### Command Examples

```bash
# Quick scan
windel.bat

# Direct execution
.\windel.bat

# From installed location
windel
```

## 🛡️ Security Features

- **PATH Protection** - Prevents variable injection attacks
- **Input Sanitization** - Filters dangerous characters and commands
- **Source Verification** - Validates package sources before operations
- **Admin Detection** - Properly handles elevated privileges
- **Integrity Checks** - Verifies WinGet functionality before use
- **Secure Defaults** - All operations use safe, non-interactive modes

## 🎯 System Requirements

- Windows 10 (1809+) or Windows 11
- PowerShell 5.1+ (for installation)
- WinGet (auto-installed if missing)
- Administrator rights (optional, for system-wide updates)

## 📋 Troubleshooting

### PowerShell Execution Policy

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### WinGet Not Found

WinDel automatically detects and installs WinGet if missing. If manual installation is needed:

```powershell
# Install from Microsoft Store
ms-windows-store://pdp/?productid=9NBLGGH4NNS1
```

### Network Issues

```cmd
# Use curl instead
curl -L -o windel.bat https://github.com/Delroy09/WinDel/releases/latest/download/windel.bat
```

## 🔄 Updates

WinDel automatically checks for updates to itself. To manually update:

```powershell
# Re-run the installer
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Delroy09/WinDel/main/install.ps1'))
```

## 📈 Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and release notes.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

- 📋 [Issues](https://github.com/Delroy09/WinDel/issues) - Bug reports and feature requests
- 💬 [Discussions](https://github.com/Delroy09/WinDel/discussions) - Questions and community
- 📧 [Email](mailto:your-email@example.com) - Direct contact

## ⭐ Star History

If you find WinDel useful, please consider giving it a star! ⭐

---

**Made with ❤️ for the Windows community**
