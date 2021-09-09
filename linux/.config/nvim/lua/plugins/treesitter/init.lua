vim.opt.foldmethod = "expr"
vim.opt.foldexpr = vim.fn.eval("nvim_treesitter#foldexpr()")
vim.g.dap_virtual_text = true

local textobjects = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim 
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",

      -- Or you can define your own textobjects like this
      ["iF"] = {
        python = "(function_definition) @function",
        cpp = "(function_definition) @function",
        c = "(function_definition) @function",
        java = "(method_declaration) @function",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}

local playground = {
  enable = true,
  disable = {},
  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  persist_queries = false, -- Whether the query persists across vim sessions
  keybindings = {
    toggle_query_editor = 'o',
    toggle_hl_groups = 'i',
    toggle_injected_languages = 't',
    toggle_anonymous_nodes = 'a',
    toggle_language_display = 'I',
    focus_language = 'f',
    unfocus_language = 'F',
    update = 'R',
    goto_node = '<cr>',
    show_help = '?',
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  indent = { enable = true },
  rainbow = { enable = true },
  textobjects = textobjects,
  playground = playground,
  context_commentstring = {
    enable = false,
    enable_autocmd = false,
  },
  highlight = {
    -- see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1765
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("twilight").setup {}
require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }

-- require'treesitter-context'.setup{
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   throttle = true, -- Throttles plugin updates (may improve performance)
-- }
