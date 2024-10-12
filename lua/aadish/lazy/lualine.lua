return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local devicons = require("nvim-web-devicons")

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        function()
                            local relpath = vim.fn.expand("%:.")
                            local icon, icon_color = devicons.get_icon(relpath, vim.fn.expand("%:e"))
                            return (icon and icon_color)
                                and string.format("%%#%s#%s %%#Normal#%s", icon_color, icon, relpath)
                                or relpath
                        end,
                    },
                    lualine_x = {
                        "fileformat",
                        "filetype",
                        function()
                            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                            if #clients > 0 then
                                local lsp_names = {}
                                for _, client in ipairs(clients) do
                                    table.insert(lsp_names, client.name)
                                end
                                return " LSP: " .. table.concat(lsp_names, ", ")
                            else
                                return ""
                            end
                        end,
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        function()
                            local relpath = vim.fn.expand("%:.")
                            local icon, icon_color = devicons.get_icon(relpath, vim.fn.expand("%:e"))
                            return (icon and icon_color)
                                and string.format("%%#%s#%s %%#Normal#%s", icon_color, icon, relpath)
                                or relpath
                        end,
                    },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}

