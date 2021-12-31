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
-- require('lualine').setup({
--   options = {
--     theme = 'palenight',
--     component_separators = {'|', '|'},
--     section_separators = {'', ''},
--     disabled_filetypes = {}
--   },
--   extensions = { "chadtree", "fzf" }
-- })

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
    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
      local U = require('Comment.utils')

      -- Detemine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location,
      })
    end
  end,
})

-- terrortylor/nvim-comment
-- ----------------------------------------

-- require("nvim_comment").setup({
--   hook = function()
--     require("ts_context_commentstring.internal").update_commentstring()
--   end,
-- })
