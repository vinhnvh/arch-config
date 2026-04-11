local packages = {
    -- Niri window manager
    "niri",
    "xwayland-satellite",
    "xdg-desktop-portal-gnome",

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
    description = "Niri scrollable-tiling Wayland compositor with defaults",
    conflicts = {},
    dotfiles_sync = true,
    packages = packages,
}
