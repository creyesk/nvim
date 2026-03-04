return {
  'milanglacier/minuet-ai.nvim',
  config = function()
    require('minuet').setup {
      debounce = 50,
      request_timeout = 2.5,
      provider = 'openai_fim_compatible',
      provider_options = {
        openai_fim_compatible = {
          model = 'qwen2.5-coder:7b',
          end_point = 'http://localhost:11434/v1/completions',
          api_key = 'TERM',
          name = 'Ollama',
          stream = true,
          -- Fixed: Minuet expects these as functions, not strings
          template = {
            prefix = function() return '<|fim_prefix|>' end,
            suffix = function() return '<|fim_suffix|>' end,
            middle = function() return '<|fim_middle|>' end,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = {},
        keymap = {
          accept = '<A-y>',
          accept_line = '<A-a>',
          prev = '<A-k>',
          next = '<A-j>',
          dismiss = '<A-n>',
        },
      },
    }

    -- Toggle minuet suggestions on/off with <leader>ta
    vim.keymap.set('n', '<leader>ta', function()
      require('minuet.virtualtext').action.toggle_auto_trigger()
    end, { desc = '[T]oggle Minuet [A]I suggestions' })
  end,
}
