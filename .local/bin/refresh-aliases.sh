#!/bin/bash
# ~/bin/refresh-aliases.sh
# Fetches SimpleLogin aliases and re-inits mu only if the list changed.

set -euo pipefail

# Use an array for safe argument passing
MY_ADDRESSES=(
    "--my-address=j@ckruder.xyz"
    "--my-address=jackruder@proton.me"
    "--my-address=contact@jackruder.xyz"
    "--my-address=school@jackruder.xyz"
    "--my-address=montana@jackruder.xyz"
    "--my-address=finance@jackruder.xyz"
    "--my-address=jackruder@montana.edu"
    "--my-address=jack.ruder@student.montana.edu"
)

ALIAS_FILE="$HOME/mail/simplelogin-aliases.txt"
ALIAS_FILE_TMP="$HOME/mail/simplelogin-aliases.txt.tmp"
LOG_FILE="$HOME/mail/alias-refresh.log"
API_KEY=$(pass show simplelogin/api-key)

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" | tee -a "$LOG_FILE"
}

# ----------------------------------------------------------
# 1. Fetch all aliases from SimpleLogin API (paginated)
# ----------------------------------------------------------
PAGE=0
> "$ALIAS_FILE_TMP" # Clear/create the temp file

while true; do
    RESPONSE=$(curl -sf \
        -H "Authentication: $API_KEY" \
        "https://app.simplelogin.io/api/v2/aliases?page_id=$PAGE") || {
        log "ERROR: API request failed on page $PAGE"
        exit 1
    }

    ALIASES=$(echo "$RESPONSE" | jq -r '.aliases[].email // empty')

    if [ -z "$ALIASES" ]; then
        break
    fi

    echo "$ALIASES" >> "$ALIAS_FILE_TMP"
    PAGE=$((PAGE + 1))
done

# Clean and sort in place
sed -i '/^$/d' "$ALIAS_FILE_TMP"
sort -o "$ALIAS_FILE_TMP" "$ALIAS_FILE_TMP"

COUNT=$(wc -l < "$ALIAS_FILE_TMP")
log "Fetched $COUNT aliases"

# ----------------------------------------------------------
# 2. Compare with existing list — only re-init if changed
# ----------------------------------------------------------
if [ -f "$ALIAS_FILE" ] && diff -q "$ALIAS_FILE" "$ALIAS_FILE_TMP" > /dev/null 2>&1; then
    log "No changes detected. Skipping mu re-init."
    rm -f "$ALIAS_FILE_TMP"
    exit 0
fi

# List changed — update
mv "$ALIAS_FILE_TMP" "$ALIAS_FILE"
log "Alias list changed. Re-initializing mu..."

# ----------------------------------------------------------
# 3. Re-init mu with all addresses
# ----------------------------------------------------------

while IFS= read -r alias; do
    MY_ADDRESSES+=("--my-address=$alias")
done < "$ALIAS_FILE"

# No eval needed, expand the array securely
mu init --maildir="$HOME/mail" "${MY_ADDRESSES[@]}" 2>> "$LOG_FILE"
mu index 2>> "$LOG_FILE"

log "mu re-initialized with $COUNT aliases + ${#MY_ADDRESSES[@]} primary addresses"

