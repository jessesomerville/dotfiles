set fish_greeting # Disable welcome prompt

# Configure shell PATH
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.go/bin"
fish_add_path "$(~/.go/bin/go env GOPATH)/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.npm-global/bin"

set -gx LANG "en_US.UTF-8"
set -gx FZF_DEFAULT_OPTS "--height 20% --border"

source (dirname (status --current-filename))/aliases.fish

# Interactive-shell-only configs
if status is-interactive
    history merge # Share history across open shells

    starship init fish | source
end
