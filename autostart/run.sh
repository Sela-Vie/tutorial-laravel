#!/bin/bash
set -e

# ===============================================
# VARS
# ===============================================
SESSION_NAME="tut-lar"
PORT="8100"
TIMEOUT_DOCKER=180

# ===============================================
# SETUP
# ===============================================
script_path="${BASH_SOURCE[0]}"
script_dir=$(dirname -- "$script_path")
script_dir_m0="$(cd "$script_dir" && pwd)"
script_dir_m1="$(cd "$script_dir/.." && pwd)"

LOG="$script_dir.log"
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

# we only care about the exit status of docker info
# the output is discarded with >/dev/null 2>&1
# >/dev/null equivalent to 1>/dev/null; throws away the normal stream
# 2>&1 throws error stream to wherever we threw steam 1 to
# equivalent of &>/dev/null
if ! timeout $TIMEOUT_DOCKER bash -c 'while ! docker info &>/dev/null;do sleep 2; done'; 
then
    tmux_send_keys "Docker did not become ready within $TIMEOUT_DOCKER seconds"
    exit 1
fi

tmux_send_keys "composer install"
tmux_send_keys "docker compose --project-name $SESSION_NAME up -d"
tmux_send_keys "php artisan serve --port=$PORT --host=0.0.0.0"