-- Set <space> as the leader key
-- NOTE: should be before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    keys = { "gc", { "<C-_>", mode = { "n", "x" } }, },
    config = function()
      require("Comment").setup()
      vim.cmd([[nmap <C-_> gcc]])
      vim.cmd([[xmap <C-_> gc]])
    end
  },

  {
    "Pocco81/true-zen.nvim",
    keys = {
      { "<leader>zn", ":TZNarrow<CR>",     {} },
      { "<leader>zf", ":TZFocus<CR>",      {} },
      { "<leader>zm", ":TZMinimalist<CR>", {} },
      { "<leader>za", ":TZAtaraxis<CR>",   {} },
      { mode = "v",   "<leader>zn",        ":'<,'>TZNarrow<CR>", {} },
    }
  },

  {
    'tpope/vim-surround',
    keys = { "ys", { mode = "v", "S" } },
    opts = {},
  },

  { 'windwp/nvim-autopairs', },

  { 'famiu/bufdelete.nvim',   cmd = { 'Bdelete', 'Bwipeout' } },
  { 'mg979/vim-visual-multi', branch = 'master' },

  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { "x", "n" } }
    }
  },

  {
    'mbbill/undotree',
    config = function()
      vim.opt.undodir = vim.fn.stdpath 'data' .. '/undotree'
    end
  },

  {
    'fedepujol/move.nvim',
    cmd = 'Move',
    keys = {
      { '<A-j>', ':MoveLine(1)<CR>',    mode = 'n', silent = true },
      { '<A-k>', ':MoveLine(-1)<CR>',   mode = 'n', silent = true },
      { '<A-j>', ':MoveBlock(1)<CR>',   mode = 'v', silent = true },
      { '<A-k>', ':MoveBlock(-1)<CR>',  mode = 'v', silent = true },
      { '<A-l>', ':MoveHChar(1)<CR>',   mode = 'n', silent = true },
      { '<A-h>', ':MoveHChar(-1)<CR>',  mode = 'n', silent = true },
      { '<A-l>', ':MoveHBlock(1)<CR>',  mode = 'v', silent = true },
      { '<A-h>', ':MoveHBlock(-1)<CR>', mode = 'v', silent = true },
    }
  },

  {
    'tanvirtin/vgit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "VGit",
    opts = {},
  },

  {
    'justinmk/vim-sneak',
    keys = {
      { 'f', '<Plug>Sneak_f' },
      { 'F', '<Plug>Sneak_F' },
      { 't', '<Plug>Sneak_t' },
      { 'T', '<Plug>Sneak_T' },
    },
  },

  { import = 'plugins' },
}, {})

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
-- vim.o.clipboard = 'unnamedplus'

-- Disable wrap
vim.o.wrap = false

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Padding in top and bottom while move up and down in the buffer
vim.o.scrolloff = 10

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- copy to clipboard
function CopyBuffer()
  if vim.fn.executable("clip.exe") then
    vim.cmd('silent write !clip.exe')
    print("Buffer is copied")
  elseif vim.fn.executable("xsel") then
    vim.cmd('silent write !xsel -ib')
    print("Buffer is copied")
  elseif vim.fn.executable("xclip") then
    vim.cmd('silent write !xclip -sel clip')
    print("Buffer is copied")
  else
    vim.cmd.echoerr("Can't find a clip program, please install xsel or xclip!")
  end
end

vim.keymap.set('x', ';y', '"+y', { desc = "Copy selection to sys clipboard" })
vim.keymap.set('n', ';wc', CopyBuffer, { desc = "Copy current buffer to sys clipboard" })
vim.keymap.set('x', 'gsw', "'<,'> ! awk '{ print length(), $0 } | sort -n | cut -d\\  -f2-'<CR><ESC>",
  { desc = "Sort selected lines by line width" })

-- easily move in wrapped lines
vim.keymap.set('n', 'j', "v:count ? 'j' : 'gj'", { silent = true, expr = true })
vim.keymap.set('n', 'k', "v:count ? 'k' : 'gk'", { silent = true, expr = true })

-- navigate windows
vim.keymap.set({ 'n', 'i', 'v' }, '<C-l>', '<C-w>l', {})
vim.keymap.set({ 'n', 'i', 'v' }, '<C-h>', '<C-w>h', {})
vim.keymap.set({ 'n', 'i', 'v' }, '<C-j>', '<C-w>j', {})
vim.keymap.set({ 'n', 'i', 'v' }, '<C-k>', '<C-w>k', {})

-- navigate tabs
vim.keymap.set('n', '<tab>n', ':tabnew<Space>', {})
vim.keymap.set('n', '<tab>l', ':tabnext<CR>', {})
vim.keymap.set('n', '<tab>h', ':tabprevious<CR>', {})

-- delete without yanking
vim.keymap.set('n', ';d', '"_d', {})
vim.keymap.set('n', ';c', '"_c', {})
vim.keymap.set('n', ';D', '"_D', {})
vim.keymap.set('v', ';d', '"_d', {})
vim.keymap.set('v', ';c', '"_c', {})
vim.keymap.set('v', ';D', '"_D', {})
vim.keymap.set('v', ';p', '"_dP', {})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
