#!/bin/bash

# --- CẤU HÌNH ---
LAPTOP="eDP-1"
LAPTOP2="eDP-2"
EXTERNAL_PATH="/sys/class/drm/card*-DP-*/status"

# --- CHỐNG CHẠY ĐÈ (SINGLETON) ---
LOCKFILE="/tmp/auto-display.lock"
if [ -e ${LOCKFILE} ] && kill -0 $(cat ${LOCKFILE}) 2>/dev/null; then
    exit
fi
echo $$ > ${LOCKFILE}

# --- LOGIC XỬ LÝ ---
apply_logic() {
    sleep 0.7
    if grep -q "^connected" $EXTERNAL_PATH 2>/dev/null; then
        hyprctl keyword monitor "$LAPTOP, disable"
        hyprctl keyword monitor "$LAPTOP2, disable"
    else
         hyprctl keyword monitor "$LAPTOP, enable"
        hyprctl keyword monitor "$LAPTOP2, enable"
    fi
}

# 1. Chạy kiểm tra ngay khi khởi động
apply_logic

echo "Đã khởi động script giám sát màn hình cho Hyprland..."

nc -U "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    if echo "$line" | grep -qE "^(monitoradded|monitorremoved)>>"; then
        apply_logic
    fi
done
