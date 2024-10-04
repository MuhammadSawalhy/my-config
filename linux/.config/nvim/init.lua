-- Install package manager: https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'mg979/vim-visual-multi',
    priority = 1000,
    branch = 'master',
    config = function()
      vim.cmd [[
        let g:VM_maps["Switch Mode"] = '<C-s>'
      ]]
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    priority = 1001,
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

}, {})
