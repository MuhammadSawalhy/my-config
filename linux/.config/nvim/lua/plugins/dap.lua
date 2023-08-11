return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'nvim-telescope/telescope-dap.nvim',
    { 'rcarriga/nvim-dap-ui', opts = {} },
    {
      'theHamsta/nvim-dap-virtual-text',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      opts = {}
    },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('telescope').load_extension('dap')

    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '🟤', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })

    require('mason-nvim-dap').setup {
      automatic_setup = true,

      handlers = {
        -- NOTE: you should make sure that gdb is installed
        cppdbg = function(config)
          config.configurations = {
            {
              name = 'Compile and launch file',
              type = 'cppdbg',
              request = 'launch',
              program = function()
                local file = vim.fn.expand('%:p')
                local exefile = vim.fn.expand('%:p:r')
                os.execute(string.format([[g++ -g "%s" -o "%s"]], file, exefile))
                return exefile
              end,
              cwd = '${fileDirname}',
              stopAtEntry = true,
            },
            {
              name = 'Launch file',
              type = 'cppdbg',
              request = 'launch',
              program = function()
                local exefile = vim.fn.expand('%:p:r')
                if not vim.fn.filereadable(exefile) then
                  exefile = vim.fn.getcwd() .. '/'
                end
                return vim.fn.input('Path to executable: ', exefile, 'file')
              end,
              cwd = '${fileDirname}',
              stopAtEntry = true,
            },
          }

          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
      },
    }

    local nmap = function(keys, func, desc)
      if desc then desc = 'Debug: ' .. desc end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    -- Basic debugging keymaps, feel free to change to your liking!
    nmap('<F5>', dap.continue, 'Start/Continue')
    -- Toggle to see last session result. Without this,
    -- you can't see session output in case of unhandled exception.
    nmap('<F7>', dapui.toggle, 'See last session result.')
    nmap('<F10>', dap.step_over, 'Step Over')
    nmap('<F11>', dap.step_into, 'Step Into')
    nmap('<F23>', dap.step_out, 'Step Out') -- shift + f11
    nmap('<leader>b', dap.toggle_breakpoint, 'Toggle Breakpoint')
    nmap('<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, 'Set Conditional Breakpoint')

    nmap('<leader>dc', ':Telescope dap commands<CR>', 'Telescope dap commands')
    nmap('<leader>db', ':Telescope dap list_breakpoints<CR>', 'Telescope list breakpoints')
    nmap('<leader>du', dapui.toggle, 'Toggle dap UI')
    nmap('<leader>de', dapui.eval, 'Evaluate under cursor')
    nmap('<leader>dE', function()
      dapui.eval(vim.fn.input('Expression: '))
    end, 'Input an expression to evaluate')

    vim.keymap.set('v', '<leader>de', dapui.eval, { desc = "Debug : Evaluate selection" })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()
  end,
}
