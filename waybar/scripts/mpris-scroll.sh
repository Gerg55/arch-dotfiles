#!/usr/bin/env bash

MAX_LENGTH=26
DELAY=0.25

last_track=""
offset=0

while true; do
    status=$(playerctl status 2>/dev/null || echo "Stopped")

    if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
        artist=$(playerctl metadata artist 2>/dev/null)
        title=$(playerctl metadata title 2>/dev/null)
        album=$(playerctl metadata album 2>/dev/null)
        player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

        text="${artist} — ${title}"
        track="${player}|${text}"

        if [[ "$track" != "$last_track" ]]; then
            offset=0
            last_track="$track"
        fi

        if (( ${#text} > MAX_LENGTH )); then
            padded="${text}     ${text}"
            visible="${padded:offset:MAX_LENGTH}"
            ((offset++))

            if (( offset >= ${#text} + 5 )); then
                offset=0
            fi
        else
            visible="$text"
        fi

        # JSON escaping
        json_text=$(printf '%s' "$visible" | python -c '
import json, sys
print(json.dumps(sys.stdin.read().rstrip("\n")))
')

        json_tooltip=$(printf '%s' \
            "$player"$'\n'"$artist — $title"$'\n'"$album"$'\n'"$status" |
            python -c '
import json, sys
print(json.dumps(sys.stdin.read().rstrip("\n")))
')

        printf '{"text":%s,"tooltip":%s}\n' "$json_text" "$json_tooltip"
    else
        printf '{"text":"","tooltip":""}\n'
        sleep 1
        continue
    fi

    sleep "$DELAY"
done