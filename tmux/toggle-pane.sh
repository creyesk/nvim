#!/bin/bash

# toggle-pane.sh - Toggle visibility of the bottom pane (pane 0.2)

SESSION_NAME="dev"
PANE="$SESSION_NAME:0.2"

# Get current height of the pane
CURRENT_HEIGHT=$(tmux display-message -p "#{pane_height}" -t "$PANE" 2>/dev/null)

if [ -z "$CURRENT_HEIGHT" ] || [ "$CURRENT_HEIGHT" -le 1 ]; then
    # Pane is hidden or very small, show it (15 lines)
    tmux resize-pane -t "$PANE" -y 15
else
    # Pane is visible, hide it
    tmux resize-pane -t "$PANE" -y 1
fi
