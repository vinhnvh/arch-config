#!/bin/bash

# --- CẤU HÌNH ---
LAPTOP="eDP-1"
LAPTOP2="eDP-2"
# Script tự động tìm các cổng DP-1, DP-2, DP-3... bất kể bạn dùng Hybrid hay Discrete GPU
EXTERNAL_PATH="/sys/class/drm/card*-DP-*/status"

# --- CHỐNG CHẠY ĐÈ (SINGLETON) ---
# Nếu script đã chạy rồi thì bản mới sẽ tự thoát
LOCKFILE="/tmp/auto-display.lock"
if [ -e ${LOCKFILE} ] && kill -0 $(cat ${LOCKFILE}) 2>/dev/null; then
    exit
fi
echo $$ > ${LOCKFILE}

# --- LOGIC XỬ LÝ ---
apply_logic() {
    # Đợi một chút để Niri và phần cứng ổn định tín hiệu
    sleep 0.7

    # Kiểm tra trạng thái vật lý của tất cả các cổng DP
    if grep -q "^connected" $EXTERNAL_PATH 2>/dev/null; then
        # Có màn hình rời -> Tắt màn hình laptop
        niri msg output "$LAPTOP" off
        niri msg output "$LAPTOP2" off
    else
        # Không có màn hình rời -> Bật màn hình laptop
        niri msg output "$LAPTOP" on
        niri msg output "$LAPTOP2" on
    fi
}

# 1. Chạy kiểm tra ngay khi khởi động
apply_logic

# 2. LẮNG NGHE SỰ KIỆN (Không dùng vòng lặp polling)
# Sử dụng Process Substitution (< <) để giảm thiểu số lượng tiến trình con
while read -r line; do
    # Niri trên máy bạn không bắn sự kiện Output, nên ta bám vào Workspace changed
    if echo "$line" | grep -q "Workspaces changed"; then
        apply_logic
    fi
done < <(niri msg event-stream)
