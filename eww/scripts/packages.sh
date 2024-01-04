#!/usr/bin/env bash
get_uniq_pkgs () {
  echo "$(nix-store -qR "$1" | cut -d '-' -f 2 | sort | uniq | wc -l)"
}

current_system=$(get_uniq_pkgs "/run/current-system/sw")
per_user=$(get_uniq_pkgs "/etc/profiles/per-user/$USER")
nix_profile=$(get_uniq_pkgs "$HOME/.nix-profile/")

result=$((current_system + per_user + nix_profile))
echo $result
