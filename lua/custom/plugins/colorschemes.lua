-- Additional colorschemes for easy switching
-- Use :Telescope colorscheme to preview and switch themes

-- Auto-set background for themes that depend on it
vim.api.nvim_create_autocmd('ColorSchemePre', {
  pattern = { 'gruvbox-material', 'everforest', 'seoul256', 'gruvbox' },
  callback = function()
    vim.o.background = 'light'
  end,
})

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
    lazy = true,
    opts = {},
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

  -- Light-friendly colorschemes
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Load before other plugins since it's the default
    config = function()
      require('kanagawa').setup {
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
      }
      vim.cmd.colorscheme 'kanagawa-lotus'
    end,
    -- Variants: kanagawa-wave (dark), kanagawa-dragon (dark), kanagawa-lotus (light)
  },

  {
    'neanias/everforest-nvim',
    lazy = true,
    config = function()
      require('everforest').setup {
        italics = false,
        background = 'soft', -- soft, medium, hard
      }
    end,
    -- Use: vim.o.background = 'light' then :colorscheme everforest
  },

  {
    'sainnhe/gruvbox-material',
    lazy = true,
    config = function()
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_background = 'soft' -- soft, medium, hard
    end,
    -- Use: vim.o.background = 'light' then :colorscheme gruvbox-material
  },

  {
    'projekt0n/github-nvim-theme',
    lazy = true,
    config = function()
      require('github-theme').setup {
        options = {
          styles = {
            comments = 'NONE',
            keywords = 'NONE',
          },
        },
      }
    end,
    -- Variants: github_light, github_light_default, github_light_high_contrast,
    --           github_dark, github_dark_default, github_dark_dimmed, github_dark_high_contrast
  },

  {
    'shaunsingh/seoul256.nvim',
    lazy = true,
    config = function()
      vim.g.seoul256_italic_comments = false
      vim.g.seoul256_italic_keywords = false
    end,
    -- Use: vim.o.background = 'light' then :colorscheme seoul256
  },
}
