if not vim.g.jeff_enable_go_testing then
  return {}
end

-- LEADING KEY = d

return {
  -- Testing (dt)
  {
    "nvim-neotest/neotest",
    ft = { "go", "gomod" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        build = function()
          vim.system({"go", "install", "gotest.tools/gotestsum@latest"}):wait()
        end,
      },
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-golang")({
            runner = "gotestsum",
            testify_enabled = true,
          })
        },
      })

      vim.keymap.set('n', '<leader>dtr', function()
        neotest.output_panel.open()
        neotest.run.run()
      end, { desc = "Run nearest test" })
      vim.keymap.set('n', '<leader>dta', function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Run all tests" })
      vim.keymap.set('n', '<leader>dts', function()
        neotest.summary.toggle()
      end, { desc = "Toggle neotest summary" })
      vim.keymap.set('n', '<leader>dto', function()
        neotest.output_panel.toggle()
      end, { desc = "Toggle test output" })
    end
  },


  -- Debugging (dd)
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, opts)
      require("dap-go").setup(opts)
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.5 },
              { id = "watches", size = 0.5 },
            },
            position = "left",
            size = 0.33,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10
          }
        }
      })

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = "Add breakpoint at line" })
      vim.keymap.set('n', '<leader>dds', function()
        require("dapui").toggle()
      end, { desc = "Debug toggle sidebar" })
      vim.keymap.set('n', '<leader>ddt', function()
        require("dap-go").debug_test()
      end, { desc = "Delve debug test" })
      vim.keymap.set('n', '<leader>ddl', function()
        require("dap-go").debug_last()
      end, { desc = "Delve debug last" })
      vim.keymap.set('n', '<leader>ddo', '<cmd> DapStepOver <CR>', { desc = "Step over" })
      vim.keymap.set('n', '<leader>ddO', '<cmd> DapStepOut <CR>', { desc = "Step out" })
      vim.keymap.set('n', '<leader>ddi', '<cmd> DapStepInto <CR>', { desc = "Step into" })
      vim.keymap.set('n', '<leader>ddc', function()
        require('dap').continue()
      end, { desc = "Continue debugging" })
      vim.keymap.set('n', '<leader>ddx', function()
        require('dap').terminate()
      end, { desc = "Terminate debugging" })
    end,
  },
}

