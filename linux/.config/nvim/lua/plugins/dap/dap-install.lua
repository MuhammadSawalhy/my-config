local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

dap_install.setup({
  installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

local is_windows = function()
    return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
end

local get_python_path =  function()
  local venv_path = os.getenv('VIRTUAL_ENV')
  if venv_path then
    if is_windows() then
      return venv_path .. '\\Scripts\\python.exe'
    end
    return venv_path .. '/bin/python'
  end
  return nil
end

dap_install.config("python", {
  adapters = {
    type = "executable",
    command = vim.fn.expand("~/.virtualenvs/debugpy/bin/python"),
    args = {"-m", "debugpy.adapter"},
    enrich_config = function(config, on_config)
      if not config.pythonPath and not config.python then
        config.pythonPath = get_python_path()
      end
      on_config(config)
    end
  },
  configurations = {
    {
      type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch';
      name = "Launch file";
      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
      program = "${file}";
    },
    {
      type = 'python';
      request = 'launch';
      name = 'Launch file with arguments';
      program = '${file}';
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end;
    }
  }
})
