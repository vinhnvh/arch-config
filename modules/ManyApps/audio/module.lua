local packages = {
    "pipewire-alsa",
    "pipewire-jack",
    "pipewire-pulse",
    "gst-plugin-pipewire",
    "wireplumber",

    -- Trình phát nhạc
    "mpd",
    "mpc",
    "rmpc",

}

return {
    description = "Sazv's audio setup",
    conflicts = {},
    dotfiles_sync = false,
    packages = packages,
}
