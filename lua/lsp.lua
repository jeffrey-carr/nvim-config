-- Mason setup for LSP management
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

-- Set different settings for each language's LSP
local lspconfig = require('lspconfig')

-- Customized on_attach function
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Check and safely unmap <C-k> for LSP buffers
    pcall(vim.keymap.del, "n", "<C-k>", { buffer = bufnr })

    -- Add other LSP mappings
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
                return client.name == "null-ls" or client.name == "hls" or client.name == "rust_analyzer"
            end,
        })
    end, bufopts)
    -- Show signature hints
    vim.keymap.set("n", "<C-Space", vim.lsp.buf.signature_help, { desc="Signature hint"})

    -- gopls settings
    if client.name == 'gopls' then
        client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = {
                tokenTypes = { 'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter', 'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method', 'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator', 'decorator' },
                tokenModifiers = { 'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract', 'async', 'modification', 'documentation', 'defaultLibrary'}
            },
        }
    end
end

-- Configure language servers
lspconfig.pylsp.setup({ on_attach = on_attach })
lspconfig.gopls.setup({
    on_attach = on_attach,
    settings = {
        gopls = {
            semanticTokens = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        }
    }
 })
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

-- Autocommand for organizing imports and formatting Go files on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- Adjust timeout as needed (default: 1000ms)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        -- Format the file after organizing imports
        vim.lsp.buf.format({ async = false })
    end,
})
