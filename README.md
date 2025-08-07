Hello! This is my neovim config, built from the ground up. Make sure you install the required dependencies

# Dependencies
Here's a handy command to install all: `brew install jdftls fd fzf ripgrep tree-sitter`
- `jdftls`
    - LSP for Java development
    - `brew install jdftls`
- `fd`
    - Fuzzy finding (I think?)
    - `brew install fd`
- `fzf`
    - More fuzzy finding
    - `brew install fzf`
- `ripgrep`
    - Faster grep
    - `brew install ripgrep`
- `tree-sitter`
    - Idk
    - `brew install tree-sitter`

# Wants
- Lualine
    - Or just git info in terminal
    - But don't slow down boot time
- AI agent
- Better merge conflict resolver
- Better command-line completion
    - Ignore caps, `_`, etc.
- Tmux symbol when leader is active
- Different key to suggest zsh-autocompletes (CTRL-Tab?)
- Telescope sorting
    - Implementations before interfaces
- Figure out why sometimes `\fr` finds multiple references on the same line
- Get implementation comments in context menu
- Smearcursor
- Treesitter context (see slack messages with Brian)
