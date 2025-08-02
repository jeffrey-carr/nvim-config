local jdtls = require("jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local java_home = vim.fn.system("echo -n $(/usr/libexec/java_home)")

local config = {
  cmd = { "jdtls", "-data", workspace_dir },
  root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = java_home,
          },
        },
      },
    },
  },
}

jdtls.start_or_attach(config)

