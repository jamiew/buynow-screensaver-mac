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

# Create thumbnail if it doesn't exist
if [ ! -f thumbnail.png ]; then
    echo "Creating thumbnail..."
    swift - << 'SWIFT'
import Cocoa

let width = 320
let height = 240

let image = NSImage(size: NSSize(width: width, height: height))
image.lockFocus()

let backgroundColor = NSColor(red: 0.0, green: 0.0, blue: 0.545, alpha: 1.0)
backgroundColor.setFill()
NSRect(x: 0, y: 0, width: width, height: height).fill()

let attributes: [NSAttributedString.Key: Any] = [
    .font: NSFont.boldSystemFont(ofSize: 60),
    .foregroundColor: NSColor.white
]

let buyText = NSAttributedString(string: "BUY", attributes: attributes)
let nowText = NSAttributedString(string: "NOW", attributes: attributes)

let buySize = buyText.size()
let nowSize = nowText.size()

buyText.draw(at: NSPoint(x: (CGFloat(width) - buySize.width) / 2,
                         y: CGFloat(height) / 2 + 20))
nowText.draw(at: NSPoint(x: (CGFloat(width) - nowSize.width) / 2,
                         y: CGFloat(height) / 2 - 70))

image.unlockFocus()

if let tiffData = image.tiffRepresentation,
   let bitmapImage = NSBitmapImageRep(data: tiffData),
   let pngData = bitmapImage.representation(using: .png, properties: [:]) {
    try? pngData.write(to: URL(fileURLWithPath: "thumbnail.png"))
}
SWIFT
fi

# Copy thumbnail
cp thumbnail.png "${RESOURCES_DIR}/thumbnail.png"

echo "✓ Build complete: ${BUNDLE_DIR}"
echo ""
echo "To install:"
echo "  ./install.sh"
echo ""
echo "Or manually:"
echo "  cp -R ${BUNDLE_DIR} ~/Library/Screen\\ Savers/"
echo "  Then open System Settings > Screen Saver"
