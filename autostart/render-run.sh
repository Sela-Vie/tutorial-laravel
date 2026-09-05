#!/bin/bash
set -e

# this script uses the tmux terminal multiplexer 
# to keep a terminal session alive for the program
# and for user monitoring
# for ease of use, just change SETUP and COMMANDS
# ===============================================
# SETUP
# ===============================================
PORT="8100"
SESSION_NAME="tut-lar"

docker compose --project-name $SESSION_NAME up -d && sleep 20
php artisan serve --port=$PORT --host=0.0.0.0
php artisan migrate:fresh --seed 