# BUY NOW Screensaver

A macOS recreation of the classic **BUY NOW** screensaver by [Ficus Kirkpatrick](http://toastycode.com/besavers/) for BeOS.

Original screensaver from the BeOS screensaver collection. This is a tribute to [BeOS](https://en.wikipedia.org/wiki/BeOS), the multithreaded operating system developed by Be Inc. in the 1990s.

## Features

- Dark blue background with white "BUY NOW" text
- Flashes on/off every second
- Native macOS screensaver (.saver bundle)

## Installation

### Option 1: Screensaver Only (Lightweight)

For users who just want the screensaver:

```bash
./build.sh
./install.sh
```

Then:
1. Open System Settings > Screen Saver
2. Select "BuyNow" from the list
3. Enjoy!

### Option 2: Mac App (Easy Install/Uninstall)

For a friendlier installation experience with a GUI:

```bash
./build-app.sh
open "BuyNow Screensaver.app"
```

The app provides:
- One-click install/uninstall
- Live preview of the screensaver
- Direct link to System Settings

## Distribution

### For GitHub Releases

```bash
# Build everything
./build.sh
./build-app.sh
./package-app.sh
```

This creates:
- `BuyNow-screensaver.zip` - Screensaver only (13KB)
- `BuyNow-App.zip` - Mac app wrapper
- `BuyNow-Screensaver-Installer.dmg` - Installer disk image

### For Mac App Store

The app in `BuyNowApp/` can be submitted to the Mac App Store:
1. Add proper code signing
2. Add app icon assets
3. Submit via Xcode or `xcrun altool`

See [Mac App Store submission guide](https://developer.apple.com/app-store/submitting/) for details.

## Credits

Original screensaver by [Ficus Kirkpatrick](http://toastycode.com/besavers/) for BeOS.

## Video Version

A video version (`buy-now.mp4`) is also included for use with video-based screensavers or just for vibes.

### Regenerating the Video

To create a new version with different duration or settings:

```bash
ffmpeg -f lavfi -i color=c=0x00008B:s=1920x1080:d=10 \
  -vf "drawtext=text='BUY':fontcolor=white:fontsize=180:font='Arial Bold':x=(w-text_w)/2:y=(h-text_h)/2-100:enable='mod(floor(t),2)',\
       drawtext=text='NOW':fontcolor=white:fontsize=180:font='Arial Bold':x=(w-text_w)/2:y=(h-text_h)/2+100:enable='mod(floor(t),2)'" \
  -c:v libx264 -pix_fmt yuv420p -r 30 -y buy-now.mp4
```

Parameters:
- `d=10` - duration in seconds
- `s=1920x1080` - resolution
- `c=0x00008B` - dark blue color (matching BeOS original)
- `fontsize=180` - text size
- Two-line layout with "BUY" and "NOW" stacked
- `enable='mod(floor(t),2)'` - flashing logic (on during even seconds, off during odd)
