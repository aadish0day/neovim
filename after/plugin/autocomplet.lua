local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- Loads VSCode-format snippets, excluding certain snippets if specified in the Neovim configuration
require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }

-- Loads VSCode-format snippets from a specified path
require("luasnip.loaders.from_vscode").lazy_load { paths = "your path!" }
require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

-- Loads SnipMate-format snippets using default paths
require("luasnip.loaders.from_snipmate").load()

-- Loads SnipMate-format snippets from specified paths lazily
require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

-- Loads Lua-format snippets using default paths
require("luasnip.loaders.from_lua").load()

-- Lazily loads Lua-format snippets from specified paths
require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }


vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and not require("luasnip").session.jump_active then
            require("luasnip").unlink_current()
        end
    end,
})

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
