#!/bin/bash

# --- CẤU HÌNH ---
LAPTOP_PATH="/sys/class/drm/card*-eDP-*/status"
EXTERNAL_PATH="/sys/class/drm/card*-DP-*/status"

# --- SINGLETON ---
LOCKFILE="/tmp/auto-display.lock"
if [ -e ${LOCKFILE} ] && kill -0 $(cat ${LOCKFILE}) 2>/dev/null; then
    exit
fi
echo $$ > ${LOCKFILE}
trap "rm -f ${LOCKFILE}" EXIT

# --- Laptop_OUTPUTS ---
set_laptop_outputs() {
    for status_file in $LAPTOP_PATH; do
        output=$(basename "$(dirname "$status_file")" | sed 's/card[0-9]*-//')
        niri msg output "$output" "$1"
    done
}

# --- LOGIC XỬ LÝ ---
apply_logic() {
    if grep -q "^connected" $EXTERNAL_PATH 2>/dev/null; then
        set_laptop_outputs off
    else
        set_laptop_outputs on
    fi
}

# --- Debounce ---
DEBOUNCE_PID=""
trigger_debounce() {
    if [ -n "$DEBOUNCE_PID" ] && kill -0 "$DEBOUNCE_PID" 2>/dev/null; then
        kill "$DEBOUNCE_PID"
    fi
    ( sleep 0.5; apply_logic ) &
    DEBOUNCE_PID=$!
}

# --- Khởi động ---
apply_logic

# --- Xử lý Event ---
STREAM_START=$(date +%s)
while read -r line; do
    if echo "$line" | grep -q "HOTPLUG=1"; then
        NOW=$(date +%s)
        if [ $((NOW - STREAM_START)) -lt 1 ]; then
            continue
        fi
        trigger_debounce
    fi
done < <(udevadm monitor --subsystem-match=drm --property)

# --- Xử lý Event (niri) ---
# STREAM_START=$(date +%s)
# while read -r line; do
#     if echo "$line" | grep -q "Workspaces changed"; then
#         NOW=$(date +%s)
#         if [ $((NOW - STREAM_START)) -lt 1 ]; then
#             continue
#         fi
#         trigger_debounce
#     fi
# done < <(niri msg event-stream)
