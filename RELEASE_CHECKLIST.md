# Release Checklist

## Pre-Release

- [ ] Update version numbers in Info.plist files
- [ ] Test screensaver on multiple macOS versions
- [ ] Test app installation/uninstallation
- [ ] Review README for accuracy
- [ ] Check all links work

## Building Release Assets

```bash
# Clean build everything
rm -rf *.saver *.app *.zip *.dmg
./build.sh
./build-app.sh
./package-app.sh
```

## GitHub Release

1. Create git tag: `git tag v1.0.0`
2. Push tag: `git push origin v1.0.0`
3. Create GitHub release
4. Upload assets:
   - BuyNow-screensaver.zip (screensaver only)
   - BuyNow-App.zip (app wrapper)
   - BuyNow-Screensaver-Installer.dmg (disk image)

## Mac App Store (Future)

- [ ] Add app icons (1024x1024 and all sizes)
- [ ] Set up code signing certificate
- [ ] Add sandboxing entitlements
- [ ] Test on clean macOS install
- [ ] Submit via App Store Connect

## Post-Release

- [ ] Announce on socials
- [ ] Share with BeOS/Haiku community
- [ ] Update homebrew cask (if applicable)
