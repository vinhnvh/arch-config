if status is-interactive
# Commands to run in interactive sessions can go here
set -g fish_greeting ""
starship init fish | source
# fastfetch -c ~/.config/fastfetch/themes/config.jsonc

end
if status is-login
    set -Ux GTK_IM_MODULE fcitx
    set -Ux QT_IM_MODULE fcitx
    set -Ux XMODIFIERS @im=fcitx
    set -Ux SDL_IM_MODULE fcitx
    set -Ux GLFW_IM_MODULE ibus
end
