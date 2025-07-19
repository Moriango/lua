#!/bin/bash
session_one="IDE"
session_two="Monitors"
session_three="AI"
VENV_NAME="Jupyter"

#Start VPN connection
VPN_NAME="Seattle, Washington"
nmcli con up id "$VPN_NAME"

# Open youtube Music
/usr/bin/youtube-music-desktop-app  > /dev/null 2>&1 &

# Open brave browser
/usr/bin/brave-browser > /dev/null 2>&1 &

# Start a new tmux session named IDE and $session_one
tmux new-session -d -s $session_one

# Rename window
tmux rename-window -t $session_one:0 "Chad"
tmux send-keys -t $session_one:0.0 "nvim" C-m

# Split Monitors Vertically
tmux new-session -d -s $session_three
tmux rename-window -t $session_three "Ollama"
tmux send-keys -t $session_three "ollama run llama3:8b" C-m

# Start a new tmux session named $session_two
tmux new-session -d -s $session_two

# Rename window 
tmux rename-window -t $session_two:0 "Jupyter/Keynav"

# Split Monitors horizontally doesnt work just splits it vertically again but oh well it works lol
tmux split-window -h -t $session_two

# Send Keys to panes
tmux send-keys -t $session_two:0.0 "keynav" C-m
tmux send-keys -t $session_two:0.1 "bash" C-m
tmux send-keys -t $session_two:0.1 "source ~/VirtualEnv/$VENV_NAME/bin/activate" C-m
tmux send-keys -t $session_two:0.1 "cd ~/Desktop/Jupyter/" C-m
tmux send-keys -t $session_two:0.1 "jupyter lab --no-browser" C-m

# Attach to the tmux session
tmux attach -t $session_one

# Remove the nohup file created by the Brave Broswer and youtube desktop applications
sleep 5
rm -rf nohup
rm -rf nohup.out
