local packages = {
    -- Niri window manager
    "mangowm-git",

    -- Build dependencies for Niri and related tools
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
    dotfiles_sync = false,
    packages = packages,
}
