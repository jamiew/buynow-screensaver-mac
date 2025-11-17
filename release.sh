#!/bin/bash
set -e

# Create a new release for Buy Now screensaver

VERSION=${1:-}

if [ -z "$VERSION" ]; then
    echo "Usage: ./release.sh <version>"
    echo "Example: ./release.sh v1.0.0"
    exit 1
fi

# Validate version format
if [[ ! $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in format v1.0.0"
    exit 1
fi

echo "Creating release ${VERSION}..."

# Make sure we're on main branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "main" ]; then
    echo "Warning: You're on branch '${BRANCH}', not 'main'"
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Make sure working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "Error: Working directory has uncommitted changes"
    git status --short
    exit 1
fi

# Update version in Info.plist files
echo "Updating version to ${VERSION#v}..."
sed -i '' "s/<string>[0-9]\+\.[0-9]\+\.[0-9]\+<\/string>/<string>${VERSION#v}<\/string>/g" Info.plist
sed -i '' "s/<string>[0-9]\+\.[0-9]\+\.[0-9]\+<\/string>/<string>${VERSION#v}<\/string>/g" BuyNowApp/Info.plist

# Commit version changes
git add Info.plist BuyNowApp/Info.plist
git commit -m "Bump version to ${VERSION}"

# Create and push tag
git tag -a "${VERSION}" -m "Release ${VERSION}"
git push origin main
git push origin "${VERSION}"

echo ""
echo "✓ Release ${VERSION} created!"
echo ""
echo "GitHub Actions will now:"
echo "  1. Build the screensaver"
echo "  2. Create release packages"
echo "  3. Upload to GitHub Releases"
echo ""
echo "Check progress: https://github.com/jamiew/buynow-screensaver-mac/actions"
echo "View release:   https://github.com/jamiew/buynow-screensaver-mac/releases/tag/${VERSION}"
