local packages = {
    "zed",
    "brave-origin-nightly-bin",
    "yazi",
    "neovim",
    "kitty",
    "fastfetch",
    "fish",
    "starship",
}

return {
    description = "SazV need these apps to work, so they are must have",
    conflicts = {},
    dotfiles_sync = true,
    packages = packages,
}
