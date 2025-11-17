# BUY NOW Screensaver

A macOS recreation of the classic **BUY NOW** screensaver by [Ficus Kirkpatrick](http://toastycode.com/besavers/) for BeOS.

It has a dark blue background and white text.


![Screenshot](screenshot.gif)

This is a tribute to [BeOS](https://en.wikipedia.org/wiki/BeOS), the pervasively multithreaded operating system from the 1990s.
p
It is a wonderful piece of computing history.

## Installation

### Download

**Quick install:** [Download Buy-Now-screensaver.zip](https://github.com/jamiew/buynow-screensaver-mac/releases/latest)

**Mac App Store:** _Coming soon_

### How to Install

1. Double-click `Buy Now.saver` (or download from Mac App Store when available)
2. Open **System Settings**
3. Go to **Wallpapers**
4. Click the **Screen Saver** button at the bottom
5. Scroll to the bottom right to find **Buy Now**
6. Click to select it

![Installation Step 1](install1.png)
![Installation Step 2](install2.png)

### Build from Source

```bash
git clone https://github.com/jamiew/buynow-screensaver-mac.git
cd buynow-screensaver-mac
./build.sh
open "Buy Now.saver"
```

Then follow the installation steps above.

## Distribution

### Creating a Release

Releases are automated via GitHub Actions:

```bash
./release.sh v1.0.0
```

This automatically:
1. Updates version numbers
2. Creates git tag
3. Triggers GitHub Actions to build and package
4. Publishes to [GitHub Releases](https://github.com/jamiew/buynow-screensaver-mac/releases)

Assets created:
- `Buy-Now-screensaver.zip` - Screensaver only (~13KB)
- `Buy-Now-App.zip` - Mac app installer
- `Buy-Now-Screensaver-Installer.dmg` - Disk image

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
