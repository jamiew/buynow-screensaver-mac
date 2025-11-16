# BUY NOW Screensaver

A bright blue screensaver with flashing white "BUY NOW" text.

## Usage

The video `buy-now.mp4` contains a 10-second loop of:
- Bright blue background (#0080ff)
- White "BUY NOW" text
- Text flashes on/off every second

### Installing as a Screensaver

macOS doesn't natively support video screensavers directly, but you have a few options:

1. **Use with a video screensaver app** like [Aerial](https://aerialscreensaver.github.io/) or similar
2. **Use QuickTime Player** in full screen and loop mode
3. **Convert to image sequence** and use with a screensaver that supports images

### Playing the Video

Simply open `buy-now.mp4` in any video player. For full-screen loop:
```bash
open -a "QuickTime Player" buy-now.mp4
# Then: View > Enter Full Screen, View > Loop
```

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
