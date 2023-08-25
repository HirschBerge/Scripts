#!/usr/bin/env sh
# shellcheck disable=SC2059
set -eu

readonly FIRST_FONT_VERSION='10.3.1'
readonly FIRST_FONT_NAME='iosevka-term-ss04'
readonly USER_FONT_DIR="${HOME}/.local/share/fonts"

readonly FIRST_DL_URL=$(printf '%s' \
  "https://github.com/be5invis/Iosevka/releases/download/" \
  "v${FIRST_FONT_VERSION}/ttf-${FIRST_FONT_NAME}-${FIRST_FONT_VERSION}.zip")

readonly NC='\033[0m'
readonly IT='\033[3m'
readonly RED='\033[1;31m'
readonly BLUE='\033[1;34m'
readonly DIM='\033[2m'
readonly GREEN='\033[1;32m'
first_main() {
  if ! command -v unzip >/dev/null 2>&1; then
    printf '%b' \
      "${RED}error:${NC} ${IT}unzip${NC} is required " \
      "for archive extraction but not installed.\n" >&2
    exit 1
  fi

  readonly temp_dir=$(mktemp -d)

  printf "${BLUE}::${NC} Downloading ${IT}%s${NC} font...\n" "${FIRST_FONT_NAME}"
  curl -fLsS -o "${temp_dir}/${FIRST_FONT_NAME}.zip" "${FIRST_DL_URL}"

  printf "${BLUE}::${NC} Extracting to ${IT}~/.local/share/fonts${NC}...\n"
  mkdir -p "${USER_FONT_DIR}"
  unzip -qo "${temp_dir}/${FIRST_FONT_NAME}.zip" -d "${USER_FONT_DIR}/${FIRST_FONT_NAME}"

  printf "${BLUE}::${NC} Rebuilding font cache...\n"
  fc-cache -f "${USER_FONT_DIR}"

  rm -r "${temp_dir}"
}

first_main

# kak:filetype=sh
#!/usr/bin/env sh
# shellcheck disable=SC2059

# Download and install the M+ Nerd Font for the current user.
#
# See:
#   * https://mplus-fonts.osdn.jp/about-en.html
#   * https://github.com/ryanoasis/nerd-fonts
#
# Author: Benedikt Vollmerhaus <benedikt@vollmerhaus.org>
# License: MIT

set -eu

readonly FONT_VERSION='2.0.0'
readonly FONT_NAME='M+ 1m'
readonly FONT_STYLES='Bold Light Medium Regular Thin'

readonly DL_URL=$(printf '%s' \
  "https://github.com/ryanoasis/nerd-fonts/raw/" \
  "${FONT_VERSION}/patched-fonts/MPlus/%s/complete/%s")
readonly FILENAME_FORMAT="${FONT_NAME}%s Nerd Font Complete.ttf"


download_font() {
  font_style=$1

  if [ "${font_style}" != 'Regular' ]; then
    style_in_filename=$(printf " ${font_style}" | awk '{print tolower($0)}')
  else
    style_in_filename=''
  fi

  filename=$(printf "${FILENAME_FORMAT}" "${style_in_filename}")
  encoded_filename=$(printf "${filename}" | sed 's/ /%20/g')
  url=$(printf "${DL_URL}" "${font_style}" "${encoded_filename}")

  printf " ${DIM}[${NC} ${DIM}]${NC} %s " "${filename}"
  curl -fLsS -o "${filename}" "${url}"
  printf "\r ${DIM}[${NC}%b${DIM}]${NC} %s\n" "${GREEN}✓${NC}" "${filename}"
}

second_main() {
  mkdir -p "${USER_FONT_DIR}/${FONT_NAME}"
  cd "${USER_FONT_DIR}/${FONT_NAME}"

  printf "${BLUE}::${NC} Downloading ${IT}%s${NC} fonts...\n" "${FONT_NAME}"
  for style in ${FONT_STYLES}; do
    download_font "${style}"
  done

  printf "${BLUE}::${NC} Rebuilding font cache...\n"
  fc-cache -f "${USER_FONT_DIR}"
}

second_main

# kak:filetype=sh
