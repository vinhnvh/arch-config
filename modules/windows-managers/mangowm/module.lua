local packages = {
    -- Niri window manager
    "mangowm-git",
    "xdg-desktop-portal-wlr",

    -- Build dependencies for Mango and related tools
    "cmake",
    "git",

    -- Default applications
    "kitty",
    "fastfetch",
    "fish",

    -- Fonts --
    "maple-mono-nf-cn-unhinted",

    -- Mouse cursor themes
    "bibata-cursor-theme",
}

return {
    description = "Hyprland Wayland compositor with defaults",
    conflicts = {},
    dotfiles_sync = true,
    packages = packages,
}
