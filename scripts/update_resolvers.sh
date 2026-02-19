#!/usr/bin/env bash
set -euo pipefail

WORKDIR="$(mktemp -d)"
cd "$WORKDIR"

echo "[+] Downloading raw resolvers..."

wget -q https://raw.githubusercontent.com/trickest/resolvers/main/resolvers.txt -O raw.txt

echo "[+] Running dnsvalidator..."

dnsvalidator -tL raw.txt -threads 300 -o validated.txt

echo "[+] Deduplicating..."

sort -u validated.txt > resolvers.txt

echo "[+] Done. Total:"
wc -l resolvers.txt

# move to repo workspace
cp resolvers.txt "$GITHUB_WORKSPACE/resolvers.txt"
