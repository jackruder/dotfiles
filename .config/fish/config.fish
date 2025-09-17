if status is-interactive
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursor to an underscore
    set fish_cursor_replace_one underscore
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block
end

function fish_greeting
    echo "Fish taste weird"
    # Emulates vim's cursor shape behavior

end

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

function trash --wraps mv --description "rm to trash"
    mv $argv ~/.trash
end

# include following in .bashrc / .bash_profile / .zshrc
# usage
# $ mkvenv myvirtualenv # creates venv under ~/.virtualenvs/
# $ venv myvirtualenv   # activates venv
# $ deactivate          # deactivates venv
# $ rmvenv myvirtualenv # removes venv

export VENV_HOME="$HOME/.virtualenvs"

function lsvenv
    ls -1 $VENV_HOME
end

function venv
    if set -q argv[1]
        source $VENV_HOME/$argv[1]/bin/activate.fish
    else
        echo "Please provide venv name"
    end
end

function mkvenv
    if set -q argv[1]
        python3 -m venv $VENV_HOME/$argv[1]
    else
        echo "Please provide venv name"
    end
end

function rmvenv
    if set -q argv[1]
        rm -r $VENV_HOME/$argv[1]
    else
        echo "Please provide venv name"
    end
end
#### END VENV wrapper

alias r "R_AUTO_START=true nvim"

zoxide init fish | source

#poetry completions fish >~/.config/fish/completions/poetry.fish
pixi completion --shell fish | source

status --is-interactive

### Colors

function toggle-theme-light
    set -U THEME "Rosé Pine Dawn"
    fish_config theme choose "Rosé Pine Dawn"
    set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#797593,bg:#faf4ed,hl:#d7827e
    --color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
    --color=border:#dfdad9,header:#286983,gutter:#faf4ed
    --color=spinner:#ea9d34,info:#56949f
    --color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
    # kitty +kitten themes --reload-in=all $THEME
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
end

function toggle-theme-dark
    fish_config theme choose "Rosé Pine"
    set -U THEME "Rosé Pine"
    set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#908caa,bg:#191724,hl:#ebbcba
    --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
    --color=border:#403d52,header:#31748f,gutter:#191724
    --color=spinner:#f6c177,info:#9ccfd8
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
    # kitty +kitten themes --reload-in=all $THEME
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
end
toggle-theme-dark

# ~/.config/fish/functions/fzf.fish
function fzf --wraps="fzf"
    # Paste contents of preferred variant here

    command fzf
end

# EXPORT NVIDIA VARS
if lsmod | grep -q nvidia
    set -gx LD_LIBRARY_PATH /opt/cuda/lib64/ $LD_LIBRARY_PATH
    set -gx LD_LIBRARY_PATH /opt/TensorRT-8.6.1.6 $LD_LIBRARY_PATH
    set -gx LD_LIBRARY_PATH /opt/oneapi_dpcpp_sycl_cuda/lib $LD_LIBRARY_PATH
    set -gx PATH /opt/oneapi_dpcpp_sycl_cuda/bin $PATH
    set -gx PATH /opt/cuda $PATH
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
fish_add_path /home/jackman/.pixi/bin
