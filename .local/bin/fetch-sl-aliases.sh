#!/bin/bash
# ~/bin/fetch-sl-aliases.sh

API_KEY=$(pass show simplelogin/api-key)
PAGE=0
ALL_ALIASES=""

while true; do
    RESPONSE=$(curl -s \
        -H "Authentication: $API_KEY" \
        "https://app.simplelogin.io/api/v2/aliases?page_id=$PAGE")

    # Extract alias emails using jq
    ALIASES=$(echo "$RESPONSE" | jq -r '.aliases[].email // empty')

    # Break if no more aliases
    if [ -z "$ALIASES" ]; then
        break
    fi

    ALL_ALIASES="$ALL_ALIASES
$ALIASES"
    PAGE=$((PAGE + 1))
done

# Clean up and write to file
echo "$ALL_ALIASES" | sed '/^$/d' | sort > ~/mail/simplelogin-aliases.txt

echo "Fetched $(wc -l < ~/mail/simplelogin-aliases.txt) aliases"

