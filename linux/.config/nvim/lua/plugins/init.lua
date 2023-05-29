require("plugins.dap")
require("plugins.treesitter")
require('pqf').setup()
require('session_manager').setup({
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
})

-- require("nvim-tree").setup()
require('vgit').setup()
require('git-conflict').setup()
require('numb').setup()
require("which-key").setup()

require('competitest').setup({
  -- output_compare_method = "exact",
  compile_command = {
    c = { exec = "gcc", args = { "-DSAWALHY", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
    cpp = { exec = "g++", args = { "-DSAWALHY", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
    rust = { exec = "rustc", args = { "$(FNAME)" } },
    java = { exec = "javac", args = { "$(FNAME)" } },
  },
  default_language_ext = "cpp",
  use_flexible_directories = false,
  contests_directory = "~/myp/problem-solving",
  template_file = "~/myp/problem-solving/template.$(FEXT)",
})

-- require('neoscroll').setup()
-- require('bufferline').setup()
-- require("lualine").setup{
--   -- section_separators = { left = '', right = '' },
--   -- component_separators = { left = '', right = '' },
--   section_separators = { left = '', right = '' },
--   component_separators = { left = '', right = '' },
-- }

require("todo-comments").setup()
require("true-zen").setup({
  misc = { ui_elements_commands = true }
})

require("neotest").setup({
  adapters = {
    -- require('neotest-jest'),
    require("neotest-python"),
    require("neotest-vim-test")({ allow_file_types = {} }),
  }
})

-- lukas-reineke/indent-blankline.nvim
-- ----------------------------------------

vim.opt.listchars = {
  -- space = ".",
  -- eol = "↴",
  -- tab = "→ ",
  eol = "¬",
  tab = "▸ ",
}

require("indent_blankline").setup {
  -- space_char_blankline = " ",
  char_list = { "┆" --[[ "│", "¦", "┆", "┊" ]] },
  filetype_exclude = { "terminal", "CHADTree", "startify" },
  use_treesitter = true,
  show_end_of_line = true,
  show_current_context = true,
  show_first_indent_level = false,
  -- show_trailing_blankline_indent = false,
}

-- numToStr/Comment.nvim
-- ----------------------------------------

require("Comment").setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

-- NMAC427/guess-indent.nvim
-- ----------------------------------------

require('guess-indent').setup {}
