return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "j-hui/fidget.nvim",
            "onsails/lspkind-nvim",
        },
        config = function()
            -- Mason setup
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            -- Mason LSP setup
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "clangd",
                    "cssls",
                    "html",
                    "jdtls",
                    "ts_ls",
                    "pyright",
                    "tinymist",
                },
                automatic_installation = true,
            })

            -- Null-LS setup
            require("mason-null-ls").setup({
                ensure_installed = {
                    "shfmt",
                    "stylua",
                    "black",
                },
                automatic_installation = true,
            })

            -- Keymapping to open Mason
            vim.keymap.set("n", "<leader>m", ":Mason<CR>", { silent = true })

            require("fidget").setup({})

            -- LSP capabilities
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- on_attach function
            local on_attach = function(client, bufnr)
                print("Attached to LSP") -- Confirm LSP is attached
                local opts = { buffer = bufnr, noremap = true, silent = true }
                -- key mappings...
            end

            local lspconfig = require("lspconfig")
            local servers = { "html", "cssls", "ts_ls", "bashls", "clangd", }

            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end

            -- Setup for Java using jdtls
            lspconfig.jdtls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "jdtls" },
                root_dir = lspconfig.util.root_pattern("gradlew", "mvnw", ".git"),
            })

            -- Setup for Python LSP
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- Setup for Typst LSP using tinymist
            lspconfig.tinymist.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "tinymist" },
                filetypes = { "typst" },
                root_dir = lspconfig.util.root_pattern(".git", "."),
            })

            -- Special configuration for Lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            -- Snippet and completion setup
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_lua").load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-n>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    format = function(entry, item)
                        local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
                        item = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50,
                            ellipsis_char = "...",
                        })(entry, item)
                        if color_item.abbr_hl_group then
                            item.kind_hl_group = color_item.abbr_hl_group
                            item.kind = color_item.abbr
                        end
                        return item
                    end,
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
                },
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Diagnostics configuration
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
            })
            -- Autopairs setup for nvim-cmp
            -- lazy/aadish/lsp.lua

            -- Load the cmp and cmp_autopairs modules
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")

            -- Link cmp with nvim-autopairs
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            -- LSP key mapping configuration
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })
        end,
    },
}
