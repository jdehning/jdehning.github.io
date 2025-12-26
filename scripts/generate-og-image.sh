#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

INPUT_PHOTO="${ROOT_DIR}/images/bio_photo_bw.jpg"
INPUT_LOGO="${ROOT_DIR}/images/favicon.png"
OUTPUT_OG_IMAGE="${ROOT_DIR}/images/og-image.png"

MAGICK_BIN="${MAGICK_BIN:-convert}"

if ! command -v "${MAGICK_BIN}" >/dev/null 2>&1; then
  echo "error: ImageMagick not found (expected '${MAGICK_BIN}' in PATH)" >&2
  exit 1
fi

if [[ ! -f "${INPUT_PHOTO}" ]]; then
  echo "error: missing photo: ${INPUT_PHOTO}" >&2
  exit 1
fi

if [[ ! -f "${INPUT_LOGO}" ]]; then
  echo "error: missing logo: ${INPUT_LOGO}" >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "${tmpdir}"; }
trap cleanup EXIT

photo_size="${PHOTO_SIZE:-460}"
ring_size="${RING_SIZE:-480}"

title_text="${TITLE_TEXT:-Dr. Jonas Dehning}"
subtitle_line1="${SUBTITLE_LINE1:-Neuroscience · Bayesian inference}"
subtitle_line2="${SUBTITLE_LINE2:-Infectious disease dynamics}"
footer_text="${FOOTER_TEXT:-jdehning.com}"

bg_top="${BG_TOP:-#0b1020}"
bg_bottom="${BG_BOTTOM:-#142a52}"

photo_x="${PHOTO_X:-80}"
photo_y="${PHOTO_Y:-85}"

ring_x="${RING_X:-70}"
ring_y="${RING_Y:-75}"

logo_x="${LOGO_X:-70}"
logo_y="${LOGO_Y:-65}"

text_right_margin="${TEXT_RIGHT_MARGIN:-50}"
title_y="${TITLE_Y:-235}"

sub1_y="${SUB1_Y:-320}"

sub2_y="${SUB2_Y:-362}"

footer_x="${FOOTER_X:-70}"
footer_y="${FOOTER_Y:-60}"

title_pt="${TITLE_PT:-58}"
sub1_pt="${SUB1_PT:-32}"
sub2_pt="${SUB2_PT:-30}"
footer_pt="${FOOTER_PT:-30}"

logo_size="${LOGO_SIZE:-96}"
logo_right_margin="${LOGO_RIGHT_MARGIN:-${text_right_margin}}"
footer_right_margin="${FOOTER_RIGHT_MARGIN:-${text_right_margin}}"

"${MAGICK_BIN}" "${INPUT_PHOTO}" -resize "${photo_size}x${photo_size}^" -gravity center -extent "${photo_size}x${photo_size}" \
  \( -size "${photo_size}x${photo_size}" xc:none -fill white -draw "circle $((photo_size / 2)),$((photo_size / 2)) $((photo_size / 2)),0" \) \
  -alpha off -compose copyopacity -composite "${tmpdir}/photo_circle.png"

"${MAGICK_BIN}" -size "${ring_size}x${ring_size}" xc:none -fill none -stroke '#ffffffcc' -strokewidth 8 \
  -draw "circle $((ring_size / 2)),$((ring_size / 2)) $((ring_size / 2)),5" "${tmpdir}/ring.png"

"${MAGICK_BIN}" -size 1200x630 "gradient:${bg_top}-${bg_bottom}" "${tmpdir}/base.png"

"${MAGICK_BIN}" "${INPUT_LOGO}" -trim +repage -resize "${logo_size}x${logo_size}" \
  \( +clone -alpha extract -blur 0x1 \) -compose CopyOpacity -composite "${tmpdir}/logo.png"

"${MAGICK_BIN}" "${tmpdir}/base.png" \
  \( "${tmpdir}/photo_circle.png" -background none -shadow 30x8+0+0 \) -gravity northwest -geometry "+$((photo_x - 2))+$((photo_y))" -compose over -composite \
  "${tmpdir}/photo_circle.png" -gravity northwest -geometry "+${photo_x}+${photo_y}" -compose over -composite \
  "${tmpdir}/ring.png" -gravity northwest -geometry "+${ring_x}+${ring_y}" -compose over -composite \
  "${tmpdir}/logo.png" -gravity northeast -geometry "+${logo_right_margin}+${logo_y}" -compose over -composite \
  -font DejaVu-Sans-Bold -pointsize "${title_pt}" -fill white -gravity northeast -annotate "+${text_right_margin}+${title_y}" "${title_text}" \
  -font DejaVu-Sans -pointsize "${sub1_pt}" -fill '#d7dde8' -gravity northeast -annotate "+${text_right_margin}+${sub1_y}" "${subtitle_line1}" \
  -font DejaVu-Sans -pointsize "${sub2_pt}" -fill '#c1c9d6' -gravity northeast -annotate "+${text_right_margin}+${sub2_y}" "${subtitle_line2}" \
  -font DejaVu-Sans -pointsize "${footer_pt}" -fill '#aeb8c7' -gravity southeast -annotate "+${footer_right_margin}+${footer_y}" "${footer_text}" \
  -strip "${OUTPUT_OG_IMAGE}"

echo "wrote ${OUTPUT_OG_IMAGE}"
