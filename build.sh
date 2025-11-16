#!/bin/bash
set -e

SCREENSAVER_NAME="BuyNow"
BUNDLE_DIR="${SCREENSAVER_NAME}.saver"
CONTENTS_DIR="${BUNDLE_DIR}/Contents"
MACOS_DIR="${CONTENTS_DIR}/MacOS"
RESOURCES_DIR="${CONTENTS_DIR}/Resources"

echo "Building ${SCREENSAVER_NAME} screensaver..."

# Clean previous build
rm -rf "${BUNDLE_DIR}"

# Create bundle directory structure
mkdir -p "${MACOS_DIR}"
mkdir -p "${RESOURCES_DIR}"

# Compile the Swift code
echo "Compiling Swift code..."
swiftc -emit-library \
    -o "${MACOS_DIR}/${SCREENSAVER_NAME}" \
    -module-name "${SCREENSAVER_NAME}" \
    -framework ScreenSaver \
    -framework Cocoa \
    BuyNowView.swift

# Copy Info.plist
echo "Copying Info.plist..."
cp Info.plist "${CONTENTS_DIR}/Info.plist"

echo "✓ Build complete: ${BUNDLE_DIR}"
echo ""
echo "To install:"
echo "  ./install.sh"
echo ""
echo "Or manually:"
echo "  cp -R ${BUNDLE_DIR} ~/Library/Screen\\ Savers/"
echo "  Then open System Settings > Screen Saver"
