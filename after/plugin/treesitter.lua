require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all". Including Bash now.
    ensure_installed = { "c", "lua", "html", "java", "javascript", "bash" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

