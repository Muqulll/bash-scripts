#!/usr/bin/env bash
 set -euo pipefail

 if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <source_dir> <backup_dir>" >&2
  exit 1
 fi

 src=$1
 dest=$2

 if [[ ! -d $src ]]; then
  echo "Source folder not found: $src" >&2
  exit 1
 fi 

 mkdir -p "$dest"

 stamp=$(date +%F)
 name=$(basename "$src")
 archive="$dest/${name}-${stamp}.tar.gz"

 tar -czf "$archive" -C "$(dirname "$src")" "$name"
 echo "Created $archive"

 find "$dest" -name "${name}-*.tar.gz" -mtime +7 -delete
 echo "Removed backups older than 7 days"
