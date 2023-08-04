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
  { 'folke/which-key.nvim',   opts = {} },

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
    config = function()
      local comment = require("Comment")
      local api = require("Comment.api")
      comment.setup()
      vim.cmd([[nmap <C-_> gcc]])
      vim.cmd([[xmap <C-_> gc]])
    end
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    opt = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    },
    config = function()
      pcall(require('telescope').load_extension, 'fzf')
      vim.keymap.set('n', '<leader>O', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader>o', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>p', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end
  },

  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      -- use native J to join lines
      vim.keymap.set('n', 'gj', ':SplitjoinJoin<CR>', {})
      vim.keymap.set('n', 'gk', ':SplitjoinSplit<CR>', {})
    end
  },

  {
    "Pocco81/true-zen.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
      vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})
    end
  },

  { 'jiangmiao/auto-pairs' },
  { 'tpope/vim-surround' },
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
    cmd = 'UndotreeToggle',
    config = function()
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
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
    'AndrewRadev/splitjoin.vim',
    keys = {
      { "gj", vim.cmd.SplitjoinJoin },
      { "gk", vim.cmd.SplitjoinSplit },
    }
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

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      reveal = true,
      source_selector = {
        winbar = true,
        statusline = true
      },
      window = { width = 25 },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", ":Neotree toggle<cr>", desc = "NeoTree" },
    }
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

-- Disable
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

vim.keymap.set('x', '<leader>y', '"+y', { desc = "Copy selection to sys clipboard" })
vim.keymap.set('n', '<leader>wc', CopyBuffer, { desc = "Copy current buffer to sys clipboard" })
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

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- delete without yanking
vim.keymap.set('n', '\\d', '"_d', {})
vim.keymap.set('n', '\\c', '"_c', {})
vim.keymap.set('n', '\\D', '"_D', {})
vim.keymap.set('v', '\\d', '"_d', {})
vim.keymap.set('v', '\\c', '"_c', {})
vim.keymap.set('v', '\\D', '"_D', {})
vim.keymap.set('v', '\\p', '"_dP', {})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
