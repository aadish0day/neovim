# Neovim Configuration

A full-featured Neovim config with LSP, AI, debugging, Obsidian integration, and a polished Tokyonight/Onedark UI.

## Features

- **LSP** — auto-installed servers for Lua, Python, TS, JS, Java, C/C++, HTML, CSS, Bash, Typst via Mason
- **Autocompletion** — nvim-cmp with LuaSnip snippets and lspkind icons
- **AI assistant** — gen.nvim with local Ollama + GitHub Copilot
- **Debugger** — nvim-dap with UI, Python support, and virtual text
- **Obsidian integration** — vault browsing, daily notes, wiki links, search
- **Telescope** — fuzzy finder with fzf-native for speed
- **Treesitter** — syntax highlighting for 15+ languages
- **Git** — gitsigns, fugitive, diffview
- **Formatting** — conform.nvim with per-language formatters
- **Themes** — Tokyonight (moon) and Onedark (deep, transparent)
- **Statusline** — lualine with diagnostics, git, LSP info
- **Typst preview** — live PDF preview with cursor sync

## Quick Start

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# Clone
git clone https://github.com/Aadishx07/neovim.git ~/.config/nvim

# Open Neovim — lazy.nvim auto-installs all plugins
nvim
```

## Prerequisites

- Neovim 0.9+
- Git, Node.js, Python 3
- ripgrep, fd (for Telescope)

## Keymaps

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>l` | Lazy plugin UI |
| `<leader>m` | Mason LSP UI |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `F2` | Rename |
| `F5` | Start debugger |
| `<leader>f` | Format buffer |

## Plugins

26 plugin modules in `lua/aadish/lazy/` covering LSP, completion, treesitter, telescope, dap, git, Obsidian, AI, formatting, theming, and more.

## Removal

```bash
rm -rf ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim
```
