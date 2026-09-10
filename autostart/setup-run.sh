#!/bin/bash
set -e

# this script uses the tmux terminal multiplexer 
# to keep a terminal session alive for the program
# and for user monitoring
# for ease of use, just change SETUP and COMMANDS
# ===============================================
# SETUP
# ===============================================
SESSION_NAME="tut-lar"
PORT="8100"

script_path="${BASH_SOURCE[0]}"
script_dir=$(dirname -- "$script_path")
script_dir_m0="$(cd "$script_dir" && pwd)"
script_dir_m1="$(cd "$script_dir/.." && pwd)"

# ===============================================
# FUNCTIONS
# ===============================================
LOG="$script_dir_m0/${SESSION_NAME}.log"
exec > >(tee -a "$LOG") 2>&1

# wont stop if tmux session notif already exists
tmux new -d -s "$SESSION_NAME" || true		
tmux_send_keys(){
	local command_string=$1
	tmux send-keys -t "$SESSION_NAME" "$command_string" C-m
}

# ===============================================
# COMMANDS
# ===============================================

tmux_send_keys "cd $script_dir_m1"
tmux_send_keys "yes | cp .env.example .env"

tmux_send_keys "composer install"
tmux_send_keys "php artisan key:generate"
tmux_send_keys "yes | php artisan install:api"

tmux_send_keys "docker compose --project-name $SESSION_NAME up -d && sleep 20"

# only if you need to store files and make command automations
# tmux_send_keys "php artisan storage:link"
# tmux_send_keys "php artisan make:command ExampleCommand"

tmux_send_keys "yes | php artisan migrate:fresh --seed"
tmux_send_keys "php artisan serve --port=$PORT --host=0.0.0.0"