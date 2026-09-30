#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: sudo $0 [--clean]" >&2
  exit 1
}

clean=false

case "${1:-}" in
  --clean) clean=true ;;
  "")      ;;
  *)       echo "Unknown option: $1" >&2; usage ;;
esac

if [[ $EUID -ne 0 ]]; then
  echo "Run this with sudo: sudo $0" >&2
  exit 1
fi

echo "Updating package lists..."
apt update
echo "Upgrading packages..."
apt upgrade -y

if [[ $clean == true ]]; then
  echo "Removing unused packages..."
  apt autoremove -y
fi

echo "Finished at $(date)"
