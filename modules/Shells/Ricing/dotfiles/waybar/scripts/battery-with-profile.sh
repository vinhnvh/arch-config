#!/bin/bash

# ============================================
# Script: power-profile.sh
# Công dụng: Quản lý chế độ nguồn (hiển thị + chuyển đổi)
# ============================================

# Hàm: Chuyển đổi chế độ nguồn (cycle)
cycle_profile() {
    CURRENT=$(powerprofilesctl get)
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
    powerprofilesctl set "$NEXT"
    notify-send "🔋 Chế độ nguồn" "Đã chuyển sang: $NEXT" -t 1000 2>/dev/null || true
}

# Hàm: Hiển thị thông tin pin (dành cho Waybar)
show_battery_info() {
    # Lấy thông tin pin
    BAT_PATH="/sys/class/power_supply/BAT0"
    if [ ! -d "$BAT_PATH" ]; then
        BAT_PATH="/sys/class/power_supply/BAT1"
    fi

    CAPACITY=$(cat "$BAT_PATH/capacity" 2>/dev/null)
    STATUS=$(cat "$BAT_PATH/status" 2>/dev/null)
    PROFILE=$(powerprofilesctl get 2>/dev/null)

    # Chọn icon theo dung lượng và trạng thái sạc
    if [ "$STATUS" = "Charging" ]; then
        # Đang sạc - dùng icon sạc có màu xanh
        ICON="<span color='#a6d189'>󱐋</span>"
    elif [ "$STATUS" = "Full" ]; then
        # Đã đầy - dùng icon đầy
        ICON="󰂄"
    else
        # Dùng icon theo mốc năng lượng
        if [ "$CAPACITY" -ge 95 ]; then
            ICON=""
        elif [ "$CAPACITY" -ge 75 ]; then
            ICON=""
        elif [ "$CAPACITY" -ge 50 ]; then
            ICON=""
        elif [ "$CAPACITY" -ge 25 ]; then
            ICON=""
        else
            ICON=""
        fi
    fi

    # Tooltip hiển thị thông tin chi tiết
    TOOLTIP="Pin: ${CAPACITY}%\nTrạng thái: ${STATUS}\nChế độ nguồn: ${PROFILE}"

    # Class CSS cho từng chế độ nguồn
    case "$PROFILE" in
        "performance") CLASS="performance" ;;
        "balanced")    CLASS="balanced" ;;
        "power-saver") CLASS="power-saver" ;;
        *)             CLASS="" ;;
    esac

    # Xuất JSON cho Waybar
    printf '{"text": "%s", "tooltip": "%s", "class": "%s", "alt": "%s"}\n' \
        "$ICON" "$TOOLTIP" "$CLASS" "$PROFILE"
}

# ============================================
# Xử lý argument
# ============================================
case "$1" in
    "cycle")
        # Chuyển đổi chế độ nguồn
        cycle_profile
        ;;
    "")
        # Mặc định: hiển thị thông tin pin (cho Waybar)
        show_battery_info
        ;;
    *)
        echo "Sử dụng: $0 [cycle]"
        echo "  cycle  : Chuyển đổi chế độ nguồn (power-saver → balanced → performance)"
        echo "  (không argument): Hiển thị thông tin pin dạng JSON cho Waybar"
        exit 1
        ;;
esac
