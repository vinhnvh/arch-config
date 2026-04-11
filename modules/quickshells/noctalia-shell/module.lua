local packages = {
    -- Noctalia quickshells for Niri(mb hypr or mangowc....) --
    "noctalia-shell-git",
    "cava",
    "matugen",
    "wlsunset",
    "cliphist",
    "ddcutil",
    "evolution-data-server",
    "python",

    -- Build dependencies for Niri and related tools
    "cmake",
    "git",

    -- Fonts --
    "maple-mono-nf-cn-unhinted",
}

return {
    description = "Fully featured noctalia-shell for Niri window manager and related tools.",
    conflicts = {},
    dotfiles_sync = true,
    packages = packages,
}
