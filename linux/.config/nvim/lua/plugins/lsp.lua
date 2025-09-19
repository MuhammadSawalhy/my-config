return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',

      {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
          require('conform').setup {
            formatters_by_ft = {
              lua = { 'stylua' },
              python = { 'black', 'isort' },
              javascript = { 'prettierd', 'prettier' },
              go = { 'gofmt', 'goimports' },
              shell = { 'beautysh' },
            },
            format_on_save = {
              lsp_fallback = true,
              timeout_ms = 500,
            },
          }

          vim.api.nvim_create_user_command('Format', function()
            require('conform').format { lsp_fallback = true, timeout_ms = 500 }
          end, { desc = 'Format with conform.nvim' })
        end,
      },

      {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-treesitter/nvim-treesitter',
        },
        config = function()
          require('refactoring').setup {}
          require('telescope').load_extension 'refactoring'

          vim.keymap.set({ 'n', 'x' }, ';rr', require('telescope').extensions.refactoring.refactors, { desc = 'LSP: Refactor (telescope)' })
        end,
      },

      -- Useful status updates for LSP
      -- TODO: move to the new version
      { 'j-hui/fidget.nvim', tag = 'legacy' },

      -- Additional lua configuration!
      'folke/neodev.nvim',

      -- LSP UI
      {
        'nvimdev/lspsaga.nvim',
        config = function()
          require('lspsaga').setup {
            ui = {
              border = 'rounded',
            },
            symbol_in_winbar = {
              enable = false,
            },
            lightbulb = {
              enable = false,
            },
          }
        end,
      },
    },

    config = function()
      -- Diagnostic symbols in the sign column (gutter)
      local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end

      vim.diagnostic.config {
        virtual_text = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
      }

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', '<CMD>Lspsaga diagnostic_jump_prev<cr>', { desc = 'LSP: Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', '<CMD>Lspsaga diagnostic_jump_next<cr>', { desc = 'LSP: Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'LSP: Open diagnostics list' })
      vim.keymap.set('n', ';rn', '<CMD>Lspsaga rename<CR>', { desc = 'LSP: [R]e[n]ame' })
      vim.keymap.set({ 'n', 'v' }, ';ac', '<CMD>Lspsaga code_action<cr>', { desc = 'LSP: Code [Ac]tion' })
      vim.keymap.set('n', 'gd', '<CMD>Lspsaga goto_definition<cr>', { desc = 'LSP: [G]oto [D]efinition' })
      vim.keymap.set('n', 'gp', '<CMD>Lspsaga peek_definition<cr>', { desc = 'LSP: [P]eek definition' })
      vim.keymap.set('n', 'gtd', '<CMD>Lspsaga goto_type_definition<cr>', { desc = 'LSP: [G]oto [T]ype [D]efinition' })
      vim.keymap.set('n', 'gtp', '<CMD>Lspsaga peek_type_definition<cr>', { desc = 'LSP: [P]eek [T]ype definition' })
      vim.keymap.set('n', 'gr', '<CMD>Lspsaga finder<cr>', { desc = 'LSP: [G]oto [R]eferences' })

      -- --  This function gets run when an LSP connects to a particular buffer.
      -- local on_attach = function(_, bufnr)
      --   vim.keymap.set('n', ';rn', vim.lsp.buf.rename, { desc = 'LSP: [R]e[n]ame' })
      --   vim.keymap.set({ 'n', 'x' }, ';ri', ':Refactor inline_var')
      --   vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'LSP: [G]oto [I]mplementation' })
      --   vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'LSP: Type [D]efinition' })
      --   vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = 'LSP: [D]ocument [S]ymbols' })
      --   vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = 'LSP: [W]orkspace [S]ymbols' })
      --   -- See `:help K` for why this keymap
      --   vim.keymap.set('n', 'K', ':Lspsaga hover_doc<cr>', { desc = 'LSP: Hover Documentation' })
      --   -- Get information about parameters of a function when calling it
      --   vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Documentation' })
      --   -- Lesser used LSP functionality
      --   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: [G]oto [D]eclaration' })
      --   vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP: [W]orkspace [A]dd Folder' })
      --   vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'LSP: [W]orkspace [R]emove Folder' })
      --   vim.keymap.set('n', '<leader>wl', function()
      --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --   end, { desc = 'LSP: [W]orkspace [L]ist Folders' })
      -- end

      local servers = {
        -- rust_analyzer = {},
        -- gopls = {},
        -- asm_lsp = {},
        bashls = {},
        clangd = {},
        pyright = {},
        ts_ls = {},
        eslint = {},
        intelephense = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      -- Ensure the servers above are installed
      local lspconfig = require 'lspconfig'
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        -- automatic_enable = false,
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(config)
      end

      -- Setup neovim lua configuration
      require('neodev').setup()
    end,
  },

  {
    'simrat39/symbols-outline.nvim',
    cmd = { 'SymbolsOutline' },
    opts = {},
  },
}
