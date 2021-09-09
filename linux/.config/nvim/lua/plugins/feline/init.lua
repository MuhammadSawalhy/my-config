-- source: https://github.com/olimorris/dotfiles/blob/master/.config/nvim/lua/plugins/configs/statusline.lua

local M = {}
local lsp = require('feline.providers.lsp')
local git = require('feline.providers.git')
local vi_mode_utils = require('feline.providers.vi_mode')

-- Setup Feline.nvim properties
M.properties = {
    force_inactive = {
        filetypes = {},
        buftypes = {},
        bufnames = {}
    }
}
M.components = {
    active = {},
    inactive = {}
}

-- Determine if we're using a session file
local function using_session() return (vim.g.using_persistence ~= nil) end

-- Determine if there is enough space in the window to display components
local function there_is_width()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 50 then
        return true
    end
    return false
  end

function M.setup()
    local present, feline = pcall(require, 'feline')
    if not present then
        return
    end

    feline.reset_highlights()
    local c = require("colors").get("onedark")

    M.properties.force_inactive.filetypes = {
        'packer',
        'NvimTree',
        'floaterm',
        'dap-repl',
        'toggleterm',
        'LspTrouble',
        'alpha'
    }

    M.properties.force_inactive.buftypes = {
        'terminal'
    }

    M.vi_mode_colors = {
        NORMAL = c.green,
        OP = c.green,
        INSERT = c.blue,
        VISUAL = c.purple,
        BLOCK = c.purple,
        REPLACE = c.red,
        ['V-REPLACE'] = c.red,
        ENTER = 'cyan',
        MORE = 'cyan',
        SELECT = 'orange',
        COMMAND = c.green,
        SHELL = c.green,
        TERM = c.green,
        NONE = c.black
    }
---------------------------------COMPONENTS--------------------------------- {{{
    -- Left
    M.components.active[1] = {
        {
            provider = ' ',
            hl = function()
                local val = {}
                val.bg = vi_mode_utils.get_mode_color()
                val.fg = 'NONE'
                return val
            end,
            right_sep = ''
        },
        {
            provider = 'file_info',
            hl = {
                fg = c.gray,
                bg = 'NONE',
            },
            left_sep = ' ',
        },
        {
            provider = '>',
            enabled = function()
                return lsp.is_lsp_attached() and there_is_width() 
            end,
            hl = {
                fg = c.gray,
            },
        },
        {
            provider = 'diagnostic_errors',
            enabled = function() return lsp.diagnostics_exist('Error') and there_is_width() end,
            hl = {
                fg = c.red,
            },
        },
        {
            provider = 'diagnostic_warnings',
            enabled = function() return lsp.diagnostics_exist('Warning') and there_is_width() end,
            hl = {
                fg = c.yellow,
            },
        },
        {
            provider = 'diagnostic_hints',
            enabled = function() return lsp.diagnostics_exist('Hints') and there_is_width() end,
            hl = {
                fg = c.cyan,
            },
        },
        {
            provider = 'diagnostic_info',
            enabled = function() return lsp.diagnostics_exist('Information') and there_is_width() end,
            hl = {
                fg = c.blue,
            },
            left_sep = { -- Only enable if we have errors or warnings before this
                str = ' ',
                enabled = function() return lsp.diagnostics_exist('Error') or lsp.diagnostics_exist('Warning') or lsp.diagnostics_exist('Hints') end,
            }
        },
        {
            provider = 'lsp_client_names',
            enabled = function()
                return lsp.is_lsp_attached() and there_is_width()
            end,
            icon = '',
            hl = {
                fg = c.gray,
                bg = 'NONE',
            },
            left_sep = {
                str = ' [LSP: ',
                hl = {
                    fg = c.gray,
                    bg = 'NONE',
                }
            },
            right_sep = {
                str = ']',
                hl = {
                    fg = c.gray,
                    bg = 'NONE',
                }
            }
        }
    }
    -- Right
    M.components.active[2] = {
        {
            provider = function()
                if using_session() then
                    return '  | '
                else
                    return '  | '
                end
            end,
            enabled = function()
                return using_session() and there_is_width()
            end,
            hl = {
                fg = c.gray,
            }
        },
        {
            provider = 'git_branch',
            enabled = function()
                return there_is_width()
            end,
            hl = {
                fg = c.gray,
            }
        },
        {
            provider = 'git_diff_added',
            enabled = function()
                return there_is_width()
            end,
            icon = ' +',
            hl = {
                fg = c.green,
            }
        },
        {
            provider = 'git_diff_changed',
            enabled = function()
                return there_is_width()
            end,
            icon = ' ~',
            hl = {
                fg = c.yellow,
            }
        },
        {
            provider = 'git_diff_removed',
            enabled = function()
                return there_is_width()
            end,
            icon = ' -',
            hl = {
                fg = c.red,
            }
        },
        {
            provider = ' | ',
            enabled = function()
                return vim.b.gitsigns_status_dict ~= nil and there_is_width()
            end,
            hl = {
                fg = c.gray,
            },
        },
        {
            provider = 'line_percentage',
            hl = {
                fg = c.gray,
            },
            right_sep = ' ' 
        },
        {
            provider = 'scroll_bar',
            hl = {
                fg = c.gray,
            }
        }
    }
---------------------------------------------------------------------------- }}}
    feline.setup({
        preset = 'noicon',
        default_fg = c.fg,
        default_bg = c.bg,
        vi_mode_colors = M.vi_mode_colors,
        components = M.components,
        properties = M.properties
    })
end

return M
