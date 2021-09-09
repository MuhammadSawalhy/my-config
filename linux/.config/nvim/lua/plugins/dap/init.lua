local dap = require("dap")
require('telescope').load_extension('dap')
require("dapui").setup()

-- vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='red', linehl='', numhl=''})
-- vim.fn.sign_define('DapBreakpointRejected', {text='⭕️', texthl='red', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='', texthl='➡️', linehl='', numhl=''})

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
  bash = {
    type = "executable",
    command = "bash",
    args = {"--debugger"}
  }
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
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  },
  bash = {
    type = 'bash',
    request = 'launch',
    program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
  }
}

dap.configurations = {
  javascript = config.node,
  javascriptreact = config.chrome,
  typescriptreact = config.chrome,
  bash = config.bash,
}

require('dap.ext.vscode').load_launchjs()
