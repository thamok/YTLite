#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
base64 --decode source.tar.gz.b64 > source.tar.gz
EXPECTED='a5e0c7df4131a780ea755f1b59a53ea6553a468770ab773bf957f792a73956e7'
ACTUAL="$(shasum -a 256 source.tar.gz | awk '{print $1}')"
if [ "$ACTUAL" != "$EXPECTED" ]; then
  echo "source archive checksum mismatch: expected $EXPECTED got $ACTUAL" >&2
  exit 1
fi
tar -xzf source.tar.gz
rm source.tar.gz
echo "MediaPull sources restored into $ROOT"
