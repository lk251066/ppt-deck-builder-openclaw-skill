#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: package_image_deck.sh <images_dir> <output.pptx>"
  exit 1
fi

INDIR="$1"
OUTFILE="$2"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGER="$SCRIPT_DIR/build_pptx_from_images.py"

if [[ ! -f "$PACKAGER" ]]; then
  echo "Packager script not found: $PACKAGER"
  exit 1
fi

python3 "$PACKAGER" --indir "$INDIR" --out "$OUTFILE"
