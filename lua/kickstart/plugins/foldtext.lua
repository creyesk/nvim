-- Custom foldtext that shows item count for arrays

return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    -- Clear default foldtext and clean fill character
    vim.o.foldtext = ''
    vim.opt.fillchars:append { fold = ' ' }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'json', 'javascript', 'typescript', 'lua', 'go', 'rust' },
      callback = function()
        vim.opt_local.foldtext = 'v:lua.CustomFoldText()'
      end,
    })

    function CustomFoldText()
      local start_line = vim.v.foldstart
      local end_line = vim.v.foldend
      local first_line = vim.fn.getline(start_line)
      local line_count = end_line - start_line + 1

      -- Try to count items using treesitter
      local item_count = nil
      local ok, parser = pcall(vim.treesitter.get_parser)
      if ok and parser then
        local tree = parser:parse()[1]
        if tree then
          local root = tree:root()
          -- Find the column of '[' on the fold line
          local bracket_col = first_line:find('%[')
          if bracket_col then
            bracket_col = bracket_col - 1 -- convert to 0-indexed
            local node = root:named_descendant_for_range(start_line - 1, bracket_col, start_line - 1, bracket_col + 1)
            while node do
              if node:type() == 'array' then
                local count = 0
                for child in node:iter_children() do
                  if child:named() then
                    count = count + 1
                  end
                end
                if count > 0 then
                  item_count = count
                end
                break
              end
              node = node:parent()
            end
          end
        end
      end

      -- Build the fold text
      local item_str = item_count and (' · %d items'):format(item_count) or ''
      return first_line .. ('  ⋯ %d lines%s '):format(line_count, item_str)
    end
  end,
}
