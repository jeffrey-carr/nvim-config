# Welcome
Thank you for checking out my Neovim setup.

# Required Dependencies
- [Ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file)
    - `brew install ripgrep`
- [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)
    - `brew install fd`
- cmake
    - `brew install cmake`
    - This is required for the `fd` plugin to successfully build
- Link `fzf` and `fd` by adding the following environment variables to your `.zsrhc` (or whatever shell you use)
    - ```
        # Link fzf with fd
        export FZF_DEFAULT_COMMAND="fd . $HOME"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      ```

