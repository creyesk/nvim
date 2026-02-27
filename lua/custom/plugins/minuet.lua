return {
  'milanglacier/minuet-ai.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('minuet').setup {
      -- Enable Copilot-style ghost text
      virtualtext = {
        auto_trigger_ft = { '*' }, -- Triggers automatically in all filetypes
        keymap = {
          accept = '<A-y>', -- Alt+y to accept the whole suggestion
          accept_line = '<A-a>', -- Alt+a to accept line-by-line (great for long snippets)
          prev = '<A-[>', -- Alt+[ to cycle to previous suggestion
          next = '<A-]>', -- Alt+] to cycle to next suggestion
          dismiss = '<A-e>', -- Alt+e to dismiss
        },
      },
      provider = 'ollama',
      provider_options = {
        ollama = {
          -- Update this to match the exact model you pulled in Step 2!
          model = 'qwen2.5-coder:3b',
          end_point = 'http://127.0.0.1:11434/api/generate',
          stream = true,
        },
      },
    }
  end,
}
