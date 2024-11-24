require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        'pylsp',
        'lua_ls',
        'cssls',
        'eslint',
        'gopls',
        'html',
        'nextls',
        'ts_ls',
    },
})

-- Set different settings for each languages' LSP
local lspconfig = require('lspconfig')

-- Customized on_attach function
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.name == "rust_analyzer" then
        -- Requires Neovim 0.10 or later
        vim.lsp.inlay_hint.enable()
    end

    -- Unmap Ctrl-k for LSP buffers
    vim.keymap.del("n", "<C-k>", { buffer = bufnr })

    -- Add LSP-specific mappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-S-k>", vim.lsp.buf.signature_help, bufopts) -- New mapping for signature help
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({
            async = true,
            filter = function(client)
                -- If an LSP contains a formatter, use that instead of null-ls.
                return client.name == "null-ls" or client.name == "hls" or client.name == "rust_analyzer"
            end,
        })
    end, bufopts)
end

-- Configure language servers
lspconfig.pylsp.setup({ on_attach = on_attach })
lspconfig.gopls.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
})
lspconfig.cssls.setup({ on_attach = on_attach })
lspconfig.eslint.setup({ on_attach = on_attach })
lspconfig.html.setup({ on_attach = on_attach })
lspconfig.nextls.setup({ on_attach = on_attach })
lspconfig.ts_ls.setup({ on_attach = on_attach })
