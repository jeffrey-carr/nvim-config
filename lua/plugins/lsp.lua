if not vim.g.jeff_enable_lsp then
  return {}
end

return {
  -- Mason core
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig + lspconfig (single-source server startup)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      local mlsp = require("mason-lspconfig")

      -- capabilities (safe if you don't use cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      pcall(function()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      end)

      -- format helper (prefer null-ls if present)
      local function lsp_format(bufnr)
        local has_null = false
        for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
          if c.name == "null-ls" then
            has_null = true; break
          end
        end
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = has_null and function(c) return c.name == "null-ls" end
              or function(c) return c.name ~= "null-ls" end,
        })
      end

      local on_attach = function(client, bufnr)
        vim.bo[bufnr].formatexpr = ""
        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function() lsp_format(bufnr) end,
            desc = "Format on save (prefers null-ls)",
          })
        end
      end

      local ensure = {
        "lua_ls", "html", "svelte", "cssls", "gopls", "ts_ls", "zls", "marksman",
      }

      -- Define handlers once
      local handlers = {
        -- default handler for any server without an override
        function(server)
          lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,

        -- per-server overrides:
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          })
        end,

        ["gopls"] = function()
          lspconfig.gopls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              gopls = {
                gofumpt = true,
                usePlaceholders = true,
                completeUnimported = true,
                analyses = { unusedparams = true },
              },
            },
          })
        end,
      }

      -- Back-compat: prefer the new API (handlers in setup), else fall back to setup_handlers()
      if mlsp.setup_handlers == nil then
        -- NEW style
        mlsp.setup({
          ensure_installed = ensure,
          automatic_installation = true,
          handlers = handlers,
        })
      else
        -- OLD style
        mlsp.setup({
          ensure_installed = ensure,
          automatic_installation = true,
        })
        mlsp.setup_handlers(handlers)
      end
    end,
  },

  -- Java via nvim-jdtls (start_or_attach per project)
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local ok, jdtls = pcall(require, "jdtls")
      if not ok then return end

      -- Resolve jdtls from Mason (optional but nice)
      local jdtls_bin, config_dir
      local ok_mr, mr = pcall(require, "mason-registry")
      if ok_mr then
        local pkg = mr.get_package("jdtls")
        if pkg and pkg:is_installed() then
          local base = pkg:get_install_path()
          jdtls_bin = base .. "/bin/jdtls"
          local sys = (vim.loop.os_uname().sysname == "Darwin") and "mac"
              or (vim.loop.os_uname().sysname == "Linux" and "linux" or "win")
          config_dir = base .. "/config_" .. sys
        end
      end

      -- Fallbacks if mason package isn’t present
      jdtls_bin = jdtls_bin or "jdtls"
      config_dir = config_dir or (vim.fn.stdpath("data") .. "/jdtls/config")

      local root_markers = { "gradlew", "mvnw", "pom.xml", ".git", "build.gradle", "settings.gradle", "build.gradle.kts" }
      local root_dir = jdtls.setup.find_root(root_markers) or vim.fn.getcwd()
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      pcall(function()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      end)

      local function lsp_format(bufnr)
        local has_null = false
        for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
          if c.name == "null-ls" then
            has_null = true; break
          end
        end
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = has_null and function(c) return c.name == "null-ls" end
              or function(c) return c.name ~= "null-ls" end,
        })
      end

      local function on_attach(client, bufnr)
        vim.bo[bufnr].formatexpr = ""
        if client.supports_method("textDocument/formatting") then
          local grp = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = grp,
            buffer = bufnr,
            callback = function() lsp_format(bufnr) end,
            desc = "Format on save (Java)",
          })
        end
        jdtls.setup_dap({ hotcodereplace = "auto" })
        jdtls.setup.add_commands()
      end

      local cmd = {
        jdtls_bin,
        "--jvm-arg=-Xms1g",
        "--jvm-arg=-Xmx2g",
        string.format("--jvm-arg=-Djdt.ls.java.home=%s", os.getenv("JAVA_HOME") or ""),
        "-configuration", config_dir,
        "-data", workspace_dir,
      }

      local config = {
        cmd = cmd,
        root_dir = root_dir,
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          java = {
            format = { enabled = true },
            signatureHelp = { enabled = true },
            configuration = { updateBuildConfiguration = "interactive" },
            completion = { guessMethodArguments = true },
          },
        },
        init_options = { bundles = {} },
      }

      local grp = vim.api.nvim_create_augroup("JeffJdtls", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = grp,
        pattern = "java",
        callback = function() jdtls.start_or_attach(config) end,
        desc = "Start/attach jdtls",
      })
    end,
  },
}
