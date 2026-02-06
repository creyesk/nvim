-- Terminal Plugin

-- Run commands per filetype (add more as needed)
local runners = {
  go = 'go run %s',
  python = 'python %s',
  javascript = 'node %s',
  typescript = 'npx tsx %s',
  lua = 'lua %s',
  sh = 'bash %s',
  bash = 'bash %s',
  rust = 'cargo run',
}

local function open_terminal_right()
  vim.cmd 'vsplit | wincmd L | terminal'
  vim.cmd 'startinsert'
end

local function run_file()
  local file = vim.fn.expand '%:p'
  local ft = vim.bo.filetype
  local runner = runners[ft]

  if not runner then
    vim.notify('No runner configured for filetype: ' .. ft, vim.log.levels.WARN)
    return
  end

  vim.ui.input({ prompt = 'Env vars (KEY=val;KEY2=val2): ' }, function(env_input)
    if env_input == nil then
      return
    end

    vim.ui.input({ prompt = 'Args: ' }, function(args_input)
      if args_input == nil then
        return
      end

      -- Build env prefix
      local env_prefix = ''
      if env_input ~= '' then
        local parts = {}
        for pair in env_input:gmatch '[^;]+' do
          table.insert(parts, vim.trim(pair))
        end
        env_prefix = table.concat(parts, ' ') .. ' '
      end

      -- Build command
      local cmd = env_prefix .. string.format(runner, vim.fn.shellescape(file))
      if args_input ~= '' then
        cmd = cmd .. ' ' .. args_input
      end

      vim.cmd 'vsplit | wincmd L'
      vim.cmd('terminal ' .. cmd)
      vim.cmd 'startinsert'
    end)
  end)
end

return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/plugins',
  name = 'terminal',
  config = function()
    vim.keymap.set('n', '<leader>tt', open_terminal_right, { desc = '[T]erminal (right split)' })
    vim.keymap.set('n', '<leader>tr', run_file, { desc = '[T]erminal: [R]un file' })
  end,
}
