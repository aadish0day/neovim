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

require("mason-tool-installer").setup({
    ensure_installed = { 'shfmt' }, -- specifying shfmt here
    auto_update = true,
    run_on_start = true
})

-- Set up mason-lspconfig
require("mason-lspconfig").setup({
    ensure_installed = { 'tsserver', 'lua_ls', 'html', 'cssls', 'jdtls', 'bashls', 'clangd' },
    auto_install = true,
})

-- Setup capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Define a function for handling LSP attachment to buffers, including keybindings
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

-- Setup nvim-lspconfig with default configurations through mason-lspconfig's setup_handlers
require("mason-lspconfig").setup_handlers({
    -- Default handler for all servers
    function(server_name)
        require("lspconfig")[server_name].setup({
            flags = { debounce_text_changes = 150 },
            capabilities = capabilities,
            on_attach = on_attach
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
            capabilities = capabilities,
            on_attach = on_attach
        })
    end,
})
