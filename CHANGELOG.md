# Changelog

All notable changes to WinDel Package Manager will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- New features in development

### Changed

- Changes in existing functionality

### Fixed

- Bug fixes

## [1.2.3] - 2025-08-26

### Fixed

- 🔧 **Update Installation Issues**: Removed `--silent` flag that was preventing actual package installations
- 🔍 **Better Verification**: Added post-update verification to confirm packages were actually updated
- 📊 **Enhanced Error Reporting**: Improved error codes and exit status handling for failed updates
- 🛠️ **Debug Information**: Added detailed debug output to track WinGet commands

### Added

- 🔧 **Troubleshooting Mode**: New option 4 to diagnose WinGet configuration issues
- ✅ **Update Verification**: Automatic post-update scan to verify successful installations
- 📋 **Exit Code Analysis**: Detailed reporting of specific WinGet error codes

### Changed

- ⚡ **More Reliable Updates**: WinGet commands now use proper flags for actual installations
- 🎯 **Better User Feedback**: Clear indication when updates succeed or fail

## [1.2.2] - 2025-08-26

### Fixed

- 🐛 **Admin Console Display**: Fixed distorted Unicode characters in administrator mode
- 📊 **Table Formatting**: Replaced Unicode box-drawing characters with ASCII for better compatibility
- 🎨 **Progress Bars**: Simplified progress indicators for consistent display across all privilege levels
- 🖥️ **Console Compatibility**: Enhanced Windows 10+ console support with ANSI escape sequences

### Changed

- 🔧 **Better Admin Support**: Improved visual consistency when running as administrator
- 📋 **Table Layout**: More reliable table formatting using standard ASCII characters

## [1.2.1] - 2025-08-26

### Added

- 🚀 **One-Line Installation**: PowerShell one-liner installation like popular scripts
- 📦 **Remote Execution**: Run WinDel without any local installation
- 🔧 **Multiple Install Options**: Portable, System-wide, Custom path installations
- 🤖 **Automated Releases**: GitHub Actions automatically create releases on commits
- 📋 **Professional Documentation**: Comprehensive README with installation methods
- 🎯 **Installation Scripts**: Dedicated `install.ps1` and `windel-remote.ps1` scripts

### Changed

- 🎨 **Enhanced README**: Professional documentation with badges and installation options
- 🔄 **Automated Workflows**: GitHub Actions for automatic release management
- 📊 **Better Release Assets**: Multiple download options for different use cases

### Fixed

- 🐛 **GitHub Integration**: Proper automated release creation and asset uploads
- 📝 **Documentation**: Comprehensive troubleshooting and usage examples

## [1.2.0] - 2025-08-26

### Added

- 🛡️ **Security Hardening**: PATH variable protection against injection attacks
- 🔒 **Enhanced Integrity Validation**: 4-step WinGet verification process
- ⚡ **Command Injection Prevention**: Added `--disable-interactivity` to all WinGet operations
- 🧹 **Input Sanitization**: Comprehensive filtering of dangerous characters (&, |, >, <, ;)
- 🛡️ **Source Security**: Enhanced package source validation and updates
- ✨ **Visual Progress Indicators**: Unicode symbols for better user feedback (✓, ⚠, ✗, 🔍, ⚡)
- 🎯 **Smart Timeout System**: Automatic timeouts replacing manual pauses
- 📊 **Professional Table Layout**: Enhanced interactive package selection display
- 🔧 **Improved WinGet Detection**: Better handling of alternative installation locations

### Changed

- 🎨 **Streamlined Interface**: Cleaner menu with better visual hierarchy
- ⏱️ **Improved Flow**: Default timeouts for smoother user experience
- 📝 **Cleaner Output**: Reduced verbosity while maintaining informativeness
- 🎯 **Better Defaults**: Made "Check for updates" the default option (ENTER key)
- 🔄 **Enhanced Reliability**: Improved WinGet path detection and fallback mechanisms

### Security

- 🛡️ **Production-Grade Security**: Multiple layers of protection against common attacks
- 🔒 **Enterprise-Ready**: Secure for corporate environments
- ✅ **Tamper-Resistant**: Integrity validation prevents malicious modifications

### Fixed

- 🐛 **WinGet Detection**: Fixed issues with WinGet not being found when installed via Microsoft Store
- 🔄 **Path Resolution**: Improved PATH handling for different WinGet installation methods
- 📱 **Package Names**: Enhanced handling of packages with spaces in names
- 🐛 **Selection Parsing**: Improved handling of ranges and comma-separated values

## [1.1.0] - 2025-08-26

### Added

- ✨ Visual progress indicators with Unicode symbols
- 🎯 Smart timeout system replacing manual pauses
- 📊 Enhanced interactive table layout for package selection
- ⚡ Quick selection shortcuts ([a]ll, ranges like 1-5, comma-separated)
- 🔧 Automatic WinGet installation if missing
- 🛡️ Improved error handling with auto-recovery

### Changed

- 🎨 Streamlined menu interface with better visual hierarchy
- ⏱️ Default timeouts for smoother user flow
- 📝 Cleaner output messages with reduced verbosity
- 🎯 Made "Check for updates" the default option

### Fixed

- 🐛 Package selection parsing for ranges and comma-separated values
- 🔄 Source refresh reliability on startup
- 📱 Better handling of packages with spaces in names

### Removed

- ❌ Excessive confirmation dialogs
- 📜 Verbose explanatory text that cluttered interface
- ⏸️ Unnecessary pause commands interrupting workflow

## [1.0.0] - 2025-08-25

### Added

- 🎉 Initial release of WinDel Package Manager
- 🔍 Package update scanning functionality
- ⚡ Bulk update capability for all packages
- ✅ Interactive selection for specific package updates
- 🛡️ Administrator privilege detection and handling
- 🎨 ASCII art branding and professional interface
- 🔐 Security-focused design with source verification

### Security

- 🛡️ Implemented secure package source verification
- 🔒 Administrator privilege checking for system safety
- ✅ Package agreement acceptance handling

---

## Version Links

- [Latest Release](https://github.com/Delroy09/WinDel/releases/latest)
- [All Releases](https://github.com/Delroy09/WinDel/releases)
- [v1.2.0](https://github.com/Delroy09/WinDel/releases/tag/v1.2.0)
- [v1.1.0](https://github.com/Delroy09/WinDel/releases/tag/v1.1.0)
- [v1.0.0](https://github.com/Delroy09/WinDel/releases/tag/v1.0.0)
