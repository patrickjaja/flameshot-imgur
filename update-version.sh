#!/bin/bash
# Script to manually update package version

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔄 Checking for Flameshot updates..."

# Get current version from PKGBUILD
CURRENT_VERSION=$(grep "^pkgver=" PKGBUILD | cut -d'=' -f2)
echo -e "${YELLOW}Current version:${NC} $CURRENT_VERSION"

# Get latest version from GitHub
LATEST_VERSION=$(curl -s https://api.github.com/repos/flameshot-org/flameshot/releases/latest | jq -r '.tag_name' | sed 's/^v//')
echo -e "${YELLOW}Latest version:${NC} $LATEST_VERSION"

# Check if update is needed
if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo -e "${GREEN}✓ Package is already up to date!${NC}"
    exit 0
fi

echo -e "${YELLOW}📦 Updating package from $CURRENT_VERSION to $LATEST_VERSION${NC}"

# Update PKGBUILD version
sed -i "s/^pkgver=.*/pkgver=$LATEST_VERSION/" PKGBUILD

# Reset pkgrel to 1 for new version
sed -i "s/^pkgrel=.*/pkgrel=1/" PKGBUILD

# Download tarball and calculate SHA256
echo "⬇️  Downloading source tarball..."
wget -q "https://github.com/flameshot-org/flameshot/archive/v${LATEST_VERSION}.tar.gz"
SHA256=$(sha256sum "v${LATEST_VERSION}.tar.gz" | cut -d' ' -f1)
rm "v${LATEST_VERSION}.tar.gz"

# Update SHA256 in PKGBUILD
sed -i "s/^sha256sums=.*/sha256sums=('${SHA256}')/" PKGBUILD

echo "📝 Generating .SRCINFO..."
makepkg --printsrcinfo > .SRCINFO

echo -e "${GREEN}✓ Package updated successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Test the build: makepkg -si"
echo "2. Commit changes: git add -A && git commit -m \"Update to version $LATEST_VERSION\""
echo "3. Push to GitHub: git push origin main"
echo "4. Push to AUR: git push aur main:master"