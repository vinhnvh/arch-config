#!/bin/bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Installing Lotus Input Method ===${NC}"
echo ""

# Kiểm tra quyền root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: This script must be run with sudo${NC}" >&2
  exit 1
fi

# 1. Kích hoạt Lotus Server
echo -e "${BLUE}1. Enabling Lotus Server...${NC}"
run_with_sudo systemd-sysusers
run_with_sudo systemctl enable --now "fcitx5-lotus-server@$(whoami).service"
echo -e "${GREEN}✓ Lotus Server enabled${NC}"

# 2. Dọn dẹp Ibus
echo -e "${BLUE}2. Cleaning Ibus...${NC}"
killall ibus-daemon 2>/dev/null || ibus exit 2>/dev/null || true
echo -e "${GREEN}✓ Ibus cleaned${NC}"

# 3. Thiết lập biến môi trường cho fish shell
echo -e "${BLUE}3. Setting up fish environment...${NC}"
FISH_CONFIG="$HOME/.config/fish/config.fish"
mkdir -p "$(dirname "$FISH_CONFIG")"

if ! grep -q "GTK_IM_MODULE fcitx" "$FISH_CONFIG" 2>/dev/null; then
    cat << 'EOF' >> "$FISH_CONFIG"
if status is-login
    set -Ux GTK_IM_MODULE fcitx
    set -Ux QT_IM_MODULE fcitx
    set -Ux XMODIFIERS @im=fcitx
    set -Ux SDL_IM_MODULE fcitx
    set -Ux GLFW_IM_MODULE fcitx   # Đã sửa theo yêu cầu
end
EOF
    echo -e "${GREEN}✓ Added environment variables to fish config${NC}"
else
    echo -e "${YELLOW}⚠ Environment variables already exist in fish config${NC}"
fi

# 4. Cấu hình niri (spawn fcitx5)
echo -e "${BLUE}4. Configuring niri...${NC}"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"
NIRI_SPAWNS="$HOME/.config/niri/spawns.kdl"

if [ -f "$NIRI_CONFIG" ]; then
    # Thêm include "spawns.kdl" nếu chưa có
    if ! grep -q 'include "spawns\.kdl"' "$NIRI_CONFIG"; then
        echo 'include "spawns.kdl"' >> "$NIRI_CONFIG"
        echo -e "${GREEN}✓ Added 'include \"spawns.kdl\"' to config.kdl${NC}"
    else
        echo -e "${YELLOW}⚠ 'include \"spawns.kdl\"' already exists in config.kdl${NC}"
    fi

    # Tạo file spawns.kdl nếu chưa có
    touch "$NIRI_SPAWNS"

    # Thêm spawn-at-startup cho fcitx5 nếu chưa có
    if ! grep -q 'spawn-at-startup "fcitx5" "-d"' "$NIRI_SPAWNS"; then
        echo 'spawn-at-startup "fcitx5" "-d"' >> "$NIRI_SPAWNS"
        echo -e "${GREEN}✓ Added fcitx5 spawn to spawns.kdl${NC}"
    else
        echo -e "${YELLOW}⚠ fcitx5 spawn already exists in spawns.kdl${NC}"
    fi
else
    echo -e "${RED}✗ niri config file not found at $NIRI_CONFIG${NC}"
    echo -e "${YELLOW}  Skipping niri autostart configuration.${NC}"
fi

echo ""
echo -e "${GREEN}=== Done! Please relog or reboot to apply changes ===${NC}"
