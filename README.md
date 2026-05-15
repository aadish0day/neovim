# Neovim Configuration

A modern, feature-rich Neovim setup designed for productivity across multiple languages and frameworks.

## Prerequisites

| Dependency | Purpose |
|---|---|
| [Neovim](https://neovim.io) 0.9+ | Core editor |
| [Git](https://git-scm.com) | Plugin management |
| [Node.js](https://nodejs.org) | LSP servers & tooling |
| [Python 3](https://python.org) | LSP servers (pyright, debugger) |
| [Ripgrep](https://github.com/BurntSushi/ripgrep) | Telescope fuzzy search |
| [fd](https://github.com/sharkdp/fd) | Fast file finding |

## Installation

```bash
# Backup any existing configuration
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Clone the repository
git clone https://github.com/Aadishx07/neovim.git ~/.config/nvim

# Start Neovim — lazy.nvim installs all plugins automatically
nvim
```

## Uninstall

```bash
rm -rf ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim
```

## Features

### Editor
- **Autocompletion** — `nvim-cmp` with LSP, snippet, buffer, and path sources
- **Syntax Highlighting** — Treesitter across C, Lua, Python, JS/TS, HTML, CSS, Java, Bash, Markdown, YAML, JSON
- **Formatting** — `conform.nvim` auto-formats on keybind; supports stylua, ruff, prettier, clang-format, shfmt, typstyle
- **LSP** — Mason-managed servers for Lua, Python, JS/TS, Bash, C/C++, Java, HTML, CSS, Typst
- **Debugging** — `nvim-dap` with UI, virtual text, and Python support (F5/F10/F11/F12)

### UI
- **Theme** — Onedark (default) and Tokyonight themes with transparency
- **Statusline** — `lualine.nvim` showing mode, branch, diff, diagnostics, LSP clients, file path with icon
- **Bufferline** — Slanted tab separators with LSP diagnostics, modified indicators, close icons
- **File Explorer** — `nvim-tree.lua` (floating, <kbd>Ctrl+f</kbd>) and `oil.nvim` (<kbd>-</kbd>)
- **Indent Guides** — `mini.indentscope` with red scope indicator

### Navigation
- **Telescope** — File find, live grep, buffers, help tags, git files, fuzzy buffer search
- **Quickfix** — <kbd>Ctrl+k/j</kbd> for quickfix, <kbd>Leader+k/j</kbd> for location list

### Git
- **Gitsigns** — Inline git signs, blame, diff preview
- **Fugitive** — Git command interface
- **Diffview** — Side-by-side diff viewer

### Extras
- **Obsidian** — Vault integration with daily notes, wiki links, checkboxes, Telescope picker
- **Markdown Preview** — Live preview toggle
- **Typst Preview** — Live PDF preview for Typst files
- **AI** — `gen.nvim` (Ollama) and GitHub Copilot
- **Code Screenshots** — Carbon-now.nvim (<kbd>Leader+cn</kbd> in visual mode)
- **Live Server** — HTML live reload
- **Undotree** — Visual undo history
- **Which-key** — Keymap discovery popups

## Key Mappings

| Mode | Key | Action |
|---|---|---|
| `n` | `<Leader>ff` | Find files |
| `n` | `<Leader>fg` | Live grep |
| `n` | `<C-p>` | Git files |
| `n` | `<Leader>/` | Fuzzy search buffer |
| `n` | `<Leader>f` | Format buffer |
| `n` | `<Tab>` / `<S-Tab>` | Cycle buffers |
| `n` | `<Leader>q` | Close buffer |
| `n` | `<C-f>` | Toggle file explorer |
| `n` | `-` | Oil file explorer |
| `n` | `<Leader>l` | Lazy plugin manager |
| `n` | `<Leader>m` | Mason LSP manager |
| `n` | `<F5>` | Debug continue |
| `n` | `<F10>` | Debug step over |
| `n` | `<Leader>u` | Undotree toggle |

See `lua/aadish/remap.lua` and individual plugin configs for the full mapping list.

## Project Structure

```
~/.config/nvim
├── init.lua                 # Entry point
├── lazy-lock.json           # Plugin version lockfile
└── lua/aadish/
    ├── init.lua             # Module loader + yank highlight
    ├── set.lua              # Editor options
    ├── remap.lua            # Global keymaps
    ├── lazy_init.lua        # lazy.nvim bootstrap
    └── lazy/                # Plugin configurations
        ├── ai.lua           # gen.nvim, copilot
        ├── lsp.lua          # Mason, LSP, nvim-cmp, luasnip
        ├── treesitter.lua   # Treesitter + autotag
        ├── telescope.lua    # Telescope + fzf
        ├── bufferline.lua   # Bufferline tabs
        ├── lualine.lua      # Statusline
        ├── dap.lua          # Debugger
        ├── format.lua       # conform.nvim
        ├── git.lua          # gitsigns, fugitive, diffview
        ├── colour.lua       # Themes
        └── ...              # Other plugins
```
