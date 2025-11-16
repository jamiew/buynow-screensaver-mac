# BUY NOW Screensaver

A recreation of the classic BUY NOW screensaver by Ficus Kirkpatrick for BeOS.

Features:
- Dark blue background (#00008B)
- White "BUY NOW" text
- Flashes on/off every second
- Native macOS screensaver (.saver bundle)

## Installation

### Quick Install

```bash
./build.sh
./install.sh
```

Then:
1. Open System Settings > Screen Saver
2. Select "BuyNow" from the list
3. Enjoy!

### Manual Installation

```bash
# Build the screensaver
./build.sh

# Install manually
cp -R BuyNow.saver ~/Library/Screen\ Savers/

# Open System Settings > Screen Saver
```

## Sharing with Friends

To share the screensaver, just zip up the `BuyNow.saver` bundle after building:

```bash
./build.sh
zip -r BuyNow-screensaver.zip BuyNow.saver
```

Your friends can then:
1. Unzip the file
2. Double-click `BuyNow.saver` (or copy to `~/Library/Screen Savers/`)
3. Select it in System Settings > Screen Saver

## About

This is a recreation of the classic BUY NOW screensaver by Ficus Kirkpatrick for BeOS.

## Regenerating the Video

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
