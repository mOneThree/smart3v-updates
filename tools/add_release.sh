#!/usr/bin/env bash
# Maintainer tool: publish one firmware file for one product line.
# Usage: tools/add_release.sh <file.ota> <vendor_id> <product_id> <version> <version_string> "<notes>"
#   e.g. tools/add_release.sh build/smart3v.ota 0xfff1 0x8001 4 3c.4 "What changed"
# Take vendor/product/version from the build's ota_header.txt, never from memory.
# Replaces the previous file of that product line and rewrites firmware/manifest.json.
# Never publish a build made with a fixed pairing passcode or the never-confirm test option.
set -euo pipefail
src="$1"; vid=$(( $2 )); pid=$(( $3 )); ver="$4"; vstr="$5"; notes="${6:-}"
cd "$(dirname "$0")/.."
name=$(printf 'smart3v-%04x-%04x-v%d.ota' "$vid" "$pid" "$ver")
prev=$(jq -r --argjson v "$vid" --argjson p "$pid" '.firmware[] | select(.vendor_id==$v and .product_id==$p) | .version' firmware/manifest.json)
if [ -n "$prev" ] && [ "$ver" -le "$prev" ]; then echo "version $ver is not higher than published $prev" >&2; exit 1; fi
old=$(jq -r --argjson v "$vid" --argjson p "$pid" '.firmware[] | select(.vendor_id==$v and .product_id==$p) | .file' firmware/manifest.json)
cp "$src" "firmware/$name"
[ -n "$old" ] && [ "$old" != "$name" ] && git rm -q -f "firmware/$old" 2>/dev/null || true
size=$(stat -c %s "firmware/$name"); sha=$(sha256sum "firmware/$name" | cut -d' ' -f1)
jq --argjson v "$vid" --argjson p "$pid" --argjson ver "$ver" --arg vs "$vstr" --arg f "$name" \
   --argjson size "$size" --arg sha "$sha" --arg notes "$notes" --arg d "$(date -u +%F)" '
   .updated = $d
   | .firmware = ([.firmware[] | select((.vendor_id==$v and .product_id==$p) | not)]
       + [{name: "Smart 3V LED String", vendor_id: $v, product_id: $p, version: $ver,
           version_string: $vs, file: $f, size: $size, sha256: $sha, notes: $notes}])' \
   firmware/manifest.json > firmware/manifest.json.tmp && mv firmware/manifest.json.tmp firmware/manifest.json
echo "published $name ($size bytes, sha256 $sha)"
