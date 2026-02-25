# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal Neovim configuration based on kickstart.nvim. Single-file architecture centered on `init.lua` (~1050 lines) with modular plugin configs in `lua/`.

## Architecture

**init.lua** is the monolithic entry point containing: vim options, keymaps, autocommands, lazy.nvim bootstrap, and most plugin specs inline. Plugins that need more complex config are split into separate files loaded via `require()`.

**Plugin layout:**
- `lua/kickstart/plugins/` — Optional kickstart modules. Enable/disable by uncommenting `require` lines near the bottom of init.lua (~line 1004-1011).
- `lua/custom/plugins/` — Personal additions (colorschemes, diffview, terminal runner, vim-be-good).

**Plugin manager:** lazy.nvim with auto-bootstrap. Lock file at `lazy-lock.json`.

## Key Technical Decisions

- **Leader key:** Space
- **LSP servers:** gopls, rust_analyzer, lua_ls — configured via mason + lspconfig (init.lua ~line 532-714)
- **Completion:** blink.cmp with LuaSnip (not nvim-cmp)
- **Formatter:** conform.nvim — format-on-save enabled. Only stylua (Lua) configured; LSP fallback for other languages. C/C++ formatting explicitly disabled.
- **Test runner:** neotest with neotest-golang and neotest-rust adapters
- **Debugger:** nvim-dap with delve (Go) and codelldb (Rust/C++)
- **File explorer:** neo-tree.nvim
- **Tmux integration:** nvim-tmux-navigation for seamless Ctrl+hjkl pane switching

## Lua Style

Enforced by `.stylua.toml`:
- 2-space indent, single quotes preferred, no call parentheses, 160 column width
- Format with: `stylua .`

## Adding a New Plugin

1. For simple plugins: add the spec directly in the `require('lazy').setup({...})` table in init.lua
2. For complex plugins: create a file in `lua/custom/plugins/` returning a lazy.nvim spec table, then `require` it in init.lua's plugin list

## Adding a New LSP Server

1. Add the server name and config to the `servers` table (~line 634 in init.lua)
2. Add to `ensure_installed` in mason-tool-installer if mason should auto-install it (~line 674)
3. Add `vim.lsp.config()` and `vim.lsp.enable()` calls if the server needs special init logic (see lua_ls example ~line 688)
