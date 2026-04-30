#!/bin/bash

# Danh sách cổng
INTERNAL_MONITORS=("eDP-1" "eDP-2")
EXTERNAL_MONITORS=("DP-1" "DP-2" "DP-3")

update_monitors() {
    sleep 1
    # Lấy danh sách các màn hình đang kết nối từ wlr-randr
    CONNECTED_OUTPUTS=$(wlr-randr | grep -P "^[a-zA-Z0-9-]+" | cut -d' ' -f1)

    EXT_PORT=""
    for p in "${EXTERNAL_MONITORS[@]}"; do
        if echo "$CONNECTED_OUTPUTS" | grep -q "^$p$"; then
            EXT_PORT=$p
            break
        fi
    done

    INT_PORT=""
    for p in "${INTERNAL_MONITORS[@]}"; do
        if echo "$CONNECTED_OUTPUTS" | grep -q "^$p$"; then
            INT_PORT=$p
            break
        fi
    done

    if [ -n "$EXT_PORT" ]; then
        # Bật màn rời, tắt màn laptop
        wlr-randr --output "$EXT_PORT" --on --output "$INT_PORT" --off
    else
        # Bật lại màn laptop khi không có màn rời
        wlr-randr --output "$INT_PORT" --on
    fi
}

# Chạy lần đầu
update_monitors

# Lắng nghe sự kiện qua udev
udevadm monitor --subsystem-match=drm --property | while read -r line; do
    if echo "$line" | grep -q "HOTPLUG=1"; then
        update_monitors
    fi
done
