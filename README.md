# flameshot-imgur

[![Auto Update Package](https://github.com/patrickjaja/flameshot-imgur/actions/workflows/update-package.yml/badge.svg)](https://github.com/patrickjaja/flameshot-imgur/actions/workflows/update-package.yml)
[![Test Package Build](https://github.com/patrickjaja/flameshot-imgur/actions/workflows/test-build.yml/badge.svg)](https://github.com/patrickjaja/flameshot-imgur/actions/workflows/test-build.yml)
[![AUR version](https://img.shields.io/aur/version/flameshot-imgur)](https://aur.archlinux.org/packages/flameshot-imgur)

**Flameshot screenshot software with Imgur upload support enabled** - Stable release version

## 🚀 Features

- **Imgur Upload Enabled**: Built with `-DENABLE_IMGUR=ON` flag
- **Stable Releases**: Tracks official Flameshot releases (not development commits)
- **Auto-Updates**: Automatically updates daily via GitHub Actions
- **AUR Integration**: Pushes updates to AUR automatically

## 📦 Installation

### Using AUR Helper

```bash
# With yay
yay -S flameshot-imgur

# With paru  
paru -S flameshot-imgur
```

### Manual Installation

```bash
git clone https://github.com/patrickjaja/flameshot-imgur.git
cd flameshot-imgur
makepkg -si
```

## 🔄 Automatic Updates

This package is **fully automated** with nightly builds:
- **Daily at 3 AM UTC**: GitHub Actions checks for new Flameshot releases
- **When a new version is detected**:
  - PKGBUILD is updated with the latest version and checksums
  - Changes are committed to the main branch
  - A separate clone pushes only PKGBUILD/.SRCINFO to AUR (avoiding subdirectory issues)
  - A GitHub release is created for tracking
- **Users receive updates** through their AUR helpers automatically within 24 hours

## 📊 Package Comparison

| Feature | `flameshot` (official) | `flameshot-imgur` (this) | `flameshot-imgur-git` |
|---------|------------------------|--------------------------|----------------------|
| Imgur Upload | ❌ | ✅ | ✅ |
| Version | Stable releases | Stable releases | Git commits |
| Auto-updates | Manual | Automated daily | N/A |
| Source | Arch repos | AUR | AUR |

## 🛠️ Manual Update

If you need to manually trigger an update:

```bash
# Using the provided script
./update-version.sh

# Or trigger GitHub Action manually
# Go to Actions tab -> "Auto Update Package" -> Run workflow
```

## 🔧 Development

### Repository Structure

```
flameshot-imgur/
├── .github/
│   └── workflows/
│       ├── update-package.yml    # Daily auto-update workflow (3 AM UTC)
│       └── test-build.yml        # Build testing on push
├── PKGBUILD                       # Arch package build script
├── .SRCINFO                       # AUR metadata (auto-generated)
├── update-version.sh              # Manual update script
├── .gitignore
└── README.md                      # This file
```

The GitHub Action handles AUR's "no subdirectories" requirement by cloning AUR separately and copying only PKGBUILD/.SRCINFO files.

## 📝 Using Imgur Upload

Once installed, use Imgur upload in Flameshot:
1. Take a screenshot with Flameshot
2. Click the cloud upload button (☁️) in the toolbar
3. Image uploads to Imgur and URL copies to clipboard

## 🔗 Links

- **Upstream**: [flameshot-org/flameshot](https://github.com/flameshot-org/flameshot)
- **AUR Package**: [flameshot-imgur](https://aur.archlinux.org/packages/flameshot-imgur)
- **Git Version**: [flameshot-imgur-git](https://aur.archlinux.org/packages/flameshot-imgur-git)

## 📄 License

GPL-3.0-or-later (same as Flameshot)

## 🤝 Contributing

Issues and pull requests are welcome! The package updates automatically, but improvements to the build process or automation are appreciated.

## ⚠️ Conflicts

This package conflicts with:
- `flameshot` (official Arch package)
- `flameshot-git` (development version)
- `flameshot-imgur-git` (git version with Imgur)

Uninstall any existing Flameshot packages before installing this one.