return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',

      {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'jose-elias-alvarez/null-ls.nvim', },
      },

      {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-treesitter/nvim-treesitter',
        },
        config = function()
          require('refactoring').setup({})
          require('telescope').load_extension('refactoring')

          vim.keymap.set(
            { 'n', 'x' },
            ';rr',
            require('telescope').extensions.refactoring.refactors,
            { desc = 'LSP: Refactor (telescope)' }
          )
        end,
      },

      -- Useful status updates for LSP
      -- TODO: move to the new version
      { 'j-hui/fidget.nvim',       tag = 'legacy' },

      -- Additional lua configuration!
      'folke/neodev.nvim',

      -- LSP UI
      {
        'nvimdev/lspsaga.nvim',
        config = function()
          require('lspsaga').setup({
            ui = {
              border = 'rounded',
            },
            symbol_in_winbar = {
              enable = false
            },
            lightbulb = {
              enable = false
            },
          })
        end
      },
    },
    config = function()
      -- Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', '<CMD>Lspsaga diagnostic_jump_prev<cr>',
        { desc = 'LSP: Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', '<CMD>Lspsaga diagnostic_jump_next<cr>', { desc = 'LSP: Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'LSP: Open diagnostics list' })

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        vim.keymap.set('n', ';rn', vim.lsp.buf.rename, { desc = 'LSP: [R]e[n]ame' })
        vim.keymap.set({ 'n', 'x' }, ';ri', ':Refactor inline_var')

        vim.keymap.set({ 'n', 'v' }, ';ac', '<CMD>Lspsaga code_action<cr>', { desc = 'LSP: Code [Ac]tion' })
        vim.keymap.set('n', 'gd', '<CMD>Lspsaga goto_definition<cr>', { desc = 'LSP: [G]oto [D]efinition' })
        vim.keymap.set('n', 'gp', '<CMD>Lspsaga peek_definition<cr>', { desc = 'LSP: [P]eek definition' })
        vim.keymap.set('n', 'gtd', '<CMD>Lspsaga goto_type_definition<cr>', { desc = 'LSP: [G]oto [T]ype [D]efinition' })
        vim.keymap.set('n', 'gtp', '<CMD>Lspsaga peek_type_definition<cr>', { desc = 'LSP: [P]eek [T]ype definition' })
        vim.keymap.set('n', 'gr', '<CMD>Lspsaga finder<cr>', { desc = 'LSP: [G]oto [R]eferences' })
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'LSP: [G]oto [I]mplementation' })
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'LSP: Type [D]efinition' })
        vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
          { desc = 'LSP: [D]ocument [S]ymbols' })
        vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
          { desc = 'LSP: [W]orkspace [S]ymbols' })

        -- See `:help K` for why this keymap
        vim.keymap.set('n', 'K', ':Lspsaga hover_doc<cr>', { desc = 'LSP: Hover Documentation' })
        -- Get information about parameters of a function when calling it
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Documentation' })

        -- Lesser used LSP functionality
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: [G]oto [D]eclaration' })
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP: [W]orkspace [A]dd Folder' })
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
          { desc = 'LSP: [W]orkspace [R]emove Folder' })
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = 'LSP: [W]orkspace [L]ist Folders' })

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format({
            timeout_ms = 5000,
          })
        end, { desc = 'LSP: Format current buffer with LSP' })
        vim.api.nvim_buf_create_user_command(bufnr, 'F', function(_)
          vim.lsp.buf.format({
            timeout_ms = 5000,
          })
        end, { desc = 'LSP: Format current buffer with LSP' })
      end

      local servers = {
        -- rust_analyzer = {},
        gopls = {},
        bashls = {},
        clangd = {},
        pyright = {},
        tsserver = {},
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

      -- Setup neovim lua configuration
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
      }

      require("mason-null-ls").setup({
        ensure_installed = { "ast_grep", "prettier", "black", "mypy", "shellcheck", "beautysh", },
        automatic_installation = true,
        handlers = nil,
      })

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      local null_ls = require('null-ls')

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.beautysh,
          null_ls.builtins.formatting.pint,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.shellcheck,
        },

        -- FORMAT ON SAVE
        --
        -- on_attach = function(client, bufnr)
        --   if client.supports_method("textDocument/formatting") then
        --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --       group = augroup,
        --       buffer = bufnr,
        --       callback = function()
        --         lsp_formatting(bufnr)
        --       end,
        --     })
        --   end
        -- end
      }

      vim.api.nvim_create_user_command(
        'DisableLspFormatting',
        function()
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
        end,
        { nargs = 0 }
      )
    end
  },

  {
    'simrat39/symbols-outline.nvim',
    cmd = { 'SymbolsOutline' },
    opts = {},
  },
}
