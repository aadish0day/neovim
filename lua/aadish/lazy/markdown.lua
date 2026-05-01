return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = { "markdown", "obsidian" },
        ---@module 'render-markdown'
        ---@type render-markdown.Config
        opts = {
            -- GitHub-like aesthetics
            heading = {
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
            code = {
                sign = false,
                width = 'block',
                right_pad = 1,
            },
            checkbox = {
                enabled = true,
                unchecked = { icon = '󰄱 ' },
                checked = { icon = '󰄵 ' },
            },
        },
    },
}
