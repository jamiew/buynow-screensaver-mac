#!/bin/bash
set -e

APP_BUNDLE="BuyNow Screensaver.app"
DMG_NAME="BuyNow-Screensaver-Installer.dmg"
ZIP_NAME="BuyNow-App.zip"

if [ ! -d "${APP_BUNDLE}" ]; then
    echo "Error: ${APP_BUNDLE} not found. Run ./build-app.sh first."
    exit 1
fi

echo "Packaging ${APP_BUNDLE}..."

# Create a zip for simple distribution
rm -f "${ZIP_NAME}"
ditto -c -k --sequesterRsrc --keepParent "${APP_BUNDLE}" "${ZIP_NAME}"

echo "✓ Created ${ZIP_NAME}"

# Optionally create a DMG (requires hdiutil)
echo "Creating DMG installer..."
rm -f "${DMG_NAME}"
hdiutil create -volname "BuyNow Screensaver" \
    -srcfolder "${APP_BUNDLE}" \
    -ov -format UDZO \
    "${DMG_NAME}"

echo "✓ Created ${DMG_NAME}"
echo ""
echo "Distribution files ready:"
echo "  - ${ZIP_NAME} (simple download)"
echo "  - ${DMG_NAME} (Mac installer)"
echo "  - BuyNow-screensaver.zip (screensaver only)"
