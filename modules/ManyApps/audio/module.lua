local packages = {
    "pipewire-alsa",
    "pipewire-jack",
    "pipewire-pulse",
    "gst-plugin-pipewire",
    "wireplumber",
    "pipewire-v4l2"
}

return {
    description = "Sazv's audio setup",
    conflicts = {},
    dotfiles_sync = false,
    packages = packages,
}
