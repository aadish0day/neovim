require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.formatting.clang_format,
    },
})
