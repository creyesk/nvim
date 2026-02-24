#!/bin/bash

# dev-env.sh - Launch tmux with nvim + claude code layout
# Layout: Left 1/4 (claude), Right 3/4 (nvim)

WORK_DIR="${PWD}"
SESSION_NAME="dev-$(basename "$WORK_DIR")"

# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t "$SESSION_NAME"
    exit 0
fi

# Create new session with the work directory
tmux new-session -d -s "$SESSION_NAME" -c "$WORK_DIR"

# Split the main window vertically (left 1/4 | right 3/4)
tmux split-window -h -t "$SESSION_NAME" -p 75 -c "$WORK_DIR"

# Left pane (index 0): claude code
tmux send-keys -t "$SESSION_NAME:0.0" "claude" Enter

# Right pane (index 1): nvim
tmux send-keys -t "$SESSION_NAME:0.1" "nvim" Enter

# Focus on the nvim pane
tmux select-pane -t "$SESSION_NAME:0.1"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
