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
    auto_install = true,
})

-- Setup capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup nvim-lspconfig with default configurations through mason-lspconfig's setup_handlers
require("mason-lspconfig").setup_handlers({
    -- Default handler for all servers
    function(server_name)
        require("lspconfig")[server_name].setup({
            flags = { debounce_text_changes = 150 },
            capabilities = capabilities
        })
    end,
    -- Custom setup for Lua language server
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                        }
                    },
                    telemetry = { enable = false },
                }
            },
            flags = { debounce_text_changes = 150 },
            capabilities = capabilities
        })
    end,
})
