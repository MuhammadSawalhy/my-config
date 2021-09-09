local M = {}

-- if a theme is given, then load it, otherwise use onedark
M.init = function(theme)
   if not theme then
      theme = 'onedark'
   end

   -- set the global theme, used at various places throughout the config
   vim.g.theme = theme

   local onedark = require('onedark')
    onedark.setup({
        theme = vim.g.theme,
        styles = {
            comments = "italic",
            keywords = "bold,italic",
        }
    })
    onedark.load()
end

-- returns a table of colors for the given or current theme
M.get = function(theme)
   if not theme then
      theme = vim.g.theme
   end

   return require("colors.themes." .. theme)
end

return M
