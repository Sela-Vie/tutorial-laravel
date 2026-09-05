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

composer install
php artisan key:generate
yes | php artisan install:api

docker compose --project-name $SESSION_NAME up -d && sleep 20