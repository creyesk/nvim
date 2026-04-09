-- Database client using vim-dadbod
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    { '<leader>db', '<cmd>DBUIToggle<cr>', desc = '[D]ata[b]ase UI' },
    { '<leader>da', '<cmd>DBUIAddConnection<cr>', desc = '[D]atabase [a]dd connection' },
  },
  init = function()
    -- DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = 'left'
    vim.g.db_ui_winwidth = 35
    vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/dadbod_ui_queries'
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_execute_on_save = 0

    -- Remap query execution to <leader>de to avoid conflict with <leader>s (search)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'sql', 'mysql', 'plsql' },
      callback = function(args)
        vim.keymap.set('n', '<leader>de', '<Plug>(DBUI_ExecuteQuery)', { buffer = args.buf, desc = '[D]atabase [e]xecute query' })
        vim.keymap.set('v', '<leader>de', '<Plug>(DBUI_ExecuteQuery)', { buffer = args.buf, desc = '[D]atabase [e]xecute selection' })
        vim.keymap.set('n', '<leader>dw', '<Plug>(DBUI_SaveQuery)', { buffer = args.buf, desc = '[D]atabase save [w]rite query' })
      end,
    })
  end,
}
