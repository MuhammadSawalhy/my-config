return function()
  -- see: https://www.reddit.com/r/neovim/comments/oo97pq/how_to_get_the_visual_selection_range/h5xiuyn?utm_source=share&utm_medium=web2x&context=3
  -- see: https://github.com/theHamsta/nvim-treesitter/blob/a5f2970d7af947c066fb65aef2220335008242b7/lua/nvim-treesitter/incremental_selection.lua#L22-L30
  vim.cmd('noau normal! "vy"')
  return vim.fn.getreg('v')
end
