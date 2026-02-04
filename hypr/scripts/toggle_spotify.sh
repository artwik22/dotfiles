#!/bin/bash

# specjalny workspace np. 9
TARGET_WS=9
STATE_FILE=/tmp/hypr_toggle_lastws

# sprawdzamy bieżący workspace
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$CURRENT_WS" -eq "$TARGET_WS" ]; then
    # jeśli już jesteśmy na 9, to wróć do poprzedniego
    if [ -f "$STATE_FILE" ]; then
        PREV_WS=$(cat "$STATE_FILE")
        hyprctl dispatch workspace "$PREV_WS"
    fi
else
    # zapisz aktualny workspace i idź na 9
    echo "$CURRENT_WS" > "$STATE_FILE"
    hyprctl dispatch workspace "$TARGET_WS"
fi
