---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  ft = { 'php' },
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    { '<F9>', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F11>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F12>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.adapters.php = {
      type = 'executable',
      command = vim.fn.exepath 'node',
      args = { vim.fn.stdpath 'data' .. '/php-debug/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        name = 'Listen for Xdebug',
        type = 'php',
        request = 'launch',
        hostname = '127.0.0.1',
        port = 9003,
      },
    }

    dapui.setup()

    dap.listeners.after.event_initialized.php_dapui = function() dapui.open() end
    dap.listeners.before.event_terminated.php_dapui = function() dapui.close() end
    dap.listeners.before.event_exited.php_dapui = function() dapui.close() end
  end,
}
