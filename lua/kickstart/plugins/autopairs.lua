-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    npairs.setup(opts)

    -- Disable auto-closing of ' in Rust (conflicts with lifetime annotations like 'a, 'static)
    local Rule = require 'nvim-autopairs.rule'
    npairs.get_rules("'")[1].not_filetypes = { 'rust' }
  end,
}
