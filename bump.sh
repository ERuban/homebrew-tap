#!/bin/bash
# Points Casks/k5k1-prog.rb at the latest published K5K1 Prog release.
# The checksum is computed from the downloaded zip and must match the release's SHA256SUMS.txt.
# Needs gh (authenticated; GH_TOKEN in Actions). Changes nothing when the cask is up to date.
set -euo pipefail
cd "$(dirname "$0")"

REPO="ERuban/k5k1prog-mac"
CASK="Casks/k5k1-prog.rb"

tag=$(gh release view --repo "$REPO" --json tagName -q .tagName)   # latest, not drafts / pre-releases
version=${tag#v}
current=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$CASK")
if [ "$version" = "$current" ]; then
    echo "k5k1-prog is up to date ($current)"
    exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
zip="K5K1-Prog-$version.zip"
gh release download "$tag" --repo "$REPO" --dir "$tmp" --pattern "$zip" --pattern SHA256SUMS.txt

if command -v sha256sum >/dev/null; then sha=$(sha256sum "$tmp/$zip" | cut -d' ' -f1)
else sha=$(shasum -a 256 "$tmp/$zip" | cut -d' ' -f1); fi
listed=$(awk -v f="$zip" '$2 == f { print $1 }' "$tmp/SHA256SUMS.txt")
if [ "$sha" != "$listed" ]; then
    echo "error: $zip checksum $sha does not match SHA256SUMS.txt ($listed)" >&2
    exit 1
fi

sed -i.bak -e "s/^  version \".*\"$/  version \"$version\"/" -e "s/^  sha256 \".*\"$/  sha256 \"$sha\"/" "$CASK"
rm -f "$CASK.bak"
echo "k5k1-prog $current -> $version ($sha)"
