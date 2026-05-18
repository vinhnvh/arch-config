#!/bin/bash

# Lấy chế độ hiện tại
CURRENT=$(powerprofilesctl get)

# Xác định chế độ tiếp theo
case "$CURRENT" in
    "power-saver")
        NEXT="balanced"
        ;;
    "balanced")
        NEXT="performance"
        ;;
    "performance")
        NEXT="power-saver"
        ;;
    *)
        NEXT="balanced"
        ;;
esac

# Chuyển sang chế độ tiếp theo
powerprofilesctl set "$NEXT"

# Hiển thị thông báo (tùy chọn)
notify-send "🔋 Chế độ nguồn" "Đã chuyển sang: $NEXT" -t 1000 2>/dev/null || true
