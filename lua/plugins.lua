local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- File browsing
    "nvim-lua/plenary.nvim",
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = "all",
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim"},
        config = function()
            -- This ensures telescope is configured right after it's loaded
            require("keymaps")  -- You can load keymaps after telescope is loaded
            require("telescope").setup()
        end,
    },
    -- Comments
    "numToStr/Comment.nvim",
    -- Auto-complete brackets
    {
        "m4xshen/autoclose.nvim",
        config = function()
            require("autoclose").setup()
        end
    },
    -- surround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    -- Zen mode 
    {
        "folke/twilight.nvim",
        opts = {},
    },
    -- Auto complete HTML tags
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({})
        end
    },
    -- Auto formatter
    "sbdchd/neoformat",
    -- Notifications
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify")
        end
    },
    "wesQ3/vim-windowswap",
    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function() 
            require("leap").create_default_mappings()
        end
    },
    -- Themes
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "storm",
            })
        end
    },
})

