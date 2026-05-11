if status is-interactive
# Commands to run in interactive sessions can go here
set -g fish_greeting ""
starship init fish | source
# fastfetch -c ~/.config/fastfetch/themes/config.jsonc
set -gx EDITOR nvim
end
if status is-login
    set -Ux GTK_IM_MODULE fcitx
    set -Ux QT_IM_MODULE fcitx
    set -Ux XMODIFIERS @im=fcitx
    set -Ux SDL_IM_MODULE fcitx
    set -Ux GLFW_IM_MODULE ibus
end
function fish_greeting
    set_color cyan # Thêm màu cho mèo nếu muốn
    printf "\n"
    printf "      |\\      _,,,---,,_ \n"
    printf "ZZZzz /,`.-'`'    -.  ;-;;,_\n"
    printf "     |,4-  ) )-,_. ,\\ (  `'-'\n"
    printf "    '---''(_/--'  `-'\\_)  \n"
    set_color normal
end
