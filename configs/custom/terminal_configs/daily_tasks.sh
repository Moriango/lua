#!/bin/bash

# Check if tmux is already running
if ! tmux has-session -t Workplace 2>/dev/null; then
  # Create a new session named "Workplace" with a window named "Dev-Desktop"
  tmux new-session -d -s Workplace -n "Dev-Desktop"
  
  # Create additional windows
  tmux new-window -t Workplace: -n "Workplace"
  tmux new-window -t Workplace: -n "Local"
  
  # Select the first window
  tmux select-window -t Workplace:0

  tmux new-session -d -s Ninja-Dev-Sync -n "Ninja"
else
  # If session exists, ensure all windows are present
  if ! tmux list-windows -t Workplace | grep -q "Dev-Desktop"; then
    tmux new-window -t Workplace: -n "Dev-Desktop"
  fi
  
  if ! tmux list-windows -t Workplace | grep -q "Workplace"; then
    tmux new-window -t Workplace: -n "Workplace"
  fi
  
  if ! tmux list-windows -t Workplace | grep -q "Local"; then
    tmux new-window -t Workplace: -n "Local"
  fi
fi

# Attach to the session if not already attached
if [ -z "$TMUX" ]; then
  tmux attach-session -t Workplace
fi

if [[ -z "$TMUX" ]]; then
  
fi
