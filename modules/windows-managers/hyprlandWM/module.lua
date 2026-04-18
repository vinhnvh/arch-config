local packages = {
    -- Niri window manager
    "hyprland",
    "xdg-desktop-portal-hyprland",

    -- Build dependencies for Hyprland and related tools
    "cmake",
    "git",

    -- Default applications
    "kitty",
    "fastfetch",
    "fish",

    -- Fonts --
    "maple-mono-nf-cn-unhinted",
}

return {
    description = "Hyprland Wayland compositor with defaults",
    conflicts = {},
    dotfiles_sync = true,
    packages = packages,
}
