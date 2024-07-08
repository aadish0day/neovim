require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "html", "java", "javascript", "bash" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- Enable indentation based on Treesitter
    indent = {
        enable = true
    },

    -- Add `modules` as an empty table if not used
    modules = {},

    -- Specify parsers to ignore during installation (empty if none)
    ignore_install = {}
}
