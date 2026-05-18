#!/usr/bin/env bash

# --- Môi trường cho notify-send trên Wayland ---
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0

# --- Cấu hình chung ---
STEP=5
DEFAULT_SINK="@DEFAULT_AUDIO_SINK@"
DEFAULT_SOURCE="@DEFAULT_AUDIO_SOURCE@"

# --- Hàm âm lượng ---
get_current_volume() {
    wpctl get-volume "$DEFAULT_SINK" | awk '{printf("%d\n", $2 * 100)}'
}

send_volume_notification() {
    volume=$(get_current_volume)
    if wpctl get-volume "$DEFAULT_SINK" | grep -q "MUTED"; then
        notify-send -a "state" -i "audio-volume-muted" -h int:value:"$volume" -h string:synchronous:unique-volume-slider "Volume: Muted"
    else
        notify-send -a "state" -i "audio-volume-high" -h int:value:"$volume" -h string:synchronous:unique-volume-slider "Volume: ${volume}%"
    fi
}

# --- Hàm độ sáng ---
send_brightness_notification() {
    brightness=$(brightnessctl info | grep -oP '(?<=\()\d+(?=%)')
    notify-send -a "state" -i "weather-clear" -h int:value:"$brightness" -h string:synchronous:unique-brightness-slider "Brightness: ${brightness}%"
}

# --- Hàm mic ---
get_current_mic_volume() {
    wpctl get-volume "$DEFAULT_SOURCE" | awk '{printf("%d\n", $2 * 100)}'
}

send_mic_notification() {
    volume=$(get_current_mic_volume)
    if wpctl get-volume "$DEFAULT_SOURCE" | grep -q "MUTED"; then
        notify-send -a "state" -i "microphone-sensitivity-muted" -h int:value:"$volume" -h string:synchronous:unique-mic-slider "Microphone: Muted"
    else
        notify-send -a "state" -i "microphone-sensitivity-high" -h int:value:"$volume" -h string:synchronous:unique-mic-slider "Microphone: ${volume}%"
    fi
}

# --- Xử lý tham số dạng: notification-control.sh [volume|brightness] [up|down|mute] ---
case $1 in
    volume)
        case $2 in
            up)
                wpctl set-volume "$DEFAULT_SINK" "$STEP"%+ -l 1.0
                send_volume_notification
                ;;
            down)
                wpctl set-volume "$DEFAULT_SINK" "$STEP"%- -l 1.0
                send_volume_notification
                ;;
            mute)
                # wpctl set-volume "$DEFAULT_SINK" 0.5
                wpctl set-mute "$DEFAULT_SINK" toggle
                send_volume_notification
                ;;
            *)
                echo "Usage: $0 volume {up|down|mute}"
                exit 1
                ;;
        esac
        ;;
    brightness)
        case $2 in
            up)
                brightnessctl set +"$STEP"%
                send_brightness_notification
                ;;
            down)
                brightnessctl set "$STEP"%-
                send_brightness_notification
                ;;
            *)
                echo "Usage: $0 brightness {up|down}"
                exit 1
                ;;
        esac
        ;;
    mic)
        case $2 in
            mute)
                wpctl set-mute "$DEFAULT_SOURCE" toggle
                send_mic_notification
                ;;
            up)
                wpctl set-volume "$DEFAULT_SOURCE" "$STEP"%+ -l 1.0
                send_mic_notification
                ;;
            down)
                wpctl set-volume "$DEFAULT_SOURCE" "$STEP"%- -l 1.0
                send_mic_notification
                ;;
            *)
                echo "Usage: $0 mic {mute|up|down}"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 {volume|brightness|mic} {up|down|mute}"
        exit 1
        ;;
        esac
