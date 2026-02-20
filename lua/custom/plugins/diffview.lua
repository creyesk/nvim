-- Diffview: tabpage interface for cycling through diffs
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  keys = {
    { '<leader>hv', '<cmd>DiffviewOpen<cr>', desc = 'git diff [v]iew' },
    { '<leader>hf', '<cmd>DiffviewFileHistory %<cr>', desc = 'git [f]ile history' },
    { '<leader>hF', '<cmd>DiffviewFileHistory<cr>', desc = 'git repo history ([F]ull)' },
    { '<leader>hq', '<cmd>DiffviewClose<cr>', desc = 'git diff [q]uit' },
  },
}
