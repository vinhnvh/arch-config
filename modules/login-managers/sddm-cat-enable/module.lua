local packages = {
    "sddm",
    "unzip",
    "qt6-svg",
    "qt6-declarative",
    "qt5-quickcontrols2",
}

return {
    description = "SDDM login manager with Catppuccin theme (12-hour time)",
    conflicts = {""},
    post_install_hook = "scripts/enable-sddm.sh",
    hook_behavior = "once",
    packages = packages,
}
