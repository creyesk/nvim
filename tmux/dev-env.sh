#!/bin/bash

# dev-env.sh - Launch tmux with nvim + claude code layout
# Layout: Left 1/4 (claude), Right 3/4 (nvim)
# Optional: Toggle bottom pane in left section with prefix + b

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

# Set up key binding to toggle pane (pane 1 is the bottom shell)
tmux bind-key -T prefix t run-shell "$HOME/.config/nvim/tmux/toggle-pane.sh"

# Get window width to calculate pane sizes
WINDOW_WIDTH=$(tmux list-windows -t "$SESSION_NAME" -F "#{window_width}" | head -1)
# Left pane: 1/4 width, Right pane: 3/4 width
LEFT_WIDTH=$((WINDOW_WIDTH / 4))

# Split the main window vertically (left 1/4 | right 3/4)
tmux split-window -h -t "$SESSION_NAME" -p 75 -c "$WORK_DIR"

# Left pane (index 0): claude code
tmux send-keys -t "$SESSION_NAME:0.0" "claude" Enter

# Right pane (index 1): nvim
tmux send-keys -t "$SESSION_NAME:0.1" "nvim" Enter

# Create a second optional pane below claude (hidden initially)
# Split the left pane horizontally
tmux split-window -v -t "$SESSION_NAME:0.0" -p 50 -c "$WORK_DIR"

# Send a shell prompt to the bottom pane
tmux send-keys -t "$SESSION_NAME:0.2" "# Toggle me with: tmux select-pane -t {pane}" Enter

# Hide the bottom pane initially by resizing it to 0 height
tmux resize-pane -t "$SESSION_NAME:0.2" -y 0

# Bind Ctrl+T to toggle the bottom pane

# Focus on the main nvim pane
tmux select-pane -t "$SESSION_NAME:0.1"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
