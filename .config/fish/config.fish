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

zoxide init fish | source


status --is-interactive;


