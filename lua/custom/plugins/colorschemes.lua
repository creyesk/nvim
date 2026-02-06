-- Additional colorschemes for easy switching
-- Use :Telescope colorscheme to preview and switch themes
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    opts = {
      no_italic = true, -- Match your tokyonight style preference
    },
    -- Flavors: catppuccin-latte (light), catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha (darkest)
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000, -- Load before other plugins since it's the default
    config = function()
      require('rose-pine').setup {}
      vim.cmd.colorscheme 'rose-pine-dawn'
    end,
    -- Variants: rose-pine-main, rose-pine-moon, rose-pine-dawn (light)
  },

  {
    'Mofiqul/dracula.nvim',
    lazy = true,
    opts = {
      italic_comment = false,
    },
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = true,
    opts = {
      italic_comments = false,
      transparent = false,
    },
    -- Variants: cyberdream (dark), cyberdream-light
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
      },
    },
    -- Variants: gruvbox (follows background), set vim.o.background = 'dark' or 'light'
  },
}
