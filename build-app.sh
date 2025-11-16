#!/bin/bash
set -e

APP_NAME="Buy Now Screensaver"
APP_BUNDLE="Buy Now Screensaver.app"
SCREENSAVER_NAME="BuyNow"

echo "Building ${APP_NAME}..."

# First build the screensaver
./build.sh

# Clean previous app build
rm -rf "${APP_BUNDLE}"

# Create app bundle structure
mkdir -p "${APP_BUNDLE}/Contents/MacOS"
mkdir -p "${APP_BUNDLE}/Contents/Resources"

# Compile the app
echo "Compiling app..."
swiftc -o "${APP_BUNDLE}/Contents/MacOS/BuyNowApp" \
    -framework SwiftUI \
    -framework Cocoa \
    -framework ScreenSaver \
    BuyNowApp/BuyNowApp.swift \
    BuyNowApp/ContentView.swift

# Copy Info.plist
cp BuyNowApp/Info.plist "${APP_BUNDLE}/Contents/Info.plist"

# Embed the screensaver bundle
echo "Embedding screensaver..."
cp -R "${SCREENSAVER_NAME}.saver" "${APP_BUNDLE}/Contents/Resources/"

echo "✓ App build complete: ${APP_BUNDLE}"
echo ""
echo "To test:"
echo "  open \"${APP_BUNDLE}\""
echo ""
echo "To create distributable:"
echo "  ./package-app.sh"
