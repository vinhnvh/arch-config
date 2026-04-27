local packages = {
    -- Ricing this shiet for my self) --
    "eww-git",
    -- Build dependencies for Niri and related tools
    "cmake",
    "git",

    -- Fonts --
    "maple-mono-nf-cn-unhinted",
}

return {
    description = "Just ricing my shell for myself, nothing fancy.",
    conflicts = {},
    dotfiles_sync = true,
    packages = packages,
}
