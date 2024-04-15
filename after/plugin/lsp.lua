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
    function(server_name) -- default handler for all other servers
        require("lspconfig")[server_name].setup({})
    end,
    -- Custom configuration for Lua language server
    ["lua_ls"] = function()
        require("lspconfig")["lua_ls"].setup({
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        -- Do not send telemetry data containing a randomized but unique identifier
                        enable = false,
                    },
                },
            },
        })
    end,
})
