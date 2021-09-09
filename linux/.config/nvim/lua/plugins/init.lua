require("plugins.dap")
require("plugins.treesitter")

require('vgit').setup()
require('numb').setup()
-- require("bufferline").setup{}
-- require('neoscroll').setup()
require("todo-comments").setup()
require("true-zen").setup({
  misc = { ui_elements_commands = true }
})

-- lukas-reineke/indent-blankline.nvim
-- ----------------------------------------

vim.opt.listchars = {
  -- space = ".",
  eol = "↴",
}

require("indent_blankline").setup {
  -- space_char_blankline = " ",
  char_list = { "│", "¦", "┆", "┊" },
  filetype_exclude = { "terminal", "CHADTree", "startify" },
  use_treesitter = true,
  show_end_of_line = true,
  show_current_context = true,
  show_first_indent_level = false,
  -- show_trailing_blankline_indent = false,
}

-- hoob3rt/lualine.nvim
-- ----------------------------------------

-- require("plugins/lualine/evil_lualine")
require('lualine').setup({
  options = {
    theme = 'palenight',
    component_separators = {'|', '|'},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  extensions = { "chadtree", "fzf" }
})

-- b3nj5m1n/kommentary
-- ----------------------------------------

require('kommentary.config').use_extended_mappings()
require('kommentary.config').configure_language('default', {
  single_line_comment_string = 'auto',
  multi_line_comment_strings = 'auto',
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})
