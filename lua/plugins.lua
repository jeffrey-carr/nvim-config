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
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim"},
        config = function()
            -- This ensures telescope is configured right after it's loaded
            require("keymaps")  -- You can load keymaps after telescope is loaded
            require("telescope").setup()
        end,
    },
    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer", -- buffer auto-completion
            "hrsh7th/cmp-path", -- path auto-completion
            "hrsh7th/cmp-cmdline", -- cmdline auto-completion
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },
    -- Comments
    "numToStr/Comment.nvim",
    -- git blame stuff
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
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
    -- Indentation markers
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {
            indent = { char = "|" }
        },
    },
    -- Tests
    "fatih/vim-go",
    -- Todo list
    {
        "atiladefreitas/dooing",
        config = function()
            require("dooing").setup({})
        end
    },
    -- Rainbow delimiters
    "HiPhish/rainbow-delimiters.nvim",
    -- Zen mode 
    {
        "folke/twilight.nvim",
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
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
    -- Lualine
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            -- Custom Lualine component to show attached language server
            -- local clients_lsp = function()
            --     local clients = vim.lsp.get_clients()
            --     if next(clients) == nil then
            --         return ""
            --     end
            --
            --     local c = {}
            --     for _, client in pairs(clients) do
            --         table.insert(c, client.name)
            --     end
            --     return " " .. table.concat(c, "|")
            -- end

            require("lualine").setup({
                -- options = {
                --     theme = "dracula",
                --     component_separators = "",
                --     section_separators = { left = "AHHHHh", right = "" },
                --     disabled_filetypes = { "alpha", "Outline" },
                -- },
                -- sections = {
                --     lualine_a = {
                --         { "mode", separator = { left = " ", right = "" }, icon = "" },
                --     },
                --     lualine_b = {
                --         {
                --             "filetype",
                --             icon_only = true,
                --             padding = { left = 1, right = 0 },
                --         },
                --         "filename",
                --     },
                --     lualine_c = {
                --         {
                --             "branch",
                --             icon = "?",
                --         },
                --         {
                --             "diff",
                --             symbols = { added = " ", modified = " ", removed = " " },
                --             colored = false,
                --         },
                --     },
                --     lualine_x = {
                --         {
                --             "diagnostics",
                --             symbols = { error = " ", warn = " ", info = " ", hint = "" },
                --             update_in_insert = true,
                --         },
                --     },
                --     lualine_y = { clients_lsp },
                --     lualine_z = {
                --         { "location", separator = { left = "", right = " " }, icon = "" },
                --     },
                -- },
                -- inactive_sections = {
                --     lualine_a = { "filename" },
                --     lualine_b = {},
                --     lualine_c = {},
                --     lualine_x = {},
                --     lualine_y = {},
                --     lualine_z = { "location" },
                -- },
                -- extensions = { "toggleterm", "trouble" },
            })
        end
    },
    -- Themes
    "tanvirtin/monokai.nvim",
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

