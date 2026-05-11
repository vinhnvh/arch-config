local packages = {
    "vm-curator",
    "qemu-full",
    "swtpm",
    "edk2-ovmf",
    "libvirt",


}

return {
    description = "Sazv's vm curator",
    conflicts = {},
    dotfiles_sync = false,
    packages = packages,
}
