require("plugins.dap")
require("plugins.treesitter")
require('session_manager').setup({
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
})

-- require("nvim-tree").setup()
require('vgit').setup()
require('numb').setup()

-- require("bufferline").setup{}
require('neoscroll').setup({ 
  easing_function = "quadratic",
})
require("todo-comments").setup()
require("true-zen").setup({
  misc = { ui_elements_commands = true }
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
  char_list = { "│"--[[ , "¦", "┆", "┊" ]] },
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
  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---@type table
  mappings = {
    ---Operator-pending mapping
    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---Extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
    ---Extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = true,
  },

  ---@param ctx Ctx
  pre_hook = function(ctx)
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})

-- terrortylor/nvim-comment
-- ----------------------------------------

-- require("nvim_comment").setup({
--   hook = function()
--     require("ts_context_commentstring.internal").update_commentstring()
--   end,
-- })
