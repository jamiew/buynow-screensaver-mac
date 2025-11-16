#!/bin/bash
set -e

SCREENSAVER_NAME="BuyNow"
BUNDLE_DIR="${SCREENSAVER_NAME}.saver"
INSTALL_DIR="${HOME}/Library/Screen Savers"

# Check if bundle exists
if [ ! -d "${BUNDLE_DIR}" ]; then
    echo "Error: ${BUNDLE_DIR} not found. Run ./build.sh first."
    exit 1
fi

# Create Screen Savers directory if it doesn't exist
mkdir -p "${INSTALL_DIR}"

# Remove old version if it exists
if [ -d "${INSTALL_DIR}/${BUNDLE_DIR}" ]; then
    echo "Removing old version..."
    rm -rf "${INSTALL_DIR}/${BUNDLE_DIR}"
fi

# Install the screensaver
echo "Installing ${SCREENSAVER_NAME} screensaver..."
cp -R "${BUNDLE_DIR}" "${INSTALL_DIR}/"

echo "✓ Installed to ${INSTALL_DIR}/${BUNDLE_DIR}"
echo ""
echo "Next steps:"
echo "  1. Open System Settings > Screen Saver"
echo "  2. Select 'Buy Now' from the list"
echo "  3. Click 'Preview' to test it"
echo ""
echo "Note: If you don't see it, try logging out and back in."
