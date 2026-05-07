local packages = {
    "waydroid",
    "lzip",
    --"vm-curator",
    --"qemu-full",
    --"swtpm",
    --"libvirt",


}

return {
    description = "Sazv's vm curator",
    conflicts = {},
    dotfiles_sync = false,
    packages = packages,
}
