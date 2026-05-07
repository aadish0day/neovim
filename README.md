# Neovim Configuration

## Overview
A custom Neovim configuration tailored to enhance productivity and provide a streamlined development experience.

## Prerequisites
Ensure the following dependencies are installed:
- **Neovim** 0.9+  
- **Git**  
- **Node.js**  
- **Python 3**  
- **Ripgrep** (for fuzzy search)  
- **Fd** (a fast file finder)  

## Installation

### Quick Install
Clone the repository to your Neovim configuration directory:
```bash
git clone https://github.com/Aadishx07/neovim.git ~/.config/nvim
```

### Detailed Installation Steps
1. **Backup existing configuration (if any):**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/state/nvim ~/.local/state/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/Aadishx07/neovim.git ~/.config/nvim
   ```

3. **Install plugins:**
   - Open Neovim.  
   - The `lazy.nvim` plugin manager will automatically install all required plugins.  

## Removal

To completely remove this configuration:
```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

## Features
- **Intelligent Autocompletion:** Powered by LSP and completion plugins.  
- **Syntax Highlighting:** Modern and efficient with Treesitter.  
- **LSP Support:** Full integration for code navigation, hover documentation, and diagnostics.
- **Snazzy Bufferline:** A modern tabline with slanted separators, file icons, modified markers, and **real-time LSP diagnostics** integrated into each tab.
- **Git Integration:** Comprehensive git workflows, including signs, blame, and diff views.
- **Fuzzy Finder:** Telescope integration for finding files, grep searching, and buffer management.
- **Aesthetic UI:** Optimized for clarity and beauty with **Tokyonight** and **Onedark** themes, plus a customized **Lualine** status line.
- **Indent Guides & Scope:** Clean vertical indent lines with a high-visibility red scope indicator to track your current context.

## Customization
Feel free to fork, adapt, and personalize these configurations to suit your own workflow.

