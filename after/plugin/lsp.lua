-- Set up mason.nvim
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Set up mason-lspconfig
require("mason-lspconfig").setup({
    -- List your LSP servers here
    ensure_installed = { 'tsserver', 'lua_ls', 'html', 'cssls', 'jdtls', 'bashls' },
    automatic_installation = true,
})

-- Setup nvim-lspconfig with default configurations
require("mason-lspconfig").setup_handlers({
    function(server_name) -- Default setup for all servers
        require("lspconfig")[server_name].setup({
            flags = { debounce_text_changes = 150 }
        })
    end,
    ["lua_ls"] = function() -- Custom setup for Lua language server
        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = {'vim'} },
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                        }
                    },
                    telemetry = { enable = false }
                }
            },
            flags = { debounce_text_changes = 150 }
        })
    end,
})

