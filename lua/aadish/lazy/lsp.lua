return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
            "rafamadriz/friendly-snippets",
            "j-hui/fidget.nvim",
        },
        config = function()
            -- Set up mason.nvim
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            -- Set up mason-tool-installer
            require("mason-tool-installer").setup({
                ensure_installed = { 'shfmt' },
                auto_update = true,
                run_on_start = true,
                start_delay = 3000, -- 3 second delay
                debounce_hours = 5, -- at least 5 hours between attempts to install/update
                integrations = {
                    ['mason-lspconfig'] = true,
                    ['mason-null-ls'] = true,
                    ['mason-nvim-dap'] = true,
                },
            })

            require('fidget').setup {}

            -- Set up mason-lspconfig
            require("mason-lspconfig").setup({
                ensure_installed = { 'lua_ls', 'html', 'cssls', 'jdtls', 'bashls', 'clangd' },
                auto_install = true,
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local function on_attach(client, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        flags = { debounce_text_changes = 150 },
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = { globals = { 'vim' } },
                                runtime = { version = 'LuaJIT' },
                                workspace = {
                                    library = {
                                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                                    },
                                },
                                telemetry = { enable = false },
                            },
                        },
                        flags = { debounce_text_changes = 150 },
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
            })

            -- Set up luasnip and nvim-cmp
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            -- Load VSCode-format snippets, excluding certain snippets if specified
            require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
            require("luasnip.loaders.from_vscode").lazy_load { paths = "your path!" }
            require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

            -- Load SnipMate-format snippets using default paths
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

            -- Load Lua-format snippets using default paths
            require("luasnip.loaders.from_lua").load()
            require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

            -- Autocommand to unlink snippets when leaving insert mode
            vim.api.nvim_create_autocmd("InsertLeave", {
                callback = function()
                    if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and not require("luasnip").session.jump_active then
                        require("luasnip").unlink_current()
                    end
                end,
            })

            -- Function to define border style
            local function border(hl_name)
                return {
                    { "╭", hl_name },
                    { "─", hl_name },
                    { "╮", hl_name },
                    { "│", hl_name },
                    { "╯", hl_name },
                    { "─", hl_name },
                    { "╰", hl_name },
                    { "│", hl_name },
                }
            end

            -- Configure nvim-cmp
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                window = {
                    completion = cmp.config.window.bordered({
                        border = border("CmpBorder"),
                    }),
                    documentation = cmp.config.window.bordered({
                        border = border("CmpDocBorder"),
                    }),
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })

            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Use the latest released major version
        build = "make install_jsregexp",
    },
}
