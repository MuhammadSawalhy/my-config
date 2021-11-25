local dap = require("dap")
require('telescope').load_extension('dap')
require("dapui").setup()

vim.fn.sign_define('DapBreakpoint', {text='●', texthl='red', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='◆', texthl='red', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='', texthl='▶', linehl='', numhl=''})

dap.adapters = {
  node2 = {
    type = 'executable',
    command = 'node',
    args = {vim.g.plug_home .. '/vscode-node-debug2/out/src/nodeDebug.js'},
  },
  chrome = {
    type = "executable",
    command = "node",
    args = {vim.g.plug_home .. "/vscode-chrome-debug/out/src/chromeDebug.js"}
  },
  bashdb = {
    type = "executable",
    command = "node",
    args = {vim.g.plug_home .. "/vscode-bash-debug/out/bashDebug.js"}
  },
}

local config = {
  node = {
    {
      type = 'node2',
      request = 'launch',
      program = '${workspaceFolder}/${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    }
  },
  chrome = {
    {
      type = "chrome",
      request = "attach",
      program = "${workspaceFolder}/${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = function()
        local value = vim.fn.input('Port [9222]: ')
        if value ~= "" then
          value = tonumber(value)
          assert(value, "Please provide a port number")
          return value
        end
        return 9222
      end,
      webRoot = "${workspaceFolder}"
    }
  },
  bash = {
    {
      type = 'bashdb',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      args = {},
      env = {
        BASHDB_HOME = vim.g.plug_home .. '/vscode-bash-debug/bashdb_dir',
      },
      protocol = 'inspector',
      console = 'integratedTerminal',
      pathBashdb = vim.g.plug_home .. '/vscode-bash-debug/bashdb_dir/bashdb',
      pathBashdbLib = vim.g.plug_home .. '/vscode-bash-debug/bashdb_dir',
      pathMkfifo = 'mkfifo',
      pathPkill = 'pkill',
      pathBash = 'bash',
      pathCat = 'cat',
    }
  },
}

dap.configurations = {
  javascript = config.node,
  javascriptreact = config.chrome,
  typescriptreact = config.chrome,
  bash = config.bash,
  sh = config.bash,
  vim = config.vim,
}

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require('dap-python').test_runner = 'pytest'
require('dap.ext.vscode').load_launchjs()
