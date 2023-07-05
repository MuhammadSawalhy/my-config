local dap = require("dap")
local tableUtils = require("utils.table")
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
  lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = "lldb"
  },
}

local bashCommonConfig = {
  type = 'bashdb',
  request = 'launch',
  program = '${file}',
  cwd = vim.fn.getcwd(),
  protocol = 'inspector',
  console = 'integratedTerminal',
  pathBashdb = vim.g.plug_home .. '/vscode-bash-debug/bashdb_dir/bashdb',
  pathBashdbLib = vim.g.plug_home .. '/vscode-bash-debug/bashdb_dir',
  pathMkfifo = 'mkfifo',
  pathPkill = 'pkill',
  pathBash = 'bash',
  pathCat = 'cat',
  env = {
    BASHDB_HOME = vim.g.plug_home .. '/vscode-bash-debug/bashdb_dir',
  },
}

local lldbCommonConfig = {
  type = "lldb",
  request = "launch",
  program = function()
    local exefile = vim.fn.expand('%:p:r')
    if not vim.fn.filereadable(exefile) then
      exefile = vim.fn.getcwd() .. '/'
    end
    return vim.fn.input('Path to executable: ', exefile, 'file')
  end,
  cwd = '${relativeFileDirname}',
  stopOnEntry = false,
  args = {},

  -- 💀
  -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
  --
  --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
  --
  -- Otherwise you might get the following error:
  --
  --    Error on launch: Failed to attach to the target process
  --
  -- But you should be aware of the implications:
  -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
  runInTerminal = false,

  -- 💀
  -- If you use `runInTerminal = true` and resize the terminal window,
  -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
  -- To avoid that uncomment the following option
  -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
  postRunCommands = {'process handle -p true -s false -n false SIGWINCH'},
}

local config = {
  node = {
    {
      name = 'Debug with args',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end;
    },
    {
      name = 'Debug file',
      type = 'node2',
      request = 'launch',
      program = '${file}',
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
      program = "${file}",
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
    tableUtils.combine(bashCommonConfig, {
      name = 'Launch file with arguments',
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end,
    }),
    tableUtils.combine(bashCommonConfig, {
      name = 'Launch file',
    }),
  },
  lldb = {
    tableUtils.combine(lldbCommonConfig, {
      name = 'Launch file with arguments',
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end,
    }),

    tableUtils.combine(lldbCommonConfig, {
      name = 'Launch file',
    }),
  },
}

dap.configurations = {
  javascript = config.node,
  javascriptreact = config.chrome,
  typescriptreact = config.chrome,
  bash = config.bash,
  sh = config.bash,
  vim = config.vim,
  rust = config.lldb,
  cpp = config.lldb,
  c = config.lldb,
}

require('dap.ext.vscode').load_launchjs()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require('dap-python').test_runner = 'pytest'

table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Django',
  program = vim.fn.getcwd() .. '/manage.py',
  args = {'runserver', '--noreload'},
})

for _, configs in pairs(dap.configurations) do
  for _, conf in ipairs(configs) do
    conf["justMyCode"] = false
  end
end

