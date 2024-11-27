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
- **LSP Support:** Language Server Protocol integration for code navigation, diagnostics, and more.  
- **Git Integration:** Enhanced git workflows within Neovim.  
- **Fuzzy Finder:** Find files, buffers, and more with blazing speed.  
- **Beautiful UI:** Optimized themes, icons, and status lines for a pleasant experience.

## Customization
Feel free to fork, adapt, and personalize these configurations to suit your own workflow.

