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

function rm --wraps mv --description "rm to trash"
    mv $argv ~/.trash
end

status --is-interactive; and rbenv init - fish | source
