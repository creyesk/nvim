-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    {
      'antosha417/nvim-lsp-file-operations',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = true,
    },
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'File [E]xplorer' },
    { '-', '<cmd>Neotree reveal<cr>', desc = 'Reveal file in tree' },
  },
  opts = {
    window = {
      width = 'fit_content',
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none', -- disable space so leader key works
      },
    },
    event_handlers = {
      {
        event = 'file_open_requested',
        handler = function()
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = { enabled = true },
    },
    default_component_configs = {
      icon = {
        folder_closed = vim.g.have_nerd_font and '' or '>',
        folder_open = vim.g.have_nerd_font and '' or 'v',
        folder_empty = vim.g.have_nerd_font and '' or '>',
        default = vim.g.have_nerd_font and '' or '*',
      },
      git_status = {
        symbols = vim.g.have_nerd_font and {} or {
          added = '+',
          modified = '~',
          deleted = 'x',
          renamed = 'r',
          untracked = '?',
          ignored = '/',
          unstaged = 'U',
          staged = 'S',
          conflict = '!',
        },
      },
    },
  },
}
