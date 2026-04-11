local packages = {
    "fcitx5",
    "fcitx5-gtk",
    "fcitx5-qt",
    "fcitx5-configtool",
    "fcitx5-lotus-bin",
}

return {
    description = "Bo go tieng Viet voi fcitx5 lotus",
    conflicts = {"ibus"},
    dotfiles_sync = true,
    post_install_hook = "scripts/setup-lotus.sh",
    hook_behavior = "ask",
    packages = packages,
}
